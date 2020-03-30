import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_pages/tab_pages/tab_two_pages/tab_two_pubwidgets.dart';
import 'package:flutter_reader_app/my_vm/appstyle_vm.dart';
import 'package:flutter_reader_app/my_vm/book_billboard_vm.dart';
import 'package:flutter_reader_app/network_tool/http_util.dart';
import 'package:flutter_reader_app/public_widget/custom_appbar.dart';
import 'package:flutter_reader_app/public_widget/my_widgets.dart';
import 'package:flutter_reader_app/routers/app_router_handlers.dart';
import 'package:flutter_reader_app/routers/app_routers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BillBoardPage extends StatelessWidget {
  String title;
  String gender;
  String billBoardId;
  BillBoardPage({
    this.title = "",
    @required this.gender,
    @required this.billBoardId,
  });
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BookBillboardVm>.value(value: BookBillboardVm(gender: this.gender, billBoardId: this.billBoardId)),
      ],
      child: Consumer<AppStyleVm>(builder: (context, styVm, child) =>
        Scaffold(
          backgroundColor: styVm.styleModel.bgColor,
          appBar: CustomAppBar(
            backgroundColor: styVm.styleModel.appBarBgColor,
            bottomLineColor: Colors.transparent,
            defLeftIconColor: styVm.styleModel.appBarIconColor,
            title: Text(
              this.title,
              style: TextStyle(
                color: styVm.styleModel.textColor,
                fontSize: ScreenUtil().setSp(34),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Consumer<BookBillboardVm>(builder: (context, vm, child){
            if (vm.requestStatus == RequestStatus.success) {
              if (vm.model.ranking != null && vm.model.ranking.books.length>0) {
                return ListView.builder(
                  itemCount: vm.model.ranking.books.length,
                  itemBuilder: (context, index) =>
                    Container(
                      margin: EdgeInsets.only(left: 15,right: 15),
                      child: TwoPagePubWidget.getItemChildContentCellWidget(context, vm.model.ranking.books[index], (){
                        AppRouter.navigateTo(context, RouterPageName.book_details,params: {
                          "book":vm.model.ranking.books[index].sId,
                        });
                      }),
                    )
                );
              }else{
                return Center(
                  child: AutoColorText("没有找到数据~"),
                );
              }
            } else if(vm.requestStatus == RequestStatus.fail) {
              return LoadingWidget();
            }else{
              return LoadingWidget();
            }
          }),
        ),
      ),
    );
  }
}