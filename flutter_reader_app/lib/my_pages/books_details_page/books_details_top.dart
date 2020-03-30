import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_vm/appstyle_vm.dart';
import 'package:flutter_reader_app/public_widget/my_widgets.dart';
import 'package:flutter_reader_app/utils/utils_tool.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_reader_app/my_models/app_style_model.dart';
import 'package:flutter_reader_app/my_models/book_info_model.dart';
import 'package:flutter_reader_app/static_constant/constant.dart';

class BookDetailTop extends StatelessWidget {
  final BookInfo info;
  BookDetailTop(this.info);

  @override
  Widget build(BuildContext context) {
    return topWidget(context, this.info);
  }

  Widget topWidget(context, BookInfo info) => 
    Container(
        width: ScreenUtil().setWidth(MyConstant.designWidth),
        height: ScreenUtil().setWidth(MyConstant.designWidth / 3 * 2),
        child: Consumer<AppStyleVm>(
            builder: (context, vm, child) => Container(
                  child: Stack(
                    children: <Widget>[
                      Image.asset(
                        vm.styleModel.style == Brightness.dark
                            ? "images/book_info_dark.jpg"
                            : "images/book_info_light.jpg",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        colorBlendMode: BlendMode.colorDodge,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          width: double.infinity,
                          height: ScreenUtil().setWidth(MyConstant.designWidth / 3 * 2) - 100.0,
                          child: Row(
                            children: <Widget>[
                              AppCommnWidgets.getCoverImgWidget(context,
                                  url: UtilTools.convertImageUrl(info.cover),
                                  width: ScreenUtil().setWidth(180),
                                  height: ScreenUtil().setHeight(200)),
                              bookInfoWidget(context, info),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                      ),
                    ],
                  ),
                )
              ),
      );

  Widget bookInfoWidget(context, BookInfo info) {
    return Consumer<AppStyleVm>(
        builder: (context, vm, child) => Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    info.title,
                    style: TextStyle(
                      color: vm.styleModel.textColor,
                      fontSize: ScreenUtil().setSp(30),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  bookInfoText(context, info.author, info.cat),
                  bookInfoText(
                      context, "${info.safelevel}书币/千字", "${UtilTools.numFormatToStr(info.wordCount)}字"),
                  AutoColorText(
                    "开通VIP 立享8折",
                    style: TextStyle(
                      color: Color.fromRGBO(221, 101, 124, 1.0),
                    ),
                  )
                ],
              ),
            ));
  }

  Widget bookInfoText(context, String title, String subTitle,
          {double margin}) =>
      Consumer<AppStyleVm>(
        builder: (context, vm, child) => Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: margin ?? 5.0),
              child: Text(
                title,
                style: TextStyle(
                  color: vm.styleModel.textColor,
                  fontSize: ScreenUtil().setSp(28),
                ),
              ),
            ),
            Container(
              height: ScreenUtil().setHeight(24),
              width: ScreenUtil().setWidth(2.0),
              color: vm.styleModel.textSubColor,
            ),
            Container(
              margin: EdgeInsets.only(left: margin ?? 5.0),
              child: Text(
                subTitle,
                style: TextStyle(
                  color: vm.styleModel.textSubColor,
                  fontSize: ScreenUtil().setSp(26),
                ),
              ),
            ),
          ],
        ),
      );
}
