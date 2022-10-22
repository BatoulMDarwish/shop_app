import 'package:flutter/material.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/styles/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context,state){
        return ConditionalBuilder(
          // ignore: unnecessary_null_comparison
          condition:ShopCubit.get(context).homeModel !=null&& ShopCubit.get(context).categoriesModelModel !=null ,
          builder:(context) =>productsBuilder(
              ShopCubit.get(context).homeModel!,
              ShopCubit.get(context).categoriesModelModel!,context
          ),
          fallback: (context)=>const Center(child: CircularProgressIndicator()),
        );
      },
    );

  }

  Widget productsBuilder(HomeModel model,CategoriesModel categoriesModel,context) => SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: model.data!.banners!
              .map((e) => Image(
            image: NetworkImage('${e.image}'),
            width: double.infinity,
          ))
              .toList(),
          options: CarouselOptions(
            height: 250,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            viewportFraction: 1,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                width: double.infinity,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      buildCategoryItem(categoriesModel.data!.data[index]),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 15,
                  ),
                  itemCount: categoriesModel.data!.data.length,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Products',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1 / 1.77,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            crossAxisCount: 2,
            children: List.generate(model.data!.products!.length,
                    (index) => buildGridProduct(model.data!.products![index],context)),
          ),
        ),
      ],
    ),
  );


  Widget buildGridProduct(ProductModel model,context)=> Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children:[
          Image(
            image: NetworkImage('${model.image}'),
            width: double.infinity,
            height: 200.0,
          ),
           if(model.discount !=0)
           Container(
             color: Colors.red,
             padding: const EdgeInsets.symmetric(horizontal: 5.0),
             child: const Text(
               'DISCOUNT',
               style: TextStyle(
                 fontSize: 8.0,
                 color: Colors.white,
               ),
             ),
           ) ,
          ]
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}' ,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Row(
                children:[
                  Text(
                  '${model.price.round()}',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: defaultColor,
                  ),
                ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  if(model.discount !=0)
                  Text(
                    '${model.old_price.round()}',
                    style: const TextStyle(
                      fontSize: 10.0,
                      color:Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: (){
                        ShopCubit.get(context).changeFavorites(model.id!);
                      },
                      icon: CircleAvatar(
                        backgroundColor: ShopCubit.get(context).favorites[model.id]! ?defaultColor:Colors.grey,
                        radius: 15,
                        child: const Icon(Icons.favorite_border,
                          color: Colors.white,
                          size: 14,
  //
                               ),

                      ))]
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget buildCategoryItem(DataModel model)=>Stack(
    alignment:AlignmentDirectional.bottomCenter ,
    children:  [
      Image(
        image:NetworkImage('${model.image}'),
        height: 100.0,
        width: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
        width: 100.0,
        color: Colors.black.withOpacity(.8),
        child:  Text(
          '${model.name}',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}
