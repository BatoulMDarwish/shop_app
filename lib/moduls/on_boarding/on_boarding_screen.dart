
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/moduls/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';
import 'package:shop_app/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,

  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
 var boardController =PageController();

  List<BoardingModel> boarding=[
    BoardingModel(
        image: 'assets/images/mmm.png',
        title:'On Board 1 Tiltle' ,
        body: 'On Board 1 Body' ,
    ),
    BoardingModel(
      image: 'assets/images/mmm.png',
      title:'On Board 2 Tiltle' ,
      body: 'On Board 2 Body' ,
    ),
    BoardingModel(
      image: 'assets/images/mmm.png',
      title:'On Board 3 Tiltle' ,
      body: 'On Board 3 Body' ,
    ),
  ];

  void submit(){
    CachHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        navigateAndFinish(
            context,
            ShopLoginScreen());
      }
    });

  }

bool isLast=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed:(){
            submit();
              } ,
              child:const Text(
                'SKIP'
              ),
          )
        ],
      ),
     body:Padding(
       padding: const EdgeInsets.all(30.0),
       child: Column(
         children: [
           Expanded(
             child: PageView.builder(
             onPageChanged: (int index){
               if(index==boarding.length-1) {
                 setState(() {
                   isLast=true;
                 });
               }else{
                setState(() {
                  isLast=false;
                });
               }
             },
               controller: boardController,
               physics:const BouncingScrollPhysics() ,
                 itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                 itemCount:boarding.length,),
           ),
           const SizedBox(height: 40.0,),
           Row(
             children:  [
               SmoothPageIndicator(
               controller:boardController ,
                 count:boarding.length ,
                 effect: const ExpandingDotsEffect(
                   dotColor: Colors.grey,
                   dotHeight: 10,
                   expansionFactor: 4,
                   dotWidth: 10,
                   spacing: 5,
                   activeDotColor:defaultColor,
                 ),
               ),
               const Spacer(),
               FloatingActionButton(
                   onPressed: (){
                     if(isLast){
                       // ignore: prefer_const_constructors
                      submit();
                     }else{
                     boardController.nextPage(
                     duration: const Duration(
                     milliseconds: 750,
                     ),
                     curve:Curves.fastLinearToSlowEaseIn ,
                     );
                     }
                   },
                  child: const Icon(Icons.arrow_forward_ios),
               ),
             ],
           ),
         ],
       ),
     ),
     // body: ,
    );
  }
  Widget buildBoardingItem(BoardingModel boarding) =>Column(
   crossAxisAlignment: CrossAxisAlignment.start,
   children:  [
   Expanded(
    // ignore: unnecessary_string_interpolations
      child: Image.asset('${boarding.image}')),
      const SizedBox(
   height: 30.0,
   ),
    Text (
  // ignore: unnecessary_string_interpolations
   '${boarding.title}',
   style: const TextStyle(
   fontSize: 25.0,
   fontWeight: FontWeight.bold,
  ),
  ),
    const SizedBox(
    height: 15.0,
    ),
    Text(
   // ignore: unnecessary_string_interpolations
   '${boarding.body}',
    style: const TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
  ),
  ),
  ],
  );
}
