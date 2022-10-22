
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // ignore: prefer_is_empty
        return ShopCubit.get(context).favoritesModel!.data!.data.length !=0 ? ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) =>    buildProductItems(
              ShopCubit.get(context).favoritesModel!.data!.data[index].product, context),
          separatorBuilder: (context, index) => Container(
            height: 1,
            width: 1,
            color: Colors.grey,
          ),
          itemCount: ShopCubit.get(context).favoritesModel!.data!.data.length,
        ) : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.favorite_outlined,
                size: 100.0,
                color: Colors.grey,),
              SizedBox(
                height: 10,
              ),
              Text(
                'Sorry not Favorites yet please add some favorites',
              ),

            ],
          ),
        );
      },
    );
  }

}



