import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_reader_app/network_tool/http_util.dart';
import 'package:flutter_reader_app/my_models/book_chapters_model.dart';

class BookChapterVm with ChangeNotifier{
  String bookId;
  BookChapters bookChapters;

  BookChapterVm(this.bookId){
    updateBookChapters(bookId);
  }

  updateBookChapters(String bookId) async{
    var json = await HttpUtil.request(HttpUrlInfo.book_directories1+"/$bookId",queryParameters: {"view":"chapters"});
    
    if (json != null) {
      List list = jsonDecode(json)["chapters"];
      String title = list?.first["title"];
      if (title.contains("升级")) {
        HttpUtil.request(HttpUrlInfo.book_directories2+"/$bookId",queryParameters: {"view":"chapters"}).then((val){
          try {
            this.bookChapters = BookChapters.fromJson(jsonDecode(val));
            notifyListeners();
          } catch (e) {
            print("BookChapters模型转换失败:$e");
          }
        });
      }else{
          try {
            this.bookChapters = BookChapters.fromJson(jsonDecode(json));
            notifyListeners();
          } catch (e) {
            print("BookChapters模型转换失败:$e");
          }
      }
    }

  }
}