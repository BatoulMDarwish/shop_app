import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/styles/colors.dart';
ThemeData darkTheme =ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  primarySwatch: defaultColor,
  appBarTheme:  AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor:  HexColor('333739'),
      statusBarBrightness: Brightness.light,
    ) ,
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Colors.grey,
    selectedItemColor: defaultColor,
    elevation: 30.0,
    backgroundColor:  HexColor('333739'),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
) ;
ThemeData lightTheme=ThemeData(
  primarySwatch: defaultColor,
  appBarTheme: const AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle:SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
    ) ,
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Colors.grey,
    selectedItemColor: defaultColor,
    elevation: 20.0,
    backgroundColor:  Colors.white,
  ),

  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
);