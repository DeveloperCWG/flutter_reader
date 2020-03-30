import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_vm/appstyle_vm.dart';
import 'package:flutter_reader_app/my_vm/book_chatpers_vm.dart';
import 'package:flutter_reader_app/public_widget/my_widgets.dart';
import 'package:flutter_reader_app/static_constant/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ReaderPageChater extends StatefulWidget {
  final String book;
  final String bookName;
  final int chapterNum;
  final Function(int) callback;
  Function closeCallBack;

  ReaderPageChater({
    @required this.book,
    this.bookName,
    this.chapterNum = 1,
    this.callback,
    @required this.closeCallBack,
  });

  @override
  _ReaderPageChaterState createState() => _ReaderPageChaterState();
}

class _ReaderPageChaterState extends State<ReaderPageChater> with TickerProviderStateMixin{

  AnimationController _controller;
  ScrollController _scroVc;
  @override
  void initState() {
    super.initState();
    _scroVc = ScrollController(initialScrollOffset: 45.0*(widget.chapterNum-1));
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    _controller.forward();
    
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _scroVc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BookChapterVm>.value(value: BookChapterVm(widget.book))
      ],
      child: Consumer2<AppStyleVm,BookChapterVm>(builder: (context, styVm, vm, child) {

        return InkWell(
          onTap: (){
              _controller.reverse();
              _controller.addStatusListener((status){
                if (status == AnimationStatus.dismissed) {
                  widget.closeCallBack();
                }
              });
          },
          child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.2),
          body: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(-1.0, 0.0),
                end: Offset(0.0, 0.0),
              ).animate(CurvedAnimation(
                parent: _controller, 
                curve: Curves.easeInOut)
              ),
              child: vm.bookChapters !=null?Container(
                color: styVm.styleModel.bgColor,
                width: ScreenUtil().setWidth(MyConstant.designWidth*0.65),
                child: SafeArea(
                  child: ListView.builder(
                    controller: _scroVc,
                    itemCount: vm.bookChapters.mixToc.chapters.length,
                    itemBuilder: (context, index) =>
                      Container(
                        height: 45,
                        child: ListTile(
                          title: Text(
                            vm.bookChapters.mixToc.chapters[index].title??"",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: styVm.styleModel.textColor,
                              fontSize: ScreenUtil().setSp(28),
                            ),
                          ),
                          onTap: (){
                            _controller.reverse();
                            _controller.addStatusListener((status){
                              if (status == AnimationStatus.dismissed) {
                                if (widget.callback != null) widget.callback(index+1);
                                if (widget.closeCallBack != null) widget.closeCallBack();
                              }
                            });
                          },
                        ),
                      ),
                  ),
                ),
              ):Container(
                color: styVm.styleModel.bgColor,
                width: ScreenUtil().setWidth(MyConstant.designWidth*0.65),
                child: LoadingWidget(),
              ),
            ),
          ),
        );

        }
      ),
    );
  }
}