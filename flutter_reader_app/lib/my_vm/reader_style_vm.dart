import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_models/reader_style_model.dart';
import 'package:flutter_reader_app/utils/app_store.dart';

class ReaderStyleVm with ChangeNotifier{
  ReaderStyleModel readerStyModel;

  ReaderStyleVm(){
    this.readerStyModel = ReaderStyleModel();
    updateStyleFromCache();
  }

  updateStyleFromCache() async {
    String style = await AppStoreUtil.getStoreString(AppStoreUtil.reader_style);
    // Map<String >
    if (style != null) {
      this.readerStyModel = ReaderStyleModel.fromJson(jsonDecode(style));
      AppStoreUtil.setStoreString(AppStoreUtil.reader_style, jsonEncode(this.readerStyModel.toJson()));
      notifyListeners();
    }
  }


  checkStyFontSize(bool isAdd){
    this.readerStyModel.fontSize += (isAdd?1:-1);
    AppStoreUtil.setStoreString(AppStoreUtil.reader_style, jsonEncode(this.readerStyModel.toJson()));
    notifyListeners();
  }

  checkStyBgColor(int index){
    if (this.readerStyModel.colorIndex != index) {
      this.readerStyModel.colorIndex = index;
      AppStoreUtil.setStoreString(AppStoreUtil.reader_style, jsonEncode(this.readerStyModel.toJson()));
      notifyListeners();
    }
  }
}