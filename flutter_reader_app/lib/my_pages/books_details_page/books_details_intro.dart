import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_vm/appstyle_vm.dart';
import 'package:flutter_reader_app/public_widget/custom_expansionTitle.dart';
import 'package:flutter_reader_app/public_widget/my_widgets.dart';
import 'package:flutter_reader_app/utils/utils_tool.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_reader_app/my_models/book_info_model.dart';
import 'package:common_utils/common_utils.dart';

class BookIntro extends StatelessWidget {

  final BookInfo info;
  final Function onTap;
  BookIntro(this.info,{this.onTap});

  @override
  Widget build(BuildContext context) {
    return  Consumer<AppStyleVm>(
      builder: (context, vm, child) =>
        Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Column(
            children: <Widget>[
              _getLongIntroTitleWidget(context,vm),
              _getLongIntroContentWidget(context,vm),
              _getNewChaptersWidget(context,vm),
            ],
          ),
        ),
      );
  }
  //简介标题栏
  Widget _getLongIntroTitleWidget(context,AppStyleVm vm) =>
    Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(top: 10,bottom: 0),
      child: Text(
        "简介",
        style: TextStyle(
          color: vm.styleModel.textColor,
          fontSize: ScreenUtil().setSp(30),
        ),
      ),
    );

  //简介类容<可收缩>
  Widget _getLongIntroContentWidget(context,AppStyleVm vm) =>
    Container(
      padding: EdgeInsets.only(top: 10,bottom: 10,left: 10),
      child: CustomExpansionTitle(
        title:info.longIntro,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: vm.styleModel.textSubColor,
          fontSize: ScreenUtil().setSp(28),
        ),
        minLines: 3,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: vm.styleModel.segmentLineColor,
            width: 0.5,
          ),
        ),
      ),
    );

  //最新章节信息
  Widget _getNewChaptersWidget(context,AppStyleVm vm) =>
    InkWell(
      onTap: this.onTap??(){},
      child: Container(
        padding: EdgeInsets.only(top: 10,bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "目录",
              style: TextStyle(
                color: vm.styleModel.textColor,
                fontSize: ScreenUtil().setSp(30),
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  "${UtilTools.getTimeLine(context, info.updated)}更新  ",
                  style: TextStyle(
                    color: vm.styleModel.textSubColor,
                    fontSize: ScreenUtil().setSp(24),
                  ),
                ),
                Text(
                  getNewChapters(info.lastChapter)??"第${info.lastChapter}章",
                  style: TextStyle(
                    color: vm.styleModel.textSubColor,
                    fontSize: ScreenUtil().setSp(24),
                  ),
                ),
                AutoColorIcon(
                  Icons.keyboard_arrow_right,
                ),
              ],
            )
          ],
        ),
      ),
    );

  
  String getNewChapters(String str){
    var match = RegExp(r"(第(?:.*)章)").firstMatch(str);
    return match?.group(1);
  }
}