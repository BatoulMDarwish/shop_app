import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../layout/cubit/cubit.dart';
import '../../styles/colors.dart';

void navigateTo(context,widget) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget)
);

void navigateAndFinish(context,widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (route)=>false,
);

Widget defaultFormField({
    required TextEditingController controller,
    required TextInputType type,
    Function? onSubmit,
    Function? onChange,
    Function? onTap,
    bool isPassword = false,
    required String? Function(String? val) validate,
    required String label,
    required IconData prefix,
    IconData? suffix,
    Function? suffixPressed,
    bool isClickable = true,
}) =>
    TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        enabled: isClickable,
        validator:validate,
        decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(
                prefix,
            ),
            suffixIcon: suffix != null
                ? IconButton(
                onPressed:(){
                  suffixPressed!();
                },
                  icon: Icon(
                    suffix,
                ),
            )
                : null,
            border: const OutlineInputBorder(),
        ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function() function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed:function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextButton({
  required Function() function,
required String text,
}) =>TextButton(
    onPressed:function,
    child:Text(text.toUpperCase()),
);

void showToast({
  required String text,
  required ToastStates state,
})=>  Fluttertoast.showToast(
  msg:text,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: chooseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);

enum ToastStates{SUCCESS,ERROR,WARNING}
Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color= Colors.green;
      break;
    case ToastStates.ERROR:
      color =Colors.red;
      break;
    case ToastStates.WARNING:
      color= Colors.amber;
      break;
  }
  return color;
}

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(start:20.0,),
  child: Container(
    width: double.infinity,
    color: Colors.grey[300],
    height: 1.0,
  ),
);

Widget buildProductItems( model, context,{bool inSearch=true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage((model.image)!),
              width: 120,
              height: 120,
            ),
            if((model.discount) != 0&&inSearch)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                color: Colors.red,
                child: const Text('Discount',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.white
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text((model.name)!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  height: 1.3,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text((model.price.toString()),
                    style: const TextStyle(
                        fontSize: 12,
                        color: defaultColor
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if((model.discount) != 0&&inSearch)
                    Text(model.discount.toString(),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      ShopCubit.get(context).changeFavorites(
                          (model.id)!
                      );
                    },
                    icon: CircleAvatar(
                        backgroundColor: ShopCubit
                            .get(context)
                            .favorites[model.id]!
                            ? defaultColor
                            : Colors.grey,
                        radius: 15,
                        child: const Icon(Icons.favorite_border,
                          color: Colors.white,
                          size: 14,
                        )
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
