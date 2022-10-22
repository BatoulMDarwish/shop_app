
import 'package:flutter/cupertino.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/moduls/categories_screen/categories_screen.dart';
import 'package:shop_app/moduls/favorites_screen/favorites_screen.dart';
import 'package:shop_app/moduls/products_screen/products_screen.dart';
import 'package:shop_app/moduls/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remot/dio_helper.dart';

import '../../models/change_favorites_model.dart';
import '../../models/home_model.dart';
import '../../shared/network/end_points.dart';

class ShopCubit  extends Cubit<ShopStates>{
ShopCubit() : super(ShopInitialState());

static ShopCubit get(context)=>BlocProvider.of(context);

int currentIndex=0;

List<Widget> bottomScreens=[
  const ProductsScreen(),
  const CategoriesScreen(),
  const FavoritesScreen(),
   SettingsScreen(),
];

void changeBottom(int index){
  currentIndex=index;
  emit(ShopChangeBottomNavState());
}

HomeModel? homeModel;

Map<int,bool> favorites={};
void getHomeData(){
  emit(ShopLoadingHomeDataState());

  DioHelper.getData(
      url: HOME,
     token:token,
  ).then((value) {
    homeModel=HomeModel.fromJson(value.data);

    // ignore: avoid_function_literals_in_foreach_calls
    homeModel!.data!.products!.forEach((element) {
      favorites.addAll({
        element.id!:element.in_favorites!,
      });
    });

    emit(ShopSuccessHomeDataState());
  }).catchError((error){
    print(error.toString());
    emit(ShopErrorHomeDataState());
  });

}

 CategoriesModel ?categoriesModelModel;

void getCategories(){
  DioHelper.getData(
    url: GET_CATEGORIES,
      token: token
    //token:token,
  ).then((value) {
    categoriesModelModel=CategoriesModel.fromJson(value.data) ;
    emit(ShopSuccessCategoriesDataState());
  }).catchError((error){
    print(error.toString());
    emit(ShopErrorCategoriesDataState());
  });

}

ChangeFavoritesModel ?changeFavoritesModel;

void changeFavorites(int productId){

  favorites[productId] = !favorites[productId]!;

  emit(ShopChangeFavoritesDataState());

  DioHelper.postData(
      url: FAVORITES,
    token: token,
      data:{
        'product_id':productId,
      },

  ).then((value) {
    changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
     if(!changeFavoritesModel!.status!){
    favorites[productId] = !favorites[productId]!;
     }

    else{
      getFavorites();
    }
    emit(ShopSuccessChangeFavoritesDataState());

  }).catchError((error){
    print(error.toString());
    favorites[productId] = !favorites[productId]!;
    emit(ShopErrorChangeFavoritesDataState(error));
  });
}

FavModels? favoritesModel;

void getFavorites(){
  emit(ShopLoadingFavoritesState());
  DioHelper.getData(
    url: FAVORITES,
    token:token,
  ).then((value) {


    favoritesModel=FavModels.fromJson(value.data) ;
    emit(ShopSuccessGetFavoritesState());
  }).catchError((error){
    print(error.toString());
    emit(ShopErrorGetFavoritesState(error.toString()));
  });

}

ShopLoginModel? userModel;

void getUserModel(){
  emit(ShopLoadingUserDataState());
  DioHelper.getData(
    url: PROFILE,
    token:token,
  ).then((value) {


    userModel=ShopLoginModel.fromJson(value.data) ;
    print(userModel!.data!.name);
    emit(ShopSuccessGetUserDataState());
  }).catchError((error){
    print(error.toString());
    emit(ShopErrorGetUserDataState(error.toString()));
  });

}

void UpdateUserData({
  required String name,
  required String email,
  required String phone,
}){
  emit(ShopLoadingUserUpdateState());
  DioHelper.putData(
    url:UPDATE_USER ,
    token:token,
    data: {
      'name':name,
      'email':email,
      'phone':phone,
    },
  ).then((value) {


    userModel=ShopLoginModel.fromJson(value.data) ;
    print(userModel!.data!.name);
    emit(ShopSuccessGetUserUpdateState(userModel!));
  }).catchError((error){
    print(error.toString());
    emit(ShopErrorGetUserUpdateState(error.toString()));
  });

}
}