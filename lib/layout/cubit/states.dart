import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/login_model.dart';
abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoriesDataState extends ShopStates{}

class ShopErrorCategoriesDataState extends ShopStates{}

class ShopChangeFavoritesDataState extends ShopStates{}

class ShopSuccessChangeFavoritesDataState extends ShopStates{}

class ShopErrorChangeFavoritesDataState extends ShopStates{
   String e;
   ShopErrorChangeFavoritesDataState(this.e);
}

class ShopLoadingFavoritesState extends ShopStates{}

class ShopSuccessGetFavoritesState extends ShopStates{}

class ShopErrorGetFavoritesState extends ShopStates{
   String e;
   ShopErrorGetFavoritesState(this.e);
}

class ShopLoadingUserDataState extends ShopStates{}

class ShopSuccessGetUserDataState extends ShopStates{}

class ShopErrorGetUserDataState extends ShopStates{
  String e;
  ShopErrorGetUserDataState(this.e);
}

class ShopLoadingUserUpdateState extends ShopStates{}

class ShopSuccessGetUserUpdateState extends ShopStates{
  ShopLoginModel loginModel;
  ShopSuccessGetUserUpdateState(this.loginModel);
}

class ShopErrorGetUserUpdateState extends ShopStates{
  String e;
  ShopErrorGetUserUpdateState(this.e);
}




