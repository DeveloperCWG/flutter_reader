import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_models/book_info_model.dart';
import 'package:flutter_reader_app/network_tool/http_util.dart';

class BookDetailVm with ChangeNotifier{
  String bookId;
  BookInfo bookInfo;
  RequestStatus status;

  BookDetailVm(this.bookId){
    this.status = RequestStatus.loading;
    updateBookInfo(bookId);
  }

  updateBookInfo(String bookId) async {
    HttpUtil.request(HttpUrlInfo.one_book_info+"/$bookId").then((val){
      this.status = HttpUtil.status;
      this.bookInfo = BookInfo.fromJson(jsonDecode(val));
      notifyListeners();
    });
  }

}