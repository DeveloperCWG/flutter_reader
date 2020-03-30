import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_models/reader_content_model.dart';
import 'package:flutter_reader_app/my_vm/book_reader_his_vm.dart';
import 'package:flutter_reader_app/network_tool/http_util.dart';
import 'package:flutter_reader_app/my_models/book_chapters_model.dart';
import 'package:flutter_reader_app/utils/app_store.dart';

enum LoadType{
  upLoad,
  nextLoad,
}

class ReaderBookVm with ChangeNotifier{
  BookReaderHisVm readerHisVm;
  List<ReaderBookContentModel> models;
  RequestStatus status;
  String bookId;
  String bookName;
  String chapterNum;
  String cover;
  String author;

  String title;
  String content;
  BookChapters bookChapters;

  ReaderBookVm(this.bookId,{this.chapterNum,this.cover,this.author,this.bookName,this.readerHisVm}){
    this.models = List();
    updateBookContent(bookId);
  }
  Future<bool> updateBookContent(String bookId) async {
    this.status = RequestStatus.loading;
    this.content = null;
    if (this.chapterNum ==null) {
      this.chapterNum = await AppStoreUtil.getStoreString(bookId);
    }
    if (this.chapterNum == null) {
      this.chapterNum  = "1";
    }
    print(HttpUrlInfo.book_content+"/$bookId/${this.chapterNum}");
    HttpUtil.request(HttpUrlInfo.book_content+"/$bookId/${this.chapterNum}").then((val) async{
      this.status = HttpUtil.status;
      var content = await getBookContent(val);
      var title = await getBookTitle(val);
      if (content.isNotEmpty) {
        this.models.clear();
        AppStoreUtil.setStoreString(bookId, this.chapterNum);
        readerHisVm.setHisCache({
          "sId":this.bookId,
          "name":this.bookName,
          "lastChapter":this.chapterNum,
          "cover":this.cover,
          "author":this.author,
          "lastReaderTime":DateTime.now().toString(),
        });
        this.content = content;
        this.title = title;
        models.add(ReaderBookContentModel.fromJson({
          "title":this.title,
          "content":this.content,
          "chapterNum":this.chapterNum,
        }));
        notifyListeners();
      }else{
        this.status = RequestStatus.fail;
        notifyListeners();
      } 
    });

  }
  
  refreshData() async {
    notifyListeners();
    updateBookContent(bookId);
  }

  Future<bool> getFailStatus(bool status) async {
    return status;
  }

  Future<bool> uploadUpOrNextContent({LoadType type = LoadType.nextLoad}) async {
    if (type == LoadType.nextLoad) {
      ReaderBookContentModel model = this.models.last;
      this.chapterNum = model.chapterNum;
      this.chapterNum = (int.parse(this.chapterNum) + 1).toString();
    }else{
      if (int.parse(this.chapterNum)>1) {
        ReaderBookContentModel model = this.models.first;
        this.chapterNum = model.chapterNum;
        this.chapterNum = (int.parse(this.chapterNum) - 1).toString();
      }else{
        return await getFailStatus(false);
      }
    }
    var res = await HttpUtil.request(HttpUrlInfo.book_content+"/$bookId/${this.chapterNum ?? 1}");
    var content = await getBookContent(res);
    var title = await getBookTitle(res);
    if (content.isNotEmpty && title.isNotEmpty) {
      AppStoreUtil.setStoreString(bookId, this.chapterNum);
      readerHisVm.setHisCache({
        "sId":this.bookId,
        "name":this.bookName,
        "lastChapter":this.chapterNum,
        "cover":this.cover,
        "author":this.author,
        "lastReaderTime":DateTime.now().toString(),
      });
      this.content = content;
      this.title = title;
      ReaderBookContentModel model = ReaderBookContentModel.fromJson({
        "title":this.title,
        "content":this.content,
        "chapterNum":this.chapterNum,
      });
      if (type == LoadType.nextLoad) {
        models.add(model);
      }else{
        models.insert(0, model);
      }
      notifyListeners();
      return true;
    }else{
      return false;
    }
  }

  Future<String> getBookTitle(String str) async{
    // if (str.contains("由于版权方要求，剩余章节本站不得提供阅读服务")) {
    //   return "由于版权方要求，剩余章节本站不得提供阅读服务";
    // }
    var match = RegExp(r"({&#34;title&#34;:&#34;(?:.*)&#34;,&#34;body&#34;)").firstMatch(str);
    String result = "";
    if (match != null) {
      result = match?.group(0);
      result = result.replaceAll("{&#34;title&#34;:&#34;", "").replaceAll("&#34;,&#34;body&#34;", "");
    }
    result = result.replaceAll("{&#34;title&#34;:&#34;", "").replaceAll("&#34;,&#34;body&#34;", "");
    return result;
  }

   Future<String> getBookContent(String str) async{
    String result = "由于版权方要求，剩余章节本站不得提供阅读服务";
    var match = RegExp(r"(cpContent(?:.*)屏蔽收费章节)").firstMatch(str);
    if (match != null) {
      result = "";
      var matchs = RegExp(r"[^\x00-\xff]+").allMatches(match?.group(0));
      for (var i = 0; i < matchs.toList().length-2; i++) {
        result+="${(matchs.toList())[i].group(0)}\n\n"??"";
      }
    }
    return result;
  }
}

class ReaderBookToolVm with ChangeNotifier {
  bool toolIsOpen;
  ReaderBookToolVm({this.toolIsOpen = false});
  checkToolIsOpen({bool status}){
    this.toolIsOpen = !this.toolIsOpen;
    notifyListeners();
  }
}

class ReaderBookDrawVm with ChangeNotifier {
  bool drawIsOpen;
  ReaderBookDrawVm({this.drawIsOpen = false});
  checkDrawIsOpen({bool status}){
    this.drawIsOpen = !this.drawIsOpen;
    notifyListeners();
  }
}