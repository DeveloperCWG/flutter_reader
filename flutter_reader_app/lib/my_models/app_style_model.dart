import 'package:flutter/material.dart';

class AppStyleModel {
  Color bgColor;//普通背景色
  Color textColor;//字体颜色
  Color textSubColor;//副标题字体颜色
  Color appBarBgColor;//bar的背景色
  Color appBarIconColor;//bar上按钮图标色
  Color segmentLineColor;//分割线颜色
  Color segmentRectColor;//分栏线颜色
  Color searchBgColor;//搜索栏输入框颜色
  Color searchInputCursorColor;//搜索栏光标颜色
  Color searchIconColor;//搜索栏图标颜色
  Brightness style;//风格

  AppStyleModel({
    @required this.bgColor, 
    @required this.textColor,
    @required this.appBarBgColor,
    @required this.appBarIconColor,
    @required this.textSubColor,
    @required this.segmentLineColor,
    @required this.segmentRectColor,
    @required this.searchBgColor,
    @required this.searchInputCursorColor,
    @required this.searchIconColor,
    this.style = Brightness.light,
  });

  factory AppStyleModel.light() => AppStyleModel(
      bgColor: Colors.white, 
      textColor: Colors.black, 
      textSubColor: Colors.black38,
      appBarBgColor: Colors.white,
      appBarIconColor: Color.fromRGBO(50, 50, 50, 1.0),
      segmentLineColor: Color.fromRGBO(220, 220, 220, 1.0),
      segmentRectColor: Color.fromRGBO(230, 230, 230, 1.0),
      searchBgColor: Color.fromRGBO(230, 230, 230, 1.0),
      searchInputCursorColor:Color.fromRGBO(60, 60, 60, 1.0),
      searchIconColor: Color.fromRGBO(180, 180, 180, 1.0),
      style: Brightness.light,
    );
  
  factory AppStyleModel.dark() => AppStyleModel(
      bgColor: Color.fromRGBO(20, 20, 20, 1.0), 
      textColor: Color.fromRGBO(160, 160, 160, 1.0), 
      textSubColor: Color.fromRGBO(125, 125, 125, 1.0),
      appBarBgColor: Color.fromRGBO(30, 30, 30, 1.0),
      appBarIconColor: Color.fromRGBO(140, 140, 140, 1.0),
      segmentLineColor: Color.fromRGBO(85, 85, 85, 1.0),
      segmentRectColor: Color.fromRGBO(45, 45, 45, 1.0),
      searchBgColor: Color.fromRGBO(60, 60, 60, 1.0),
      searchInputCursorColor:Color.fromRGBO(160, 160, 160, 1.0),
      searchIconColor: Color.fromRGBO(170, 170, 170, 1.0),
      style: Brightness.dark
    );
}