
import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_vm/appstyle_vm.dart';
import 'package:flutter_reader_app/public_widget/my_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_reader_app/my_models/book_info_model.dart';
import 'package:flutter_reader_app/utils/utils_tool.dart';

class BookDetailScore extends StatelessWidget {
  final BookInfo info;
  BookDetailScore(this.info);
  @override
  Widget build(BuildContext context) {
    return scoreWidget(context,info);
  }

  //评分模块
  Widget scoreWidget(context,BookInfo info) =>
    Consumer<AppStyleVm>(builder: (context,vm,child) => 
      Container(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
        child:Column(
          children: <Widget>[
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                scoreItemWidget(context,"评分${info.rating.score.toString()}","${UtilTools.numFormatToStr(info.rating.count)}人参与"),
                scoreItemWidget(context,"${info.retentionRatio}%","读者留存"),
                scoreItemWidget(context, UtilTools.numFormatToStr(info.latelyFollower),"7日人气"),
                scoreItemWidget(context,UtilTools.numFormatToStr(info.totalFollower),"累计人气"),
              ],
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(200),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/boarder.png"),
                        fit: BoxFit.fill,
                      ),
                      border: Border(
                        bottom: BorderSide(
                          color: vm.styleModel.segmentLineColor,
                          width: 0.5,
                        )
                      )
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 30,right: 30),
                      child: Text(
                        "${listFormatToString(info.tags)}${info.longIntro}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: vm.styleModel.textColor
                        ),
                      ),
                    )
                  ),
                  Container(
                    height: ScreenUtil().setHeight(70),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            AutoColorIcon(Icons.trending_up),
                            AutoColorText("「飙升榜」 ",style: TextStyle(
                              fontSize: ScreenUtil().setSp(28),
                              fontWeight: FontWeight.bold,
                              color: vm.styleModel.textColor,
                            ),),
                            AutoColorText(
                              info.contentLevel>0 ? "当前上升${info.contentLevel.abs()}名":"当前下降${info.contentLevel.abs()}名"
                            ),
                          ],
                        ),
                        // AutoColorIcon(Icons.keyboard_arrow_right),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )
      )
    );

  Widget scoreItemWidget(context,String title,subTitle) =>
    Consumer<AppStyleVm>(builder: (context,vm,child) => 
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: vm.styleModel.textColor,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(28),
            ),
          ),
          Text(
            subTitle,
            style: TextStyle(
              color: vm.styleModel.textSubColor,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(24),
            ),           
          )
        ],
      ),
    ); 


    String listFormatToString(List<String> list){
      String result = "";
      list.forEach((val){
        result+="+$val";
      });
      result = result.replaceFirst("+", "");
      return "【$result】";
    }
}