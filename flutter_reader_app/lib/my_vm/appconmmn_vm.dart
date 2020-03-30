import 'package:flutter/material.dart';

class AppConmmnVm with ChangeNotifier{
  int tabIndex;
  AppConmmnVm({this.tabIndex = 0});

  checkTabIndex(int index){
    this.tabIndex = index;
    notifyListeners();
  }
}