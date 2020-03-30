import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_vm/appstyle_vm.dart';
import 'package:flutter_reader_app/my_vm/book_chatpers_vm.dart';
import 'package:flutter_reader_app/public_widget/custom_appbar.dart';
import 'package:flutter_reader_app/public_widget/my_widgets.dart';
import 'package:flutter_reader_app/routers/app_router_handlers.dart';
import 'package:flutter_reader_app/routers/app_routers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BookChapterPage extends StatelessWidget {
  String book;
  String bookName;
  bool showAppBar;
  
  BookChapterPage({this.book,this.bookName,this.showAppBar = true});

  Widget build(BuildContext context) {
    print("BookChapterPage - build");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BookChapterVm>.value(value: BookChapterVm(this.book))
      ],
      child: Consumer<AppStyleVm>(builder: (context, styVm, child) =>
        Scaffold(
          backgroundColor: styVm.styleModel.bgColor,
          appBar: this.showAppBar ? CustomAppBar(
            defLeftIconColor: styVm.styleModel.appBarIconColor,
            backgroundColor: styVm.styleModel.appBarBgColor,
            bottomLineColor: Colors.transparent,
            title: Text(
              this.bookName,
              style: TextStyle(
                color: styVm.styleModel.appBarIconColor,
                fontSize: ScreenUtil().setSp(34),
                fontWeight: FontWeight.bold
              ),
            ),
          ):null,
          body: SafeArea(
            child: Consumer<BookChapterVm>(builder: (context, vm, child) {
              if (vm.bookChapters != null) {
                return ListView.builder(
                  itemCount: vm.bookChapters.mixToc.chapters.length,
                  itemBuilder: (context, index) =>
                    Container(
                      child: ListTile(
                        title: Text(
                          vm.bookChapters.mixToc.chapters[index].title??"",
                          style: TextStyle(
                            color: styVm.styleModel.textColor,
                            fontSize: ScreenUtil().setSp(28),
                          ),
                        ),
                        onTap: (){
                          AppRouter.navigateTo(context, 
                            RouterPageName.reader_book, 
                            params: {
                              "book":this.book,
                              "bookName":this.bookName,
                              "chapterNum":"${index+1}",
                            }
                          );
                        },
                      ),
                    ),
                );
              }else{
                return LoadingWidget();
              }
            }
          ),
        )
      ),
    )
    );
  }
}