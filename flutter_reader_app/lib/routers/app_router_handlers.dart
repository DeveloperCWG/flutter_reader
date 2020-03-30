import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_reader_app/my_pages/book_all_cagetory/book_all_cagetory.dart';
import 'package:flutter_reader_app/my_pages/book_all_cagetory/child_category_books_page.dart';
import 'package:flutter_reader_app/my_pages/book_search/book_search_page.dart';

import 'package:flutter_reader_app/my_pages/books_details_page/books_details_page.dart';
import 'package:flutter_reader_app/my_pages/reader_pages/reader_page.dart';
import 'package:flutter_reader_app/my_pages/books_chapters/books_chapters_page.dart';
import 'package:flutter_reader_app/my_pages/tab_pages/billboard_pages/billboard_page.dart';

//注册页面Handler
class RouterHanders {

  //书籍详情
  static Handler bookDetailsHander = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params){
      Map<String, String> argments = getArgments(params);
      return BooksDetailsPage(book: argments["book"]);
    }
  );

  //书籍章节详情
  static Handler readerBookHander = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params){
      Map<String, String> argments = getArgments(params);
      // String bookName = params["book"];
      return ReaderBookPage(
        book: argments["book"],
        bookName: argments["bookName"],
        chapterNum: argments["chapterNum"],
        cover: argments["cover"],
        author: argments["author"],
      );
    }
  );

  //书籍全部章节
  static Handler bookChapersHander = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params){
      Map<String, String> argments = getArgments(params);
      return BookChapterPage(book: argments["book"], bookName:argments["bookName"]);
    }
  );

  //书籍搜索
  static Handler bookSearchHander = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params){
      return BookSearchPage();
    }
  );

  static Handler billBoardHnadler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>>params){
      Map<String, String> argments = getArgments(params);
      return BillBoardPage(title:argments["title"], gender: argments["gender"], billBoardId: argments["billBoardId"]);
    }
  );

  static Handler bookAllCagtegoryPage = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>>params){
      Map<String, String> argments = getArgments(params);
      return BookAllCagtegoryPage(type: argments["type"]);
    }
  );

  static Handler childCategoryBooksPage = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>>params){
      Map<String, String> argments = getArgments(params);
      return ChildCategoryBooksPage(gender: argments["gender"], major: argments["major"], minor: argments["minor"]);
    }
  );

  static Map<String, String> getArgments(Map<String, List<String>> params){
    String parStr = params["params"].first;
    // parStr.split(pattern)
    List<String> tmpList = parStr.split("\$");
    Map<String,String> argments = {};
    tmpList.map((val){
      List mapList = val.split("=");
      argments.addAll({mapList[0]:mapList[1]});
    }).toList();
    return argments;
  }


  /**...*/
}

//配置页面名称
class RouterPageName {
  static const String book_details = "/book_details";
  static const String reader_book = "/reader_book";
  static const String book_chapers = "/book_chapers";
  static const String book_search = "/book_search";
  static const String book_billBoard = "/book_billBoard";
  static const String book_all_category = "/book_all_category";
  static const String child_category_books = "/child_category_books";
}