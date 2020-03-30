import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_vm/appstyle_vm.dart';
import 'package:flutter_reader_app/public_widget/my_widgets.dart';
import 'package:flutter_reader_app/utils/mock_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_reader_app/my_models/book_info_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BookComment extends StatelessWidget {

  final BookInfo info;
  BookComment(this.info);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        children: <Widget>[
          _getCommentTitle(),
          _getCommentContent(),
          _getCommentBottom(),
        ],
      ),
    );
  }

  Widget _getCommentTitle() => 
    Consumer<AppStyleVm>(builder: (context,vm,child) => 
      Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Text(
          "热门评论",
          style: TextStyle(
            color: vm.styleModel.textColor,
            fontSize: ScreenUtil().setSp(30)
          ),
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: vm.styleModel.segmentLineColor,
              width: 0.5,
            )
          )
        ),
      ),      
    );

  Widget _getCommentContent() => 
    Consumer<AppStyleVm>(builder: (context, vm, child) => 
      Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(150),
        child: Swiper(
          scrollDirection: Axis.vertical,
          itemCount: commentInfos.length,
          autoplay: true,
          loop: true,
          itemBuilder: (context,index) => 
            _getCommentItem(commentInfos[index]),
        ),
      ),
    );

  Widget _getCommentItem(commentInfo) => 
    Consumer<AppStyleVm>(builder: (context, vm, child) => 
      Container(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: ScreenUtil().setWidth(25),
                  child: Image.asset(
                    "images/user_haed.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    commentInfo["userName"],
                    style: TextStyle(
                      color:vm.styleModel.textSubColor,
                      fontSize: ScreenUtil().setSp(24), 
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 10),
              child: Text(
                commentInfo["comment"],
                maxLines: 2,
                style: TextStyle(
                  color: vm.styleModel.textSubColor,
                  fontSize: ScreenUtil().setSp(28),
                ),
              ),
            )
          ],
        ),
      ),
    );
  Widget _getCommentBottom() =>
   Consumer<AppStyleVm>(builder: (context, vm, child) => 
      Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "查看全部评论",
                  style: TextStyle(
                    color: vm.styleModel.textColor,
                    fontSize: ScreenUtil().setSp(30),
                  ),
                ),
                AutoColorIcon(Icons.keyboard_arrow_right),
              ],
            ),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: vm.styleModel.segmentLineColor,
                  width: 0.5,
                ),
                // bottom: BorderSide(
                //   color: vm.styleModel.segmentLineColor,
                //   width: 0.5,
                // ),
              )
            ),
          ),
        ],
      )
   );
}