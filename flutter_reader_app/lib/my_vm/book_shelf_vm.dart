import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_models/book_info_model.dart';
import 'package:flutter_reader_app/utils/app_store.dart';

const String bookShelfKey = "bookShelfKey";

enum EditStatus {
  nomol,
  ready,
  activated,
}

class BookShelfVm with ChangeNotifier {
  List<BookInfo> bookInfos;
  List<BookInfo> readyRemoves;
  EditStatus editStatus;
  StoreStutus storeStutus;
  BookShelfVm(){
    this.bookInfos = List();
    this.readyRemoves = List();
    this.editStatus = EditStatus.nomol;
    this.storeStutus = StoreStutus.start;
    getCacheBooks();
  }

  getCacheBooks() async {
    String bookInfosStr = await AppStoreUtil.getStoreString(bookShelfKey);
    if (bookInfosStr != null) {
      this.bookInfos.clear();
      List<dynamic> bookInfoJson = jsonDecode(bookInfosStr);
      bookInfoJson.forEach((item){
        this.bookInfos.add(BookInfo.fromJson(item));
      });
      this.storeStutus = StoreStutus.success;
    }else{
      this.storeStutus = StoreStutus.fail;
    }
    notifyListeners();
  }

  Future<bool> setCacheBooks(BookInfo bookInfo) async {
    this.bookInfos.insert(0,bookInfo);
    this.storeStutus = StoreStutus.success;
    notifyListeners();
    return AppStoreUtil.setStoreString(bookShelfKey, jsonEncode(this.bookInfos));
  }

  checkEditStatus(EditStatus status){
    this.editStatus = status;
    notifyListeners();
  }

  Future<bool> removeInfos() async {
    this.readyRemoves.forEach((item){
      this.bookInfos.remove(item);
    });
    bool flag = await AppStoreUtil.setStoreString(bookShelfKey, jsonEncode(this.bookInfos));
    if (flag) {
        this.readyRemoves.clear();
        notifyListeners();
    }
    return flag;
  }

  bool isExisted(BookInfo bookInfo){
    bool flag = false;
    for (BookInfo item in this.bookInfos){
       if (item.sId == bookInfo.sId) {
        flag = true;
        break;
      }     
    }
    return flag;
  }
}

