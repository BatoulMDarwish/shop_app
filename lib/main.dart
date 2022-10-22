import 'package:flutter/material.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/moduls/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';
import 'package:shop_app/shared/network/remot/dio_helper.dart';
import 'package:shop_app/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'moduls/on_boarding/on_boarding_screen.dart';
import 'styles/bloc_observer.dart';
import 'package:bloc/bloc.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer=MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();

  Widget widget;
  // ignore: unused_local_variable
  bool ?onBoarding=CachHelper.getData(key:'onBoarding');
  token=CachHelper.getData(key:'token');

  // ignore: unnecessary_null_comparison
  if(onBoarding!=null){
    // ignore: unnecessary_null_comparison
    if(token!=null) {
      widget=const ShopLayout();}
      else {
      widget=ShopLoginScreen();
    }
  }else{
    widget=const OnBoardingScreen();
  }
  runApp( MyApp(
    onBoarding: onBoarding,
    startWidget: widget,));
}

class MyApp extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final startWidget;
  // ignore: prefer_typing_uninitialized_variables
  final onBoarding;
  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  MyApp({this.startWidget,this.onBoarding} );

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create:(BuildContext context)=>ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme:darkTheme,
            home:startWidget,
      ),
    );
  }
}
