import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    var cubit=ShopCubit.get(context);
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context,state){
        return ListView.separated(
          itemBuilder: (context, index) => buildCatItem(cubit.categoriesModelModel!.data!.data[index]),
          separatorBuilder:(context,index)=>myDivider() ,
          itemCount:cubit.categoriesModelModel!.data!.data.length,
        );
      },
    );
  }
  
  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child:
       Row(
        children:  [
          Image(
            image:NetworkImage( '${model.image}'),
            width: 120.0,
            height: 120.0,
         //   fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 20.0,
          ),
          Text(
            '${model.name}',
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,

            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
          ),
        ],
    ),
  );
}
