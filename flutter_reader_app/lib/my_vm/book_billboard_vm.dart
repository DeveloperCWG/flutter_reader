import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_models/all_books_charts_model.dart';
import 'package:flutter_reader_app/network_tool/http_util.dart';

class BookBillboardVm with ChangeNotifier {

  final String gender;
  final String billBoardId;
  BookBillboardVm({
    @required this.gender,
    @required this.billBoardId,
  }){
    updateBillboardBooks();
  }

  RequestStatus requestStatus;

  AllBooksChartsModel model;


  updateBillboardBooks() async {
    this.requestStatus = RequestStatus.loading;
    var val = await HttpUtil.request(HttpUrlInfo.one_charts_books+"/${this.billBoardId}");
    if (val != null) {
      this.requestStatus = RequestStatus.success;
      this.model = AllBooksChartsModel.fromJson(jsonDecode(val));
    }else{
      this.requestStatus = RequestStatus.fail;
    }
    notifyListeners();
  }
  
}