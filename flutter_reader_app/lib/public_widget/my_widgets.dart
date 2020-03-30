import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter_reader_app/my_models/app_style_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_reader_app/my_vm/appstyle_vm.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AppCommnWidgets {
  static Widget getLoadingWidget(context) => 
    Center(
      child: Consumer<AppStyleVm>(
        builder: (context,vm,child) => 
          // CupertinoActivityIndicator(),
            CircularProgressIndicator(
            backgroundColor: vm.styleModel.textSubColor,
            valueColor: AlwaysStoppedAnimation<Color>(vm.styleModel.bgColor),
          ),
      ),
    );
  static Widget getCoverImgWidget(context, {String url, double width, height}) =>
    CachedNetworkImage(
      imageUrl: url,
      errorWidget: (context, str, obj) =>
        Container(
          height: height ?? double.infinity,
          width: width ?? double.infinity,
          color: Colors.grey[200],
          child: Center(
            child: Icon(
              Icons.broken_image,
              size: 50,
              color: Colors.grey,
            ),
          ),          
        ),
      placeholder: (context,str) =>
        Container(  
          height: height ?? double.infinity,
          width: width ?? double.infinity,
          color: Colors.grey[200],
          child: Center(
            child: Icon(
              Icons.image,
              size: 50,
              color: Colors.grey,
            ),
          ),
        ),
      fit: BoxFit.cover,
      height: height ?? double.infinity,
      width: width ?? double.infinity,
    );
  static Widget getSegment(context, {Color color, double height = 10}) =>
   Container(
     width: double.infinity,
     height: height,
     color: color??Color.fromRGBO(220, 220, 220, 1.0),
   );

   static showToast(
     String msg, 
    {Color backgroundColor,
    Color textColor,
    double fontSize = 16
   }){
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: 16.0
      );
   }

   static getTagWidget(String title,{Color bgColor, textColor}) =>
     Consumer<AppStyleVm>(builder: (context, styVm, child){
       bgColor = (bgColor == null?styVm.styleModel.searchBgColor:bgColor);
       textColor = (textColor == null?styVm.styleModel.textSubColor:textColor);
       return Container(
          height: 26,
          padding: EdgeInsets.only(left: 8,right: 8,top: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: bgColor,
          ),
          child: Text(
            title??"",
            style: TextStyle(
              color: title!= null ? textColor:Colors.transparent,
              fontSize: ScreenUtil().setSp(26),
            ),
          ),
      );
     });
    
}


class AutoColorText extends StatelessWidget {
  String title;
  int maxLins;
  TextStyle style;
  AutoColorText(this.title,{this.style}); 
  @override
  Widget build(BuildContext context) {
    kToolbarHeight;
    return Consumer<AppStyleVm>(builder: (context, vm, widget) => 
      Text(
        this.title,
        maxLines: this.maxLins??1,
        overflow: TextOverflow.ellipsis,
        style: this.style ?? TextStyle(
          color: vm.styleModel.textColor,
        )
      ),
    );
  }
}

class AutoColorIcon extends StatelessWidget {
  IconData iconData;
  Color color;
  double size;
  AutoColorIcon(this.iconData,{
    this.color,
    this.size,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStyleVm>(builder: (context, vm, widget) => 
      Icon(
        iconData,
        color: this.color ?? vm.styleModel.appBarIconColor,
        size: this.size,
      ),
    );
  }
}

class MyWidgetLib {
  static Widget createTab(String title,double width) => Tab(
    child: Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(width),
      child: AutoColorText(title),
    ),
  );
}

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStyleVm>(builder: (context,vm,child) =>
      Scaffold(
        backgroundColor: vm.styleModel.bgColor,
        body: Center(
          child: AppCommnWidgets.getLoadingWidget(context),
        ),
      )
    );
  }
}

class RequestFailWidget extends StatelessWidget {
  Function refreshCallback;
  RequestFailWidget({
    this.refreshCallback,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStyleVm>(builder: (context,vm,child) =>
      Scaffold(
        backgroundColor: vm.styleModel.bgColor,
        body: Center(
          child: InkWell(
            onTap: this.refreshCallback,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AutoColorIcon(
                  Icons.refresh,
                  size: 50,
                  color: vm.styleModel.textSubColor,
                ),
                SizedBox(height: 10,),
                AutoColorText("失败! 点击重新加载"),
              ],
            )
          ),
        ),
      )
    );
  }
}

class CustomCheckBox extends StatefulWidget {
  final bool initStatus;
  final Widget child;
  final Widget actionWidget;
  final Function(bool) onTap;
  CustomCheckBox({
    @required this.onTap,
    this.initStatus = false,
    this.child,
    this.actionWidget,
  });
  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool currentStatus;
  @override
  void initState() {
    super.initState();
    currentStatus = widget.initStatus;
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: this.currentStatus ? widget.actionWidget??Container() : widget.child??Container(),
      onTap: (){
        setState(() {
          this.currentStatus = !this.currentStatus;
          widget.onTap(this.currentStatus);
        });
      },
    );
  }
}





 

