import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_pages/tab_pages/tab_two_pages/tab_two_pubwidgets.dart';
import 'package:flutter_reader_app/my_vm/appstyle_vm.dart';
import 'package:flutter_reader_app/my_vm/child_category_books_vm.dart';
import 'package:flutter_reader_app/network_tool/http_util.dart';
import 'package:flutter_reader_app/public_widget/custom_appbar.dart';
import 'package:flutter_reader_app/public_widget/my_widgets.dart';
import 'package:flutter_reader_app/routers/app_router_handlers.dart';
import 'package:flutter_reader_app/routers/app_routers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChildCategoryBooksPage extends StatelessWidget {
  final String gender;
  final String major;
  final String minor;
  ChildCategoryBooksPage({
    @required this.gender,
    @required this.major,
    @required this.minor,
  });

  RefreshController _refreshController;


  @override
  Widget build(BuildContext context) {
    _refreshController = RefreshController(initialRefresh: false);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChildCategoryAllBookVm>.value(value: ChildCategoryAllBookVm(this.gender, this.major, this.minor)),
      ],
      child: Consumer<AppStyleVm>(
        builder: (context, styVm, child) =>
          Scaffold(
            backgroundColor: styVm.styleModel.bgColor,
            appBar: CustomAppBar(
              backgroundColor: styVm.styleModel.appBarBgColor,
              bottomLineColor: Colors.transparent,
              defLeftIconColor: styVm.styleModel.appBarIconColor,
              title: Text(
                this.minor,
                style: TextStyle(
                  color: styVm.styleModel.textColor,
                  fontSize: ScreenUtil().setSp(34),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Container(
              child: Column(
                children: <Widget>[
                  _getTopTool(),
                  Expanded(
                    child: _getListView(),
                  ),
                ],
              )
            ),
          ),
      ),
    );
  }

  Widget _getTopTool() =>
    Consumer2<AppStyleVm, ChildCategoryAllBookVm>(builder: (context, styVm, vm, child) =>
      Container(
        width: double.infinity,
        height: 40,
        padding: EdgeInsets.only(top: 7,bottom: 7),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          
          itemCount: vm.types.length,
          itemBuilder: (context, index) =>
            Padding(
              padding: EdgeInsets.only(left: 15,right: 0),
              child: InkWell(
                onTap: (){
                  vm.checkCurrentIndex(index);
                },
                child: AppCommnWidgets.getTagWidget(
                  vm.types[index]["name"],
                  bgColor: vm.typeIndex == index?Color.fromRGBO(221, 191, 144, 1.0):styVm.styleModel.searchBgColor,
                  textColor: vm.typeIndex == index?Colors.white:styVm.styleModel.textSubColor,
                ),
              )
            ),
        ),
      )
    );
  
  Widget _getListView() =>
    Consumer<ChildCategoryAllBookVm>(
      builder: (context, vm, child){

        if (vm.requestStatus == RequestStatus.success) {
          if (vm.books.length > 0) {
            return SafeArea(
              child: SmartRefresher(
                controller: _refreshController,
                enablePullDown: false,
                enablePullUp: true,
                footer: CustomFooter(
                  builder: (BuildContext context,LoadStatus mode){
                    Widget body ;
                    if(mode==LoadStatus.idle){
                      body =  AutoColorText("上拉加载...");
                    }
                    else if(mode==LoadStatus.loading){
                      body =  CupertinoActivityIndicator();
                    }
                    else if(mode == LoadStatus.failed){
                      body = AutoColorText("加载失败！请重试~");
                    }
                    else if(mode == LoadStatus.canLoading){
                      body = AutoColorText("松手,加载下一页!");
                    }
                    else{
                      body = AutoColorText("没有更多书籍了!");
                    }
                    return Container(
                      height: 60.0,
                      child: Center(child:body),
                    );
                  },
                ),
                onLoading: () async{
                  bool flag = await vm.updateNextPageData();
                  if (flag) {
                    _refreshController.loadComplete();
                  }else{
                    _refreshController.loadFailed();
                  }
                },
                child: ListView.builder(
                  itemCount: vm.books.length,
                  itemBuilder: (context, index) =>
                    Container(
                      margin: EdgeInsets.only(left: 15,right: 15),
                      child: TwoPagePubWidget.getItemChildContentCellWidget(context, vm.books[index], (){
                        AppRouter.navigateTo(context, RouterPageName.book_details,params: {"book":vm.books[index].sId});
                      }),
                    )
                ),
              ),
            );
          }else{
            return Center(
              child: AutoColorText("没有找到数据~"),
            );
          }
        }else if (vm.requestStatus == RequestStatus.fail) {
          return RequestFailWidget(refreshCallback: (){
            vm.updateFristPageData();
          });
        }else{
          return LoadingWidget();
        }

      }
    );

  @override
  bool get wantKeepAlive => true;
}