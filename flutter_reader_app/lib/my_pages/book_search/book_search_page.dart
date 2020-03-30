import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_models/book_search_hot_model.dart';
import 'package:flutter_reader_app/my_pages/book_search/book_hot_result.dart';
import 'package:flutter_reader_app/my_pages/book_search/book_search_res.dart';
import 'package:flutter_reader_app/my_vm/appstyle_vm.dart';
import 'package:flutter_reader_app/my_vm/book_seach_vm.dart';
import 'package:flutter_reader_app/public_widget/custom_appbar.dart';
import 'package:flutter_reader_app/public_widget/my_widgets.dart';
import 'package:flutter_reader_app/routers/app_routers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BookSearchPage extends StatelessWidget {
  TextEditingController _controller;
  FocusNode _focusNode;
  @override
  Widget build(BuildContext context) {
    _controller = TextEditingController();
    _focusNode = FocusNode();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BookSearchVm>.value(value: BookSearchVm()),
      ],
      child: Consumer<AppStyleVm>(builder: (context, styVm, child){
        return Scaffold(
          backgroundColor: styVm.styleModel.bgColor,
          appBar: CustomAppBar(
            backgroundColor: styVm.styleModel.appBarBgColor,
            bottomLineColor: Colors.transparent,
            leftActions: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 15),
                height: 30,
                width: ScreenUtil().setWidth(630),
                padding: EdgeInsets.only(left: 10,right: 6),
                decoration: BoxDecoration(
                  color: styVm.styleModel.searchBgColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: styVm.styleModel.searchIconColor,
                    ),
                    Expanded(
                      child: _getSearchBar(),
                    ),
                    Consumer<BookSearchVm>(builder: (context, vm, child) =>
                      InkWell(
                        onTap: (){
                          _controller.clear();
                          vm.resetSearchLoading();
                          vm.checkSearchBarTextIsEmpty(true);
                        },
                        child: !vm.searchBarTextIsEmpty ? Icon(
                          Icons.cancel,
                          color: styVm.styleModel.searchIconColor,
                        ):Container(),
                      )
                    )
                  ],
                )
              ), 
            ],
            rightActions: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 5),
                child: IconButton(
                  icon: Text(
                    "取消",
                    style: TextStyle(
                      color: styVm.styleModel.textColor,
                      fontSize: ScreenUtil().setSp(28),
                    ),
                  ),
                  onPressed: (){
                    AppRouter.router.pop(context);
                  },
                ),
              )
            ],
          ),  
          body: Consumer<BookSearchVm>(builder: (context, vm, child) =>
            !vm.searchLoading ? 
            SearchHotPage(itemOnTap: (text){
              _focusNode.unfocus();
              _controller.text = text;
              vm.checkSearchBarTextIsEmpty(false);
              vm.setCacheHistoryHot(text);
              vm.sendSearchLoading(text);
            }):
            BookSearchRes(),
          ),
        );

      }),
    );
  }

  Widget _getSearchBar() =>
    Consumer2<AppStyleVm, BookSearchVm>(builder: (context, styVm, vm, child) => 
      Padding(
        padding: EdgeInsets.only(left: 5),
        child: TextField(
          autofocus: true,
          controller: _controller,
          style: TextStyle(
            color: styVm.styleModel.textColor
          ),
          decoration: InputDecoration(
            hintText: "书籍名称",
            hintStyle: TextStyle(
              color: styVm.styleModel.textSubColor,
              fontSize: ScreenUtil().setSp(26),
            ),
            contentPadding: EdgeInsets.all(0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none),
          ),
          textInputAction: TextInputAction.search,
          cursorColor: styVm.styleModel.searchInputCursorColor,
          focusNode: _focusNode,
          onSubmitted: (text){
            if (text.replaceAll(" ", "").isNotEmpty) {
              vm.setCacheHistoryHot(text);
              vm.sendSearchLoading(text);
            }else{
              AppCommnWidgets.showToast("请输入搜索类容");
            }
          },
          onChanged: (text){
            if (text.isEmpty) {
              vm.resetSearchLoading();
              vm.checkSearchBarTextIsEmpty(true);
            }else{
              vm.checkSearchBarTextIsEmpty(false);
            }
          },
        ),
      ),
    );
}