import 'package:flutter/material.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/network/remot/dio_helper.dart';
import '../../../shared/network/end_points.dart';
import 'package:shop_app/moduls/register_screen/cubit/states.dart';
import '../../../shared/network/local/cach_helper.dart';
class ShopRegisterCubit extends Cubit<ShopRegisterStates>{

  ShopRegisterCubit() : super(ShopRgisterInitialStates());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel loginModel;

  void userRegister({
    required  String name,
    required String email,
    required  String password,
    required  String phone,

}){
    emit(ShopRgisterLoadingStates());
    DioHelper.postData(
        url:REGISTER,
         data: {
           'name':name,
           'email': email,
           'password': password,
           'phone': phone,
         },
      token: CachHelper.getData(key:'token'),
    ).then((value) {
      print(value.data);
     loginModel= ShopLoginModel.fromJson(value.data);

      emit(ShopRegisterSuccessStates(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorStates(error.toString()));
    });
  }

  IconData suffix=Icons.visibility_outlined;
bool isPassword=true;
  void changePasswordVisibility(){
    isPassword=!isPassword;
    suffix=isPassword? Icons.visibility_off_outlined:Icons.visibility_outlined;

    emit(ShopRegisterChangePasswordVisibiltyState());

  }

}