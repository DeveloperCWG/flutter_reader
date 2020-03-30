import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_models/book_info_model.dart';
import 'package:flutter_reader_app/my_vm/appstyle_vm.dart';
import 'package:flutter_reader_app/my_vm/book_chatpers_vm.dart';
import 'package:flutter_reader_app/my_vm/book_details_vm.dart';
import 'package:flutter_reader_app/my_vm/book_shelf_vm.dart';
import 'package:flutter_reader_app/network_tool/http_util.dart';
import 'package:flutter_reader_app/public_widget/my_widgets.dart';
import 'package:flutter_reader_app/routers/app_router_handlers.dart';
import 'package:flutter_reader_app/routers/app_routers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_reader_app/public_widget/custom_appbar.dart';
import 'package:flutter_reader_app/public_widget/custom_toolbar.dart';
import 'package:flutter_reader_app/my_pages/books_details_page/books_details_top.dart';
import 'package:flutter_reader_app/my_pages/books_details_page/books_details_score.dart';
import 'package:flutter_reader_app/my_pages/books_details_page/books_details_intro.dart';
import 'package:flutter_reader_app/my_pages/books_details_page/books_details_comment.dart';

class BooksDetailsPage extends StatelessWidget {
  String book;
  BooksDetailsPage({ 
    @required this.book,
  });
  ScrollController controller;

  Widget build(BuildContext context) {
    print("BooksDetailsPage - build");
    controller = ScrollController();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BookChapterVm>.value(value: BookChapterVm(this.book)),
        ChangeNotifierProvider<BookDetailVm>.value(value: BookDetailVm(this.book)),
        ChangeNotifierProvider<AppBarOpacityVm>.value(value: AppBarOpacityVm(this.controller)),
      ],
      child: Consumer2<AppStyleVm,BookDetailVm>(
          builder: (context,styleVm,vm,child) {
            if (vm.status == RequestStatus.success) {
              return Scaffold(
                backgroundColor: styleVm.styleModel.bgColor,
                body: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      controller: controller,
                      child: Column(
                        children: <Widget>[
                          BookDetailTop(vm.bookInfo),
                          BookDetailScore(vm.bookInfo),
                          AppCommnWidgets.getSegment(context,color: styleVm.styleModel.segmentRectColor),
                          BookIntro(vm.bookInfo,onTap: (){
                            AppRouter.navigateTo(context, RouterPageName.book_chapers, params:{"book":vm.bookInfo.sId,"bookName":vm.bookInfo.title});
                          }),
                          AppCommnWidgets.getSegment(context,color: styleVm.styleModel.segmentRectColor),
                          BookComment(vm.bookInfo),
                          AppCommnWidgets.getSegment(context,color: styleVm.styleModel.bgColor,height: ScreenUtil.bottomBarHeight+iOSbottomBarDefHeight),
                        ],
                      ),
                    ),
                    _getAppBar(vm.bookInfo.title),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: _getBottomBar(vm.bookInfo),
                    )
                  ],
                ),
              );
            }else if (vm.status == RequestStatus.loading) {
              return LoadingWidget();
            } else{
              return LoadingWidget();
            }
          }
        ),
    );
  }

  Widget _getAppBar(String title) =>
    Consumer2<AppStyleVm,AppBarOpacityVm>(builder: (context, styleVm, appBarVm,child) =>
      CustomAppBar(
        title: Text(
          title ?? "",
          style: TextStyle(
            color: styleVm.styleModel.appBarIconColor.withOpacity(appBarVm.appBarBgOpacity),
            fontSize: ScreenUtil().setSp(34),
            fontWeight: FontWeight.bold
          ),
        ),
        defLeftIconColor: styleVm.styleModel.appBarIconColor,
        backgroundColor: styleVm.styleModel.appBarBgColor.withOpacity(appBarVm.appBarBgOpacity),
        shadowOpacity: appBarVm.appBarBgOpacity,
        bottomLineColor: Colors.transparent,
        brightness: Brightness.dark,
      ),
    );
   
  Widget _getBottomBar(BookInfo info) => 
    Consumer3<AppStyleVm, BookDetailVm, BookShelfVm>(builder: (context, vm, dataVm, shelfVm, child) => 
      CustomToolBar(
        backgroundColor: vm.styleModel.bgColor,
        childen: <Widget>[
          Expanded(
            child: FlatButton(
              onPressed: (){
                if (shelfVm.isExisted(info)) {
                  return;
                }
                shelfVm.setCacheBooks(info).then((val){
                  AppCommnWidgets.showToast(
                    val?"添加成功":"添加失败",
                    backgroundColor: vm.styleModel.textColor,
                    textColor: vm.styleModel.appBarBgColor,
                  );
                });
              }, 
              child: Text(
                shelfVm.isExisted(info)?"书架已存":"加入书架+",
                style: TextStyle(
                  color: shelfVm.isExisted(info)?vm.styleModel.textSubColor:Color.fromRGBO(221, 191, 144, 1.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: FlatButton(
              onPressed: (){
                AppRouter.navigateTo(
                  context, 
                  RouterPageName.reader_book, 
                  params:{
                    "book" :info.sId,
                    "bookName" :info.title,
                    "cover" :info.cover,
                    "author":info.author
                  },
                  transition: TransitionType.native
                );
              }, 
              child: Text(
                "开始阅读",
                  style: TextStyle(
                  color: Colors.white,
                ),                   
              ),
              color: Color.fromRGBO(221, 191, 144, 1.0),
            ),
          ),
        ],
      ),
    );
}