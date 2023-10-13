import 'package:flutter/material.dart';

class TAppBarTheme{

  TAppBarTheme._(); 



  static const lightAppbarTheme = AppBarTheme(
    elevation: 0, 
    scrolledUnderElevation: 0,centerTitle: false,
    backgroundColor: Colors.transparent, 
    surfaceTintColor: Colors.transparent, 
    iconTheme: IconThemeData(color: Colors.black,size: 24), 
    actionsIconTheme: IconThemeData(color: Colors.black,size: 24),
    titleTextStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black)
  );


  //// dark Appbar 
  ///
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0, 
    scrolledUnderElevation: 0,centerTitle: false,
    backgroundColor: Colors.transparent, 
    surfaceTintColor: Colors.transparent, 
    iconTheme: IconThemeData(color: Colors.black,size: 24), 
    actionsIconTheme: IconThemeData(color: Colors.white,size: 24),
    titleTextStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white)
  );
}