import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_pages/tab_pages/tab_two_pages/tab_two_pubwidgets.dart';
import 'package:flutter_reader_app/my_vm/appstyle_vm.dart';
import 'package:flutter_reader_app/my_vm/book_seach_vm.dart';
import 'package:flutter_reader_app/network_tool/http_util.dart';
import 'package:flutter_reader_app/public_widget/my_widgets.dart';
import 'package:flutter_reader_app/routers/app_router_handlers.dart';
import 'package:flutter_reader_app/routers/app_routers.dart';
import 'package:provider/provider.dart';

class BookSearchRes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AppStyleVm, BookSearchVm>(builder: (context, styVm, vm, child){
      if (HttpUtil.status == RequestStatus.success) {
        if (vm.searchInfo.books.isNotEmpty) {
          return Container(
            child: ListView.builder(
              itemCount: vm.searchInfo.books.length,
              itemBuilder: (context, index) =>
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TwoPagePubWidget.getItemChildContentCellWidget(
                    context, 
                    vm.searchInfo.books[index], 
                    (){
                      AppRouter.navigateTo(context, RouterPageName.book_details, params:{"book":vm.searchInfo.books[index].sId},transition: TransitionType.native);
                    }
                  ),
                )
            )
          );
        }else{
          return Center(
            child: AutoColorText("没有搜索到内容~"),
          );
        }
      }else if (HttpUtil.status == RequestStatus.fail) {
        return RequestFailWidget();
      }else {
        return LoadingWidget();
      }
    });
  }
}