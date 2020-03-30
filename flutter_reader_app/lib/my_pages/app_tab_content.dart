import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_reader_app/static_constant/constant.dart';
import 'package:provider/provider.dart';
import 'package:flutter_reader_app/network_tool/http_util.dart';
import 'package:flutter_reader_app/my_vm/appstyle_vm.dart';
import 'package:flutter_reader_app/my_vm/appconmmn_vm.dart';
import 'package:flutter_reader_app/my_pages/tab_pages/tab_frist_pages/bookshelf_home.dart';
import 'package:flutter_reader_app/my_pages/tab_pages/tab_two_pages/bookmall_home.dart';
import 'package:flutter_reader_app/my_pages/tab_pages/tab_three_pages/me_home.dart';
import 'package:flutter_reader_app/utils/app_store.dart';

class AppTabContent extends StatefulWidget {
  @override
  _AppTabContentState createState() => _AppTabContentState();
}

class _AppTabContentState extends State<AppTabContent> with WidgetsBindingObserver{
  List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = List()
                ..add(BookshelfPage())
                ..add(BookMallPage())
                ..add(MePage());

    //请求所有小说分类并且存储
    HttpUtil.request(HttpUrlInfo.all_category).then((val){
      AppStoreUtil.setStoreString(AppStoreUtil.all_category_key, jsonEncode(val));
    });

    WidgetsBinding.instance.addObserver(this);
    
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

    @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
      });
    }else if(state == AppLifecycleState.paused){
    }
  }

  @override
  Widget build(BuildContext context) {
    MyConstant.appInitSet(context);
    return Consumer2<AppStyleVm,AppConmmnVm>(builder: (context,vm,conmVm,widget){
      final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
      if (vm.styleModel.style != brightnessValue) {
        Timer(Duration(milliseconds: 100), () {
          // 只在倒计时结束时回调
          vm.chekStyleFromStyle(brightnessValue);
        });
      }
      return Scaffold(
        body: IndexedStack(
          index: conmVm.tabIndex,
          children: this._pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: conmVm.tabIndex,
          items: [
            _createBottomBarItem(Icons.book, "书架"),
            _createBottomBarItem(Icons.local_mall, "书城"),
            _createBottomBarItem(Icons.people, "我的"),
          ],
          backgroundColor: vm.styleModel.appBarBgColor,
          // selectedItemColor: ,
          onTap: (index){
            conmVm.checkTabIndex(index);
          },
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 13,
          unselectedFontSize: 12,
          selectedItemColor: Color.fromRGBO(221, 191, 144, 1.0),
          unselectedItemColor: vm.styleModel.appBarIconColor,
          showUnselectedLabels: true,
          // selectedLabelStyle: TextStyle(
          //   color: Color.fromRGBO(221, 191, 144, 1.0),
          // ),
          // unselectedLabelStyle: TextStyle(
          //   color: vm.styleModel.appBarBgColor,
          // ),
        ),
        backgroundColor: vm.styleModel.bgColor,
      );
    });
  }
BottomNavigationBarItem _createBottomBarItem(IconData icon, String title) 
  => BottomNavigationBarItem(
      icon: Icon(icon),
      title: Text(
        title,
      ),
    );
}