import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_models/all_books_charts_model.dart';
import 'package:flutter_reader_app/my_models/all_charts_category.dart';
import 'package:flutter_reader_app/network_tool/http_util.dart';
import 'package:flutter_reader_app/utils/app_store.dart';

class BookMallVm {

  List<ChartsModel> chartsModels;
  AllBooksChartsCategory chartsCategoryModel;//榜单类型
  Map<String,AllBooksChartsModel> booksChartsModels;//榜单下的书籍集合<有切片处理>
  Map<String,AllBooksChartsModel> allBooksChartsModels;//榜单下的书籍集合<原始>

  BookMallVm({this.chartsCategoryModel}){
    this.booksChartsModels = Map<String,AllBooksChartsModel>();
    this.chartsModels = List<ChartsModel>();
    this.allBooksChartsModels = Map<String,AllBooksChartsModel>();
    updateBooksFromHttpTask();
  }

  Future<AllBooksChartsCategory> updateChartsFromHttpTask() async {
    var storeRes = await AppStoreUtil.getStoreString(AppStoreUtil.all_charts_category);
    if (storeRes != null) {
      this.chartsCategoryModel = AllBooksChartsCategory.fromJson(jsonDecode(storeRes));
    }else{
      storeRes = await HttpUtil.request(HttpUrlInfo.all_charts_category);
      AppStoreUtil.setStoreString(AppStoreUtil.all_charts_category, storeRes);
      this.chartsCategoryModel = AllBooksChartsCategory.fromJson(jsonDecode(storeRes));
    }
    setChartsModels();
    return this.chartsCategoryModel;
  }

 void updateBooksFromHttpTask() async{
    var res = await updateChartsFromHttpTask();
    if (res != null) {
      booksFromHttpTask(this.chartsModels, (){
        postNotifyListeners();
      });
    }
  }

 void booksFromHttpTask(List<ChartsModel> list, Function callback){
    int count = 0;
    list.map((item) async{
      var val = await HttpUtil.request(HttpUrlInfo.one_charts_books+"/${item.sId}");
      AllBooksChartsModel model = AllBooksChartsModel.fromJson(jsonDecode(val));
      this.allBooksChartsModels[item.sId] = model;
      model.ranking.books = model.ranking.books.length>8 ? 
      model.ranking.books.sublist(0,8):
      model.ranking.books;
      if (model.ranking == null || model.ranking.books.isEmpty) {
        this.chartsModels.remove(item);
      }else{
        this.booksChartsModels[item.sId] = model;
      }
      count ++ ;
      if (count == list.length) {
        callback();
      } 
      return {model.ranking.sId:model};
    }).toList();
  }

  void postNotifyListeners(){

  }

  void setChartsModels(){

  }

  int pageIndex(){

  }

} 

class BooksMallTableMaleVm extends BookMallVm with ChangeNotifier{

  @override
  void postNotifyListeners() {
    notifyListeners();
  }
  @override
  void setChartsModels(){
    this.chartsModels = this.chartsCategoryModel.male.sublist(0,7);
  }
  @override 
  int pageIndex() => 0;
}

class BooksMallTableFemaleVm extends BookMallVm with ChangeNotifier{
 @override
  void postNotifyListeners() {
    notifyListeners();
  }
  @override
  void setChartsModels(){
    this.chartsModels = this.chartsCategoryModel.female.sublist(0,7);
  }
  @override 
  int pageIndex() => 1;
}

class BooksMallTablePictureVm extends BookMallVm with ChangeNotifier{
 @override
  void postNotifyListeners() {
    notifyListeners();
  }
  @override
  void setChartsModels(){
    this.chartsModels = this.chartsCategoryModel.picture;
  }
}

class BooksMallTableEpubVm extends BookMallVm with ChangeNotifier{
 @override
  void postNotifyListeners() {
    notifyListeners();
  }
  @override
  void setChartsModels(){
    this.chartsModels = this.chartsCategoryModel.epub;
  }
  @override 
  int pageIndex() => 2;
}