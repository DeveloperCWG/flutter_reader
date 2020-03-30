import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_models/book_search_hot_model.dart';
import 'package:flutter_reader_app/my_models/book_search_res_model.dart';
import 'package:flutter_reader_app/network_tool/http_util.dart';
import 'package:flutter_reader_app/utils/app_store.dart';

class BookSearchVm with ChangeNotifier {

  BookSearchHotModel searchHotModel;
  List<NewHotWords> randomHots;
  List<dynamic> historySearchTexts;
  BookSearchInfo searchInfo;

  bool searchLoading;//是否激活搜索结果
  bool searchBarTextIsEmpty;//搜索栏是否清空

  BookSearchVm(){
    updateSearchHot();
    this.randomHots = List();
    this.historySearchTexts = List();
    this.searchLoading = false;
    this.searchBarTextIsEmpty = true;
  }

  updateSearchHot() async {
    HttpUtil.request(HttpUrlInfo.book_search_hot).then((val){
      this.searchHotModel = BookSearchHotModel.fromJson(jsonDecode(val));
      getCacheHistoryHot();
      getRandomItem();
    });
  }

  getRandomItem(){
    this.randomHots.clear();
    for (var i = 0; i < 6; i++) {
      int index = Random().nextInt(this.searchHotModel.newHotWords.length);
      this.randomHots.add(this.searchHotModel.newHotWords[index]);
    }
    notifyListeners();
  }

  setCacheHistoryHot(String text) async {
    if (text.isEmpty) {
      return;
    }
    if (this.historySearchTexts.contains(text)) {
      this.historySearchTexts.remove(text);
    }
    this.historySearchTexts.insert(0, text);
    notifyListeners();
    AppStoreUtil.setStoreString(AppStoreUtil.search_his_texts, jsonEncode(this.historySearchTexts));
  }

  getCacheHistoryHot() async {
    AppStoreUtil.getStoreString(AppStoreUtil.search_his_texts).then((val){
      this.historySearchTexts.clear();
      if (val != null) {
        this.historySearchTexts = jsonDecode(val);
      }
    });
  }

  clearCacheHistoryHot() {
    this.historySearchTexts.clear();
    notifyListeners();
    AppStoreUtil.setStoreString(AppStoreUtil.search_his_texts, jsonEncode(this.historySearchTexts));
  }

  resetSearchLoading(){
    this.searchLoading = false;
    notifyListeners();
  }

  checkSearchBarTextIsEmpty(bool flag){
    this.searchBarTextIsEmpty = flag;
    notifyListeners();
  }

  sendSearchLoading(String text){
    this.searchLoading = true;
    sendSearch(text);
  }

  sendSearch(String text) async {
    HttpUtil.status = RequestStatus.loading;
    HttpUtil.request(HttpUrlInfo.search_result, queryParameters: {"query":text}).then((val){
      this.searchInfo = BookSearchInfo.fromJson(jsonDecode(val));
      notifyListeners();
    });
  }
  
}