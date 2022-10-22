import 'package:shop_app/models/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRgisterInitialStates extends ShopRegisterStates{}

class ShopRgisterLoadingStates extends ShopRegisterStates{}

class ShopRegisterSuccessStates extends ShopRegisterStates{
  final ShopLoginModel loginModel;
  ShopRegisterSuccessStates(this.loginModel);

}

class ShopRegisterErrorStates extends ShopRegisterStates{
  final String error;

  ShopRegisterErrorStates(this.error);

}

class ShopRegisterChangePasswordVisibiltyState extends ShopRegisterStates{}