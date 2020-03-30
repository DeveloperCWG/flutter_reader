import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_models/category_big_child_model.dart';
import 'package:flutter_reader_app/my_vm/appstyle_vm.dart';
import 'package:flutter_reader_app/my_vm/category_big&child_vm.dart';
import 'package:flutter_reader_app/network_tool/http_util.dart';
import 'package:flutter_reader_app/public_widget/custom_appbar.dart';
import 'package:flutter_reader_app/public_widget/my_widgets.dart';
import 'package:flutter_reader_app/routers/app_router_handlers.dart';
import 'package:flutter_reader_app/routers/app_routers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BookAllCagtegoryPage extends StatelessWidget {
  final String type;
  String typeName;

  BookAllCagtegoryPage({
    @required this.type,
  }){
    if (type =="0") {
      this.typeName = "male";
    } else if (type =="1") {
      this.typeName = "female";
    } else {
      this.typeName = "press";
    }
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryBigAndChildVm>.value(value: CategoryBigAndChildVm(type)),
      ],
      child: Consumer<AppStyleVm>(builder: (context, styVm, child) =>
        Scaffold(
          backgroundColor: styVm.styleModel.bgColor,
          appBar: CustomAppBar(
            backgroundColor: styVm.styleModel.appBarBgColor,
            bottomLineColor: Colors.transparent,
            defLeftIconColor: styVm.styleModel.appBarIconColor,
            title: Text(
              "分类",
              style: TextStyle(
                color: styVm.styleModel.textColor,
                fontSize: ScreenUtil().setSp(34),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Consumer<CategoryBigAndChildVm>(builder: (context, vm, child){
            if (vm.requestStatus == RequestStatus.success) {
              if (vm.list.length>0) {
                return ListView.builder(
                  itemCount: vm.list.length,
                  itemBuilder: (context, index) =>
                    _getItemCell(vm.list[index]),
                );
              }else{
                return Center(
                  child: AutoColorText("没有找到数据~"),
                );
              }
            }else if (vm.requestStatus == RequestStatus.fail){
              return Center(
                child: RequestFailWidget(refreshCallback: (){
                  vm.updateAllCategory();
                }),
              );
            }else{
              return LoadingWidget();
            }
          }),
        ),
      ),
    );
  }

  Widget _getItemCell(ChildCategoryTag childModel) =>
    Consumer<AppStyleVm>(builder: (context, styVm, child) =>
      Container(
        margin: EdgeInsets.only(left: 15,right: 15),
        child: Column(
          children: <Widget>[
            childModel.mins.length>0 ? _getItemCellTitle(childModel.major):Container(),
            childModel.mins.length>0 ? _getItemCellCantent(childModel.mins,childModel.major):Container(),
          ],
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: childModel.mins.length>0 ? styVm.styleModel.segmentLineColor:Colors.transparent,
              width: 0.5,
            )
          )
        ),
      ),
    );

  Widget _getItemCellTitle(String title) =>
    Consumer<AppStyleVm>(builder: (context, styVm, child) =>
      Container(
        height: ScreenUtil().setSp(80),
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            color: styVm.styleModel.textColor,
            fontSize: ScreenUtil().setSp(32),
          ),
        ),
      )
    );
  Widget _getItemCellCantent(List<String> list, String title) =>
    Consumer<AppStyleVm>(builder: (context, styVm, child) =>
      Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 10,right: 10,bottom: 15),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: list.map<Widget>((item){
            return InkWell(
              onTap: (){
                AppRouter.navigateTo(context, RouterPageName.child_category_books,params: {
                  "major":title,
                  "gender":this.typeName,
                  "minor":item,
                });
              },
              child:AppCommnWidgets.getTagWidget(item),
            );
          }).toList(),
        )
      )
    );

}