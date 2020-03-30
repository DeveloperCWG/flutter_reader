import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_models/app_style_model.dart';
import 'package:flutter_reader_app/my_models/reader_style_model.dart';
import 'package:flutter_reader_app/my_vm/appstyle_vm.dart';
import 'package:flutter_reader_app/my_vm/reader_style_vm.dart';
import 'package:flutter_reader_app/public_widget/custom_toolbar_item.dart';
import 'package:flutter_reader_app/public_widget/my_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'custom_appbar.dart';

class CustomToolBar extends StatelessWidget {
  final double height;
  final Color backgroundColor;
  final Alignment alignment;
  final EdgeInsets padding;
  final BoxShadow boxShadow;
  final List<Widget>childen;

  CustomToolBar({
    this.height,
    this.backgroundColor,
    this.alignment,
    this.padding,
    this.boxShadow,
    this.childen,
  });

  @override
  Widget build(BuildContext context) {
    return 
      Container(
        alignment: this.alignment ?? Alignment.topLeft,
        width: double.infinity,
        height: ScreenUtil.bottomBarHeight+(this.height??iOSbottomBarDefHeight),
        decoration: BoxDecoration(
          color: this.backgroundColor??Theme.of(context).backgroundColor,
          boxShadow: [
            this.boxShadow ?? BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0.0, -1.0), //阴影xy轴偏移量
              blurRadius: 5.0, //阴影模糊程度
              spreadRadius: 2.0 //阴影扩散程度
            )
          ],
        ),
        child: Container(
          padding: this.padding,
          width: double.infinity,
          height: iOSbottomBarDefHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: this.childen ?? <Widget>[],
          ),
        ),
      );
  }
}

class CustomBottomBarVm with ChangeNotifier {
  bool isShowDetailMenu;
  CustomBottomBarVm({this.isShowDetailMenu = false});

  checkShowState(){
    this.isShowDetailMenu = !this.isShowDetailMenu;
    notifyListeners();
  }
}

class CustomBottomBar extends StatelessWidget {
  final Function(int) onTap;

  CustomBottomBar({this.onTap});
  
  @override
  Widget build(BuildContext context) {
    return Consumer2<ReaderStyleVm,CustomBottomBarVm>(
        builder: (context, readerStyVm, menuStateVm, child) =>
          InkWell(
            onTap: (){},
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15,top: menuStateVm.isShowDetailMenu?10:0),
              height: ScreenUtil.bottomBarHeight+iOSbottomBarDefHeight+(menuStateVm.isShowDetailMenu?160:0),
              decoration: BoxDecoration(
                color: readerStyleColors[readerStyVm.readerStyModel.colorIndex],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: Offset(0.0, -1.0), //阴影xy轴偏移量
                    blurRadius: 5.0, //阴影模糊程度
                    spreadRadius: 2.0 //阴影扩散程度
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: menuStateVm.isShowDetailMenu?
                  <Widget>[
                    _getHiglightToolBar(),
                    _getAaToolBar(),
                    _getCheckBoxToolBar(),
                    _getBottomBar(readerStyVm, menuStateVm),
                  ]:
                  <Widget>[
                    _getBottomBar(readerStyVm, menuStateVm),
                  ],
              ),
            ),
          )
    );
  }
  Widget _getAaItemBtn({@required String title, @required Function onPressed}){
    return Consumer<ReaderStyleVm>(builder: (context, readerStyVm, child) => 
      Container(
        width: 62,
        height: 30,
        decoration: BoxDecoration(
          border: Border.all(
            color: readerStyVm.readerStyModel.getTextColor(),
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: FlatButton(onPressed: onPressed, child: AutoColorText(title)),
      ),
    );
  }

  Widget _getAaToolBar(){
    return Consumer<ReaderStyleVm>(builder: (context, readerStyVm, child) =>
      Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _getAaItemBtn(title: "Aa-", onPressed: (){
              if (readerStyVm.readerStyModel.fontSize>13) {
                readerStyVm.checkStyFontSize(false);
              }
            }), 
            AutoColorText(
              "${readerStyVm.readerStyModel.fontSize-12}",
            ),
            _getAaItemBtn(title: "Aa+", onPressed: (){
              if (readerStyVm.readerStyModel.fontSize<20) {
                readerStyVm.checkStyFontSize(true);
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _getHiglightToolBar(){
    return Container(
      height: 50,
      child: Slider(value: 0.0, onChanged: (val){

      }),
    );
  }

  Widget _getCheckBoxToolBar(){
    return Consumer2<AppStyleVm, ReaderStyleVm>(builder: (context, styVm, readerStyVm, child) =>
      CustomCheckBoxToolBar(
        height: 50, 
        selectedIndex: readerStyVm.readerStyModel.colorIndex??(styVm.styleModel.style == Brightness.light?0:1),
        itemData: readerStyleColors,
      ),
    );
  }

  Widget _getBottomBar(ReaderStyleVm readerStyVm, CustomBottomBarVm menuStateVm){
    return CustomToolBar(
      backgroundColor: readerStyleColors[readerStyVm.readerStyModel.colorIndex],
      boxShadow:BoxShadow(
        color: Colors.black.withOpacity(0),
        offset: Offset(0.0, 0), //阴影xy轴偏移量
        blurRadius: 0, //阴影模糊程度
        spreadRadius: 0 //阴影扩散程度
      ),
      childen: <Widget>[
        ToolBarItem(
          icon: Icon(
            Icons.storage,
            color: readerStyVm.readerStyModel.getTextColor(),
          ), 
          onTap: (){
            if (this.onTap != null) this.onTap(0);
          },
        ),
        ToolBarItem(
          icon: Icon(
            Icons.arrow_downward,
            color: readerStyVm.readerStyModel.getTextColor(),
          ), 
          onTap: (){
            if (this.onTap != null) this.onTap(1);
          },
        ),
        ToolBarItem(
          icon: Icon(
            Icons.settings,
            color: readerStyVm.readerStyModel.getTextColor(),
          ), 
          onTap: (){
            if (this.onTap != null) this.onTap(2);
            menuStateVm.checkShowState();
          },
        ),
      ],
    );
  }
  
}

class CustomCheckBoxToolBar extends StatefulWidget {
  final double width;
  final double height;
  final List<Color> itemData;
  final int selectedIndex;
  final Function onTap;
  CustomCheckBoxToolBar({this.width, this.selectedIndex = 0, @required this.height, @required this.itemData, this.onTap,});
  @override
  _CustomCheckBoxToolBarState createState() => _CustomCheckBoxToolBarState();
}

class _CustomCheckBoxToolBarState extends State<CustomCheckBoxToolBar> {

  int selectedIndex;

  @override
  void initState() {
    super.initState();
    this.selectedIndex = widget.selectedIndex;

  }

  List<Widget> refreshChilden(Function(int) onTap){
    return List.generate(widget.itemData.length, (index){
      return InkWell(
        onTap: (){
          setState(() {
            this.selectedIndex = index;
          });
          onTap(index);
        },
        child: Consumer<AppStyleVm>(builder: (context, styVm, child) =>
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            width: 50,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: widget.itemData[index],
              border: Border.all(
                color: styVm.styleModel.appBarIconColor,
                width: 0.5,
              )
            ),
            child: index == this.selectedIndex ? Icon(
              Icons.check,
              color: Color.fromRGBO(221, 191, 144, 1.0),
            ):Text(""),
          ),
        ),
      );
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height??50,
      width: widget.width??double.infinity,
      child: Consumer2<ReaderStyleVm, AppStyleVm>(builder: (context, readerStyVm, styVm, child) =>
        ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: this.refreshChilden((index){
                readerStyVm.checkStyBgColor(index);
                // if (readerStyVm.readerStyModel.colorIndex == 1) {
                //   styVm.chekStyleFromStyle(MyAppStyle.dark);
                // }else{
                //   styVm.chekStyleFromStyle(MyAppStyle.light);
                // }
              })??[],
            )
          ],
        ),
      ),
    );
  }
}