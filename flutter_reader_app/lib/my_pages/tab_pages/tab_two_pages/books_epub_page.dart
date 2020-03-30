import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader_app/public_widget/my_widgets.dart';
import 'package:flutter_reader_app/routers/app_router_handlers.dart';
import 'package:provider/provider.dart';
import 'package:flutter_reader_app/my_vm/appstyle_vm.dart';
import 'package:flutter_reader_app/my_vm/book_mall_vm.dart';
import 'package:flutter_reader_app/my_models/all_charts_category.dart';
import 'package:flutter_reader_app/my_models/all_books_charts_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_reader_app/routers/app_routers.dart';
import 'package:flutter_reader_app/my_pages/tab_pages/tab_two_pages/tab_two_pubwidgets.dart';

class BooksMallEnupPage extends StatefulWidget {
  int currentIndex;
  BooksMallEnupPage(this.currentIndex);

  @override
  _BooksMallEnupPageState createState() => _BooksMallEnupPageState();
}

class _BooksMallEnupPageState extends State<BooksMallEnupPage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("build");
    return Consumer2<AppStyleVm,BooksMallTableEpubVm>(
      builder: (context, styleVm, vm, child) {
        if (vm.chartsCategoryModel != null) {
          List<ChartsModel> models = vm.chartsModels;
          return ListView.builder(
            itemCount: models.length,
            itemBuilder: (context,index) =>
              _getItemWidget(context,models[index])
          );
        }else{
          return AppCommnWidgets.getLoadingWidget(context);
        }
      }
    );
  }

  Widget _getItemWidget(context,ChartsModel itemModel) => 
    Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Column(
        children: <Widget>[
            _getItemChildTitleWidget(context,itemModel),
            _getItemChildContentWidget(context,itemModel),
        ],
      ),
    );

    Widget _getItemChildTitleWidget(context,ChartsModel itemModel) =>
      InkWell(
        onTap: (){
          AppRouter.navigateTo(context, RouterPageName.book_billBoard,params: {
            "title":itemModel.shortTitle,
            "gender":"1",
            "billBoardId":itemModel.sId,
          });
        },
        child: Consumer<AppStyleVm>(
          builder: (context,vm,child) => 
            Container(
              height: ScreenUtil().setHeight(80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    itemModel.shortTitle.replaceAll("榜", ""),
                    style: TextStyle(
                      color: vm.styleModel.textColor,
                      fontSize: ScreenUtil().setSp(40),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AutoColorIcon(
                    Icons.keyboard_arrow_right,
                  ),
                ],
              ),
            ),
        ),
      );

    Widget _getItemChildContentWidget(context, ChartsModel itemModel) =>
      Container(
        child: Consumer<BooksMallTableEpubVm>(builder: (context,vm,child){
          if (vm.booksChartsModels != null) {
            Map<String, AllBooksChartsModel> tempMap = vm.booksChartsModels;
  
            List<Book> books = tempMap[itemModel.sId].ranking.books;
            return Column(
              children: books.map((item)=>
                TwoPagePubWidget.getItemChildContentCellWidget(context,item,(){
                  print("书籍:${item.toJson()}");
                  AppRouter.navigateTo(context, RouterPageName.book_details, params:{"book":item.sId},transition: TransitionType.native);
                }),
              ).toList(),
            );
          }else{
            return Container();
          }
        }
      )
    );

}