import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_models/book_info_model.dart';
import 'package:flutter_reader_app/my_models/book_reader_his_model.dart';
import 'package:flutter_reader_app/my_vm/appconmmn_vm.dart';
import 'package:flutter_reader_app/my_vm/book_reader_his_vm.dart';
import 'package:flutter_reader_app/my_vm/book_shelf_vm.dart';
import 'package:flutter_reader_app/public_widget/custom_appbar.dart';
import 'package:flutter_reader_app/routers/app_router_handlers.dart';
import 'package:flutter_reader_app/routers/app_routers.dart';
import 'package:flutter_reader_app/utils/app_store.dart';
import 'package:flutter_reader_app/utils/utils_tool.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_reader_app/my_vm/appstyle_vm.dart';
import 'package:flutter_reader_app/public_widget/my_widgets.dart';

class BookshelfPage extends StatefulWidget {
  @override
  _BookshelfPageState createState() => _BookshelfPageState();
}

class _BookshelfPageState extends State<BookshelfPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  int currentIndex = 0;
  @override
  void initState() { 
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener((){
      print(_tabController.index);
      setState(() {
        currentIndex = _tabController.index;
      });
    });
  }

   @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    // AppStoreUtil.clear();
    return Consumer2<AppStyleVm, BookShelfVm>(builder: (context, vm, shelfVm, widget) {
        return Scaffold(
          backgroundColor: vm.styleModel.bgColor,
          appBar: CustomAppBar(
            leftActions: <Widget>[
              InkWell(
                onTap: (){
                  AppRouter.navigateTo(context, RouterPageName.book_search);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 15),
                  height: 30,
                  width: ScreenUtil().setWidth(640),
                  decoration: BoxDecoration(
                    color: vm.styleModel.searchBgColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 10),  
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.search,
                      color: vm.styleModel.searchIconColor,
                    ),
                  ),
                ),
              )
            ],
            rightActions: <Widget>[
              this.currentIndex == 0 ? 
              IconButton(
                icon: Text(
                  _getRightNavBtnTitle(shelfVm.editStatus),
                  style: TextStyle(
                    color: shelfVm.bookInfos.isNotEmpty ? vm.styleModel.textColor:vm.styleModel.textSubColor,
                    fontSize: ScreenUtil().setSp(28),
                  ),
                ),
                onPressed: () {
                  switch (shelfVm.editStatus) {
                    case EditStatus.nomol:
                      if (shelfVm.bookInfos.isNotEmpty) shelfVm.checkEditStatus(EditStatus.ready);
                      break;
                    case EditStatus.ready:
                      shelfVm.checkEditStatus(EditStatus.nomol);
                      shelfVm.readyRemoves.clear();
                      break;
                    case EditStatus.activated:
                      shelfVm.checkEditStatus(EditStatus.nomol);
                      shelfVm.removeInfos().then((val){
                        AppCommnWidgets.showToast(
                          val?"删除成功":"删除失败",
                          backgroundColor: vm.styleModel.textColor,
                          textColor: vm.styleModel.appBarBgColor,
                        );
                      });
                      break;
                    default:
                  }
                }):
                Consumer<BookReaderHisVm>(builder: (context, hisVm, child){
                  return IconButton(
                    icon: Text(
                      "清空",
                      style: TextStyle(
                        color: hisVm.readerHisList.isNotEmpty ? vm.styleModel.textColor:vm.styleModel.textSubColor,
                        fontSize: ScreenUtil().setSp(28),
                      ),
                    ), 
                    onPressed: (){
                      if (hisVm.readerHisList.isNotEmpty) {
                        
                        showCupertinoDialog(context: context, builder: (context){
                          return CupertinoAlertDialog(
                            title: Text('提示'),
                            content:Text('确认清空阅读记录？'),
                            actions:<Widget>[
                              
                              CupertinoDialogAction(
                                child: Text('确认'),
                                onPressed: (){
                                  hisVm.clear();
                                  Navigator.of(context).pop();
                                },
                              ),
                          
                              CupertinoDialogAction(
                                child: Text('取消'),
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                      }
                    }
                  );
                }),
            ],
            backgroundColor: vm.styleModel.appBarBgColor,
            bottomLineColor: Colors.transparent,
            bottom:TabBar(
              controller: _tabController,
              isScrollable: false,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: vm.styleModel.textColor,
              tabs: <Widget>[
                MyWidgetLib.createTab("我的书架",200.0),
                MyWidgetLib.createTab("阅读足迹",200.0),
            ]), 
          ),
          body:TabBarView(
            controller: _tabController,
            children: <Widget>[
              MyBooksChildPage(),
              ReadHistoryPage(),
            ]
          ),
        );
      });
  }

  String _getRightNavBtnTitle(EditStatus status){
    String text = "";
    switch (status) {
      case EditStatus.nomol:
        text = "编辑";
        break;
      case EditStatus.ready:
        text = "取消";
        break;
      case EditStatus.activated:
        text = "删除";
        break;
      default:
    }
    return text;
  }

  @override
  bool get wantKeepAlive => true;
  
}


class MyBooksChildPage extends StatefulWidget {
  @override
  _MyBooksChildPageState createState() => _MyBooksChildPageState();
}

class _MyBooksChildPageState extends State<MyBooksChildPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer2<AppStyleVm, BookShelfVm>(builder: (context, styVm, vm, child){
      if (vm.bookInfos.isNotEmpty && vm.storeStutus == StoreStutus.success) {
        return Container(
        child: GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ScreenUtil.screenWidth<750.0?2:3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 4/5
          ), 
          itemCount: vm.bookInfos.length,
          itemBuilder: (context,index) => _creatGridItem(
            vm.bookInfos[index],
          ),
        ),
      );
      }else{
        if (vm.storeStutus == StoreStutus.start) {
          return LoadingWidget();
        } else if (vm.bookInfos.isEmpty || vm.storeStutus == StoreStutus.fail) {
          return Center(
            child: Consumer<AppConmmnVm>(builder: (context, appConmmnVm, child) => 
              FlatButton(
                onPressed: (){
                  appConmmnVm.checkTabIndex(1);
                }, 
                child: AutoColorText("去书城逛逛~"),
              ),
            ),
          );
        }
      }
    });
  }

  @override
  bool get wantKeepAlive => true;

  Widget _creatGridItem(BookInfo info)=> 
    Consumer2<AppStyleVm, BookShelfVm>(builder: (context, styVm, shelfVm, child) =>
      InkWell(
        onTap: (){
          AppRouter.navigateTo(
            context, 
            RouterPageName.reader_book, 
            params:{ 
              "book" :info.sId,
              "bookName" :info.title,
              "cover" :info.cover,
              "author":info.author,
            },
            transition: TransitionType.native
          );
        },
        child: Container(
        alignment: Alignment.center,
        // color: styVm.styleModel.appBarBgColor,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  flex: 9,
                  child: AppCommnWidgets.getCoverImgWidget(
                    context, 
                    url: UtilTools.convertImageUrl(info.cover),
                    width: ScreenUtil().setWidth(180),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: AutoColorText(info.title),
                  ),
                ),
              ],
            ),
            Positioned(
              child: shelfVm.editStatus != EditStatus.nomol ? CustomCheckBox(
                onTap: (bool flag){
                  if (flag) {
                    shelfVm.readyRemoves.add(info);
                  }else{
                    shelfVm.readyRemoves.remove(info);
                  }
                  if (shelfVm.readyRemoves.length > 0) {
                    shelfVm.checkEditStatus(EditStatus.activated);
                  } else {
                    shelfVm.checkEditStatus(EditStatus.ready);
                  }
                },
                child: Container(
                  padding: EdgeInsets.only(right: ScreenUtil().setWidth(24)),
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.topRight,
                  child: Icon(Icons.check_circle_outline,color: styVm.styleModel.textSubColor,),
                ),
                actionWidget: Container(
                  padding: EdgeInsets.only(right: ScreenUtil().setWidth(24)),
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.topRight,
                  child: Icon(Icons.check_circle,color: Color.fromRGBO(221, 191, 144, 1.0)),
                ),
              ):Container(),
            ),
          ],
        ),
      ),
      )
    );
}

class ReadHistoryPage extends StatefulWidget {
  @override
  _ReadHistoryPageState createState() => _ReadHistoryPageState();
}

class _ReadHistoryPageState extends State<ReadHistoryPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer2<AppStyleVm, BookReaderHisVm>(builder: (context, styVm, vm,child){

      if (vm.storeStutus == StoreStutus.success) {
        return Container(
          child: ListView.builder(
            itemCount: vm.readerHisList.length,
            itemBuilder: (context, index) =>
              InkWell(
                onTap: (){
                  AppRouter.navigateTo(context, RouterPageName.book_details,params: {"book":vm.readerHisList[index].sId});
                },
                child: _getItemCell(context,vm.readerHisList[index]),
              ),
          ),
        );
      }else if (vm.storeStutus == StoreStutus.fail) {
        return Center(
          child: Consumer<AppConmmnVm>(builder: (context, appConmmnVm, child) => 
            FlatButton(
              onPressed: (){
                appConmmnVm.checkTabIndex(1);
              }, 
              child: AutoColorText("去书城逛逛~"),
            ),
          ),
        );
      }else{
        return LoadingWidget();
      }

    });
  }

  Widget _getItemCell(context,ReaderHisModel model) =>
    Consumer<AppStyleVm>(builder: (context, styVm, child) =>
      Container(
        height: ScreenUtil().setHeight(150),
        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
        padding: EdgeInsets.only(top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            AppCommnWidgets.getCoverImgWidget(context,url: UtilTools.convertImageUrl(model.cover),width: ScreenUtil().setHeight(180)*0.55),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 12),
                    child: _getCellContent(context, model),
                ),
              ),
          ],
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: styVm.styleModel.segmentLineColor
            )
          )
        ),
      ),
    );

  Widget _getCellContent(context,ReaderHisModel model) =>
   Consumer<AppStyleVm>(builder: (context, styVm, child) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                model.name,
                style: TextStyle(
                  color: styVm.styleModel.textColor,
                  fontSize: ScreenUtil().setSp(32),                               
                ),
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.account_circle,
                    size: ScreenUtil().setSp(33),
                    color: styVm.styleModel.searchIconColor,
                  ),
                  Text(
                    model.author,
                    style: TextStyle(
                      color: styVm.styleModel.textSubColor,
                      fontSize: ScreenUtil().setSp(26),                               
                    ),
                  ),
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "${UtilTools.getTimeLine(context, model.lastReaderTime)}阅读",
                style: TextStyle(
                  color: styVm.styleModel.textSubColor,
                  fontSize: ScreenUtil().setSp(26),
                ),
              ),
              Text(
                "阅读至第${model.lastChapter}章",
                style: TextStyle(
                  color: styVm.styleModel.textSubColor,
                  fontSize: ScreenUtil().setSp(26),
                ),
              ),
            ],
          ),
        ],
      )
    );

  @override
  bool get wantKeepAlive => true;

}