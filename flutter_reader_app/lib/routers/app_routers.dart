import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_reader_app/routers/app_router_handlers.dart';


class AppRouter {
  static Router router = RoutersBindHander.routerBindInit();
  static navigateTo(BuildContext context, String path, {Map<String, dynamic> params, TransitionType transition = TransitionType.native}) {
    if (params != null) {
      String query =  "";
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]);
        if (index == 0) {
          query = "?params=";
        } else {
          query = query + "\$";
        }
        query += "$key=$value";
        index++;
      }
      path = path + query;
    }
    router.navigateTo(context, path, transition:transition);
  }

}


class RoutersBindHander {
  static Router routerBindInit(){
    Router router = Router();
    configRouters(router);
    return router;
  }
  static configRouters(Router router){
    router.notFoundHandler = Handler(
      handlerFunc:(context,params) => Scaffold(
        body: Center(
          child: Text("找不到路由页面"),
        ),
      )
    );

    router.define(RouterPageName.book_details, handler: RouterHanders.bookDetailsHander);
    router.define(RouterPageName.reader_book, handler: RouterHanders.readerBookHander);
    router.define(RouterPageName.book_chapers, handler: RouterHanders.bookChapersHander);
    router.define(RouterPageName.book_search, handler: RouterHanders.bookSearchHander);
    router.define(RouterPageName.book_billBoard, handler: RouterHanders.billBoardHnadler);
    router.define(RouterPageName.book_all_category, handler: RouterHanders.bookAllCagtegoryPage);
    router.define(RouterPageName.child_category_books, handler: RouterHanders.childCategoryBooksPage);
    //...
  }
}