import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_models/category_big_child_model.dart';
import 'package:flutter_reader_app/network_tool/http_util.dart';
import 'package:flutter_reader_app/utils/app_store.dart';

class CategoryBigAndChildVm with ChangeNotifier {

  CategoryBigAndChildModel model;
  List<ChildCategoryTag> list;

  final String type;

  CategoryBigAndChildVm(
    this.type,
  ){
    this.list = List<ChildCategoryTag>();
    updateAllCategory();
  }

    RequestStatus requestStatus;

  updateAllCategory() async {
    this.requestStatus = RequestStatus.loading;
    var res = await HttpUtil.request(HttpUrlInfo.all_category_next);
    if (res != null) {
      this.requestStatus = RequestStatus.success;
      this.model = CategoryBigAndChildModel.fromJson(jsonDecode(res));
      _getListFromType();
    }else{
      this.requestStatus = RequestStatus.fail;
    }
    notifyListeners();
  }

  List<ChildCategoryTag> _getListFromType(){
    switch (this.type) {
      case "0":
        this.list = model?.male;
        break;
      case "1":
        this.list = model?.female;
        break;
      default:
    }
  }
  
}