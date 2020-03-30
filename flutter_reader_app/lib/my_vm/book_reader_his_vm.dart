import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_models/book_reader_his_model.dart';
import 'package:flutter_reader_app/utils/app_store.dart';

class BookReaderHisVm with ChangeNotifier {

  List<ReaderHisModel> readerHisList;
    StoreStutus storeStutus;

  BookReaderHisVm(){
    this.storeStutus = StoreStutus.start;
    this.readerHisList = List();
    getHisCache();
  }


  setHisCache(Map<String, dynamic> json) async {
    ReaderHisModel model = ReaderHisModel.fromJson(json);
    ReaderHisModel tem = isCache(model);
    if (tem != null) {
      readerHisList.remove(tem);
    }
    readerHisList.insert(0, model);

    List list = this.readerHisList.map((item){
      return item.toJson();
    }).toList();
    // notifyListeners();
    AppStoreUtil.setStoreString(AppStoreUtil.reader_his_list, jsonEncode(list));
  }

  getHisCache() async {
    var res = await AppStoreUtil.getStoreString(AppStoreUtil.reader_his_list);
    if (res != null && res.isNotEmpty && res.length>0) {
      List list = jsonDecode(res);
      this.readerHisList = list.map((item){
        return ReaderHisModel.fromJson(item);
      }).toList();
      this.storeStutus = StoreStutus.success;
    }else{
      this.storeStutus = StoreStutus.fail;
    }
    notifyListeners();
  }

  clear(){
    this.readerHisList.clear();
    this.storeStutus = StoreStutus.fail;
    sendState();
    AppStoreUtil.setStoreString(AppStoreUtil.reader_his_list, jsonEncode(""));
  }

  sendState(){
    if (this.readerHisList.length>0) {
      this.storeStutus = StoreStutus.success;
    }
    notifyListeners();
  }

  ReaderHisModel isCache(ReaderHisModel model){
    ReaderHisModel temp;
    for (var item in readerHisList){
      if (model.sId == item.sId) {
        temp = item;
        break;
      }
    }
    return temp;
  }
  
}