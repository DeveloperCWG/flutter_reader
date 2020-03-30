import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_models/reader_style_model.dart';
import 'package:flutter_reader_app/my_pages/reader_pages/reader_page_tool.dart';
import 'package:flutter_reader_app/my_vm/appstyle_vm.dart';
import 'package:flutter_reader_app/my_vm/book_reader_his_vm.dart';
import 'package:flutter_reader_app/my_vm/reader_book_vm.dart';
import 'package:flutter_reader_app/my_vm/reader_style_vm.dart';
import 'package:flutter_reader_app/network_tool/http_util.dart';
import 'package:flutter_reader_app/public_widget/custom_appbar.dart';
import 'package:flutter_reader_app/public_widget/custom_toolbar.dart';
import 'package:flutter_reader_app/public_widget/my_widgets.dart';
import 'package:flutter_reader_app/my_pages/reader_pages/reader_page_chater.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ReaderBookPage extends StatefulWidget {
  String book;
  String bookName;
  String chapterNum;
  String cover;
  String author;
  ReaderBookPage({@required this.book, @required this.bookName, this.chapterNum,this.cover,this.author});
  @override
  _ReaderBookPageState createState() => _ReaderBookPageState();
}

class _ReaderBookPageState extends State<ReaderBookPage> {
  RefreshController _refreshController;
  BookReaderHisVm readerHisVm;
  @override
  void initState() {
    super.initState();
    _refreshController =
      RefreshController(initialRefresh: false);
  }

  @override
  void deactivate(){
    //发送状态更改，不加延时会报错
    Future.delayed(Duration(milliseconds: 100)).then((e) {
      readerHisVm?.sendState();
    });
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onRefresh(ReaderBookVm vm) async{
    // monitor network fetch
    bool res= await vm.uploadUpOrNextContent(type: LoadType.upLoad);
    if (res) {
      _refreshController.refreshCompleted();
    }else{
      _refreshController.refreshFailed();
    }
  }

  void _onLoading(ReaderBookVm vm) async{
    bool res = await vm.uploadUpOrNextContent();
    if (res) {
      _refreshController.loadComplete();
    }else{
      _refreshController.loadNoData();
    }
  }

  @override
  Widget build(BuildContext context) {

    readerHisVm = Provider.of<BookReaderHisVm>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ReaderBookVm>.value(value: ReaderBookVm(
          widget.book, 
          chapterNum: widget.chapterNum,
          cover: widget.cover,
          author: widget.author,
          bookName: widget.bookName,
          readerHisVm: readerHisVm
        )),
        ChangeNotifierProvider<ReaderBookToolVm>.value(value: ReaderBookToolVm()),
        ChangeNotifierProvider<ReaderBookDrawVm>.value(value: ReaderBookDrawVm()),
        ChangeNotifierProvider<CustomBottomBarVm>.value(value: CustomBottomBarVm()),
        ChangeNotifierProvider<ReaderStyleVm>.value(value: ReaderStyleVm()),
      ],
      child: Consumer4<AppStyleVm,ReaderBookVm,ReaderStyleVm,ReaderBookDrawVm>(
        builder: (context, styVm, vm, readerStyVm, drawVm, child){
          if (vm.status == RequestStatus.success) {
            widget.chapterNum = vm.chapterNum;
            if (readerStyVm.readerStyModel.colorIndex == null) {
              readerStyVm.readerStyModel.colorIndex = (styVm.styleModel.style == Brightness.light?0:1);
            }
            return  Scaffold(
              backgroundColor: readerStyleColors[readerStyVm.readerStyModel.colorIndex],
              body: (vm.content?.length != 0) ? 
              Stack(
                children: <Widget>[
                  _getContentWidget(context,vm),
                  Consumer2<ReaderBookToolVm,CustomBottomBarVm>(builder: (context, toolVm, bottomVm,child){
                    return toolVm.toolIsOpen?
                    ReaderPageTool(
                      titleBar: InkWell(
                        onTap: (){},
                        child: CustomAppBar(
                          backgroundColor: readerStyleColors[readerStyVm.readerStyModel.colorIndex],
                          bottomLineColor: Colors.transparent,
                          defLeftIconColor: readerStyVm.readerStyModel.getTextColor(),
                          title: Text(
                            widget.bookName,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(34),
                              fontWeight: FontWeight.bold,
                              color: readerStyVm.readerStyModel.getTextColor()
                            ),
                          ),
                        ),
                      ),
                      bottomBar: CustomBottomBar(
                        onTap: (index){
                          switch (index) {
                            case 0:
                              toolVm.checkToolIsOpen();
                              drawVm.checkDrawIsOpen();
                              break;
                            default:
                          }
                        },
                      ),
                      closeCallback: (){
                        toolVm.checkToolIsOpen();
                        bottomVm.isShowDetailMenu = false;
                      },
                    ):
                    Container();
                  }),
                  drawVm.drawIsOpen?ReaderPageChater(
                    book: widget.book,
                    chapterNum: int.parse(widget.chapterNum) ?? 1,
                    callback: (index){
                      vm.chapterNum = index.toString();
                      vm.updateBookContent(widget.book);
                    },
                    closeCallBack: (){
                      drawVm.checkDrawIsOpen();
                    },
                  ):Container(),
                ],
              ):
              Center(
                child: AutoColorText("没有数据~"),
              )
            );
          }else if (vm.status == RequestStatus.loading) {
            return LoadingWidget();
          }else{
            return RequestFailWidget(refreshCallback: (){
              vm.refreshData();
            });
          }
        }
      ),
    );
  }
  Widget _getContentWidget(context, ReaderBookVm vm) =>
    SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 15,right: 15,top: 0),
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: CustomHeader(builder: (BuildContext context,RefreshStatus mode){
              Widget body ;
              if(mode==RefreshStatus.idle){
                body =  AutoColorText("下拉加载...");;
              }
              else if(mode==RefreshStatus.refreshing){
                body =  CupertinoActivityIndicator();
              }
              else if(mode == RefreshStatus.failed){
                body = AutoColorText("没有上一章了~");
              }
              else if(mode == RefreshStatus.canRefresh){
                body = AutoColorText("松手,加载上一章!");
              }
              return Container(
                height: 60.0,
                child: Center(child:body),
              );
          }),
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
                body = AutoColorText("松手,加载下一章!");
              }
              else{
                body = AutoColorText("没有更多章节了!");
              }
              return Container(
                height: 60.0,
                child: Center(child:body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: (){
            _onRefresh(vm);
          },
          onLoading: (){
            _onLoading(vm);
          },                
          child: ListView.builder(
            itemCount: vm.models.length,
            itemBuilder: (context, index){
              var model = vm.models[index];
              return Consumer<ReaderBookToolVm>(builder: (context, toolVm, child){
                return InkWell(
                  onTap: (){
                    toolVm.checkToolIsOpen();
                  },
                  child: Consumer2<ReaderStyleVm, AppStyleVm>(builder: (context, readerStyVm, styVm,child) =>
                    Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: ScreenUtil().setWidth(60),
                          child: Text(
                            model.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: readerStyVm.readerStyModel.fontSize,
                              color: readerStyVm.readerStyModel.getTextColor(),
                            ),
                          ),
                        ),
                        Container(
                          height: model.content.length<100?ScreenUtil.screenHeight:null,
                          child: Text(
                            model.content,
                            style: TextStyle(
                              fontSize: readerStyVm.readerStyModel.fontSize,
                              color: readerStyVm.readerStyModel.getTextColor(),
                            ),
                            // semanticsLabel: "sssss",
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
            }
          ),
        ),
      ),
    );
}