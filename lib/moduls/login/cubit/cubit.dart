import 'package:flutter/material.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/moduls/login/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/network/remot/dio_helper.dart';

import '../../../shared/network/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{

  ShopLoginCubit() : super(ShopLoginInitialStates());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel loginModel;

  void userLogin({
  required String email,
  required  String password,
}){
    emit(ShopLoginLoadingStates());
    DioHelper.postData(
        url:LOGIN,
         data: {
         'email': email,
           'password': password,
         },
    ).then((value) {
      print(value.data);
     loginModel= ShopLoginModel.fromJson(value.data);

      emit(ShopLoginSuccessStates(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorStates(error.toString()));
    });
  }

  IconData suffix=Icons.visibility_outlined;
bool isPassword=true;
  void changePasswordVisibility(){
    isPassword=!isPassword;
    suffix=isPassword? Icons.visibility_off_outlined:Icons.visibility_outlined;

    emit(ShopChangePasswordVisibilityStates());

  }

}