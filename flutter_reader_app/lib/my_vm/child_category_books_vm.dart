import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_models/all_books_charts_model.dart';
import 'package:flutter_reader_app/my_models/child_cagetory_books_model.dart';
import 'package:flutter_reader_app/network_tool/http_util.dart';
import 'package:flutter_reader_app/utils/mock_data.dart';

class ChildCategoryAllBookVm with ChangeNotifier {

  ChildCategoryAllBooksModel model;

  List<Book> books;

  String gender;
  String major;
  String minor;
  int typeIndex;
  List<Map<String, String>> types;
  int pageName;
  int limit;

  RequestStatus requestStatus;

  ChildCategoryAllBookVm(
    this.gender,
    this.major,
    this.minor,
  ){
    this.pageName = 0;
    this.limit = 10;
    this.typeIndex = 0;
    this.books = [];
    this.types = bookTypes;
    updateFristPageData();
  }

  updateFristPageData() async {
    this.pageName = 0;
    this.books.clear();
    this.requestStatus = RequestStatus.loading;
    notifyListeners();
    var res = await HttpUtil.request(HttpUrlInfo.one_category_books, queryParameters: {
      "gender":gender??"male",
      "type" :this.types[typeIndex]["ID"],
      "major" :major??"",
      "minor" :minor,
      "start" :this.pageName,
      "limit" :this.limit,
    });
    if (res != null) {
      this.requestStatus = RequestStatus.success;
      this.model = ChildCategoryAllBooksModel.fromJson(jsonDecode(res));
      this.books.addAll(this.model.books??[]);
    }else{
      this.requestStatus = RequestStatus.fail;
    }
    notifyListeners();
  }

  Future<bool> updateNextPageData() async {
    
    this.pageName++;
    var res = await HttpUtil.request(HttpUrlInfo.one_category_books, queryParameters: {
      "gender":gender??"mael",
      "type" :this.types[typeIndex]["ID"],
      "major" :major??"",
      "minor" :minor,
      "start" :this.pageName.toString(),
      "limit" :this.limit.toString(),
    });
    if (res != null) {
      this.model = ChildCategoryAllBooksModel.fromJson(jsonDecode(res));
      this.books.addAll(this.model.books);
      notifyListeners();  
      if (model.books.length >= model.total) {
        return false;
      }
      return true;
    }else{
      this.pageName--;
      notifyListeners(); 
      return false;
    }  
  }

  checkCurrentIndex(int index){
    this.typeIndex = index;
    updateFristPageData();
  }
  
}