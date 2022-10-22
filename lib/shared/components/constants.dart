import '../../moduls/login/shop_login_screen.dart';
import '../network/local/cach_helper.dart';
import 'components.dart';

void signOut(context){
CachHelper.clearData(key: 'token').then((value) {
  if (value) {
    navigateAndFinish(context, ShopLoginScreen());
  }
}
);
}

dynamic token='';
