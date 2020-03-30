import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_models/app_style_model.dart';

class AppStyleVm with ChangeNotifier{
  final Brightness systemBrightnessValue;
  AppStyleModel styleModel = AppStyleModel.light();
  AppStyleVm({
    this.systemBrightnessValue
  }){
    if (systemBrightnessValue == Brightness.dark) {
      styleModel = AppStyleModel.dark();
    }else{
      styleModel = AppStyleModel.light();
    }
  }
  void chekStyle(){
    switch (styleModel.style) {
      case Brightness.light:
        styleModel = AppStyleModel.dark();
      break;
      case Brightness.dark:
        styleModel = AppStyleModel.light();
      break;     
      default:
        styleModel = AppStyleModel.light();
    }
    notifyListeners();
  }

  void chekStyleFromStyle(Brightness style){
    switch (style) {
      case Brightness.light:
        styleModel = AppStyleModel.light();
      break;
      case Brightness.dark:
        styleModel = AppStyleModel.dark();
      break;     
      default:
        styleModel = AppStyleModel.light();
    }
    notifyListeners();
  }
}

class AppBarOpacityVm with ChangeNotifier{
    ScrollController controller;
    double maxScrollContSize;
    double appBarBgOpacity;
    AppBarOpacityVm(this.controller,{this.maxScrollContSize = 64, this.appBarBgOpacity = 0.0}){
      this.controller.addListener((){
        this.appBarBgOpacity = (controller.offset/maxScrollContSize).abs()>1.0 ? 1.0 : (controller.offset/maxScrollContSize).abs();
        notifyListeners();
      });
    }
}