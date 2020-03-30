import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_vm/book_reader_his_vm.dart';
import 'package:flutter_reader_app/my_vm/book_shelf_vm.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_reader_app/my_vm/appconmmn_vm.dart';
import 'package:flutter_reader_app/my_vm/appstyle_vm.dart';
import 'package:flutter_reader_app/my_vm/book_mall_vm.dart';


class MyConstant {
  static const double designWidth  = 750.0;
  static const double designHeight  = 1334.0;
  static void appInitSet(BuildContext context){
    ScreenUtil.init(context,width: designWidth, height: designHeight);
  }

  static List<ChangeNotifierProvider> vmMainSetBindList = [
    ChangeNotifierProvider<AppStyleVm>.value(value: AppStyleVm()),
    ChangeNotifierProvider<AppConmmnVm>.value(value: AppConmmnVm()),
    ChangeNotifierProvider<BookShelfVm>.value(value: BookShelfVm()),
    ChangeNotifierProvider<BookReaderHisVm>.value(value: BookReaderHisVm()),
  ];

  static List<ChangeNotifierProvider> vmMallSetBindList = [
    ChangeNotifierProvider<BooksMallTableMaleVm>.value(value: BooksMallTableMaleVm()),
    ChangeNotifierProvider<BooksMallTableFemaleVm>.value(value: BooksMallTableFemaleVm()),
    // ChangeNotifierProvider<BooksMallTablePictureVm>.value(value: BooksMallTablePictureVm()),
    ChangeNotifierProvider<BooksMallTableEpubVm>.value(value: BooksMallTableEpubVm()),
  ];

}