import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_pages/tab_pages/tab_two_pages/books_epub_page.dart';
import 'package:flutter_reader_app/public_widget/custom_appbar.dart';
import 'package:flutter_reader_app/routers/app_router_handlers.dart';
import 'package:flutter_reader_app/routers/app_routers.dart';
import 'package:flutter_reader_app/static_constant/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_reader_app/public_widget/my_widgets.dart';
import 'package:flutter_reader_app/my_vm/appstyle_vm.dart';
import 'package:flutter_reader_app/my_pages/tab_pages/tab_two_pages/books_male_page.dart';
import 'package:flutter_reader_app/my_pages/tab_pages/tab_two_pages/books_female_page.dart';

class BookMallPage extends StatefulWidget {
  @override
  _BookMallPageState createState() => _BookMallPageState();
}

class _BookMallPageState extends State<BookMallPage> with SingleTickerProviderStateMixin, WidgetsBindingObserver{
  TabController _tabController;
  List<Widget> _tables;
  List<Widget> _tabs;
  String _type;
  static const int _childPages = 3;

  @override
  void initState(){
    super.initState();
    _type = "0";
    _tabController = TabController(length: _childPages, vsync: this);
    _tables = List()
                ..add(BooksMallMalePage(0))
                ..add(BooksMallFemalePage(1))
                ..add(BooksMallEnupPage(2));

    _tabs = List()
              ..add(MyWidgetLib.createTab("男生",MyConstant.designWidth/_childPages))
              ..add(MyWidgetLib.createTab("女生",MyConstant.designWidth/_childPages))
              // ..add(MyWidgetLib.createTab("轻小说",MyConstant.designWidth/_childPages))
              ..add(MyWidgetLib.createTab("出版",MyConstant.designWidth/_childPages));

    _tabController.addListener((){
      _type = _tabController.index.toString();
    });

  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: MyConstant.vmMallSetBindList,
      child: Consumer<AppStyleVm>(builder: (context, vm, widget) {
      return Scaffold(
        backgroundColor: vm.styleModel.bgColor,
        appBar: CustomAppBar(
          leftActions: <Widget>[
            InkWell(
              onTap: (){
                AppRouter.navigateTo(context, RouterPageName.book_search);
              },
              child: Container(
                margin: EdgeInsets.only(left: 15),
                height: 30,
                width: ScreenUtil().setWidth(640),
                decoration: BoxDecoration(
                  color: vm.styleModel.searchBgColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.search,
                    color: vm.styleModel.searchIconColor,
                  ),
                ),
              ),
            )
          ],
          rightActions: <Widget>[
            IconButton(
              icon: AutoColorIcon(Icons.menu),
              onPressed: () {
                AppRouter.navigateTo(context, RouterPageName.book_all_category,params: {"type":_type});
              }),
          ],
          backgroundColor: vm.styleModel.appBarBgColor,
          bottomLineColor: Colors.transparent,
          bottom:TabBar(
            controller: _tabController,
            isScrollable: false,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: vm.styleModel.textColor,
            tabs: this._tabs,
          ), 
        ),
        body:TabBarView(
          controller: _tabController,
          children: this._tables
        ),
      );
    }),
    );
  }

}
