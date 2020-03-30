import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_models/book_search_hot_model.dart';
import 'package:flutter_reader_app/my_vm/appstyle_vm.dart';
import 'package:flutter_reader_app/my_vm/book_seach_vm.dart';
import 'package:flutter_reader_app/public_widget/my_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SearchHotPage extends StatelessWidget {
  Function(String) itemOnTap;
  SearchHotPage({
    @required this.itemOnTap,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer2<AppStyleVm,BookSearchVm>(builder: (context, styVm, vm, child){
      if (vm.searchHotModel != null) {
        return ListView(
          children: <Widget>[
            _getWrapWidget(
              "热门推荐",
              children: vm.randomHots.map((item){
                return _getTagItem(hot: item);
              }).toList(),
              onTap: (){
                vm.getRandomItem();
              },
              rightText: "换一批",
              rightIcon: AutoColorIcon(Icons.refresh,size: 20,color: styVm.styleModel.textSubColor),
            ),
            // vm.historySearchTexts.isNotEmpty ? AppCommnWidgets.getSegment(context,color: styVm.styleModel.segmentLineColor):Container(),
            vm.historySearchTexts.isNotEmpty ? _getWrapWidget(
              "搜索历史",
              children: vm.historySearchTexts.map((item){
                return _getTagItem(title: item);
              }).toList(),
              onTap: (){
                vm.clearCacheHistoryHot();
              },
              rightText: "清除",
              rightIcon: AutoColorIcon(Icons.restore_from_trash,size: 20,color: styVm.styleModel.textSubColor),
            ):Container(),
          ],
        );
      }else{
        return LoadingWidget();
      }
    });
  }

  Widget _getResTitleWidget(String title,{String rightText, Widget rightIcon, Function onTap}){
    return Consumer2<AppStyleVm,BookSearchVm>(builder: (context, styVm, vm, child) =>
      Container(
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: styVm.styleModel.textColor,
                fontSize: ScreenUtil().setSp(32),
              ),
            ),
            InkWell(
              onTap: (){
                if (onTap != null) {
                  onTap();
                }
              }, 
              child: Row(
                children: <Widget>[
                  Text(
                    rightText ?? "",
                    style: TextStyle(
                      color: styVm.styleModel.textSubColor,
                      fontSize: ScreenUtil().setSp(28),
                    ),
                  ),
                  rightIcon??Container(),
                ],
              )
            )
          ],
        ),
      )
    );
  }

  Widget _getWrapWidget(String title, {@required List<Widget> children, String rightText, Widget rightIcon, Function onTap}) =>
   Consumer<BookSearchVm>(builder: (context, vm, child){
     return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      margin: EdgeInsets.only(top: 0,bottom: 15),
      child: Column(
        children: <Widget>[
          _getResTitleWidget(title,rightText: rightText, rightIcon: rightIcon, onTap: onTap),
          Container(
            width: double.infinity,
            child: Wrap(
              spacing:10,
              runSpacing: 10,
              children: children,
            ),
          )
        ],
      ),
    );
   });

  Widget _getTagItem({NewHotWords hot, String title = ""}){
    return Consumer<AppStyleVm>(builder: (context, styVm, child) =>
      InkWell(
        onTap: (){
          if (this.itemOnTap != null) {
            this.itemOnTap(hot != null?hot.word:title);
          }
        },
        child: AppCommnWidgets.getTagWidget(hot != null?hot.word:title)
      )
    );
  }
}