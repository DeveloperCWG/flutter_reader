import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/services.dart';

const double iOSToolBarDefHeight = 44;
const double iOSbottomBarDefHeight = 50;

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {

  final double height;
  final Color backgroundColor;
  final List<Color> gradients;
  final Color bottomLineColor;
  final Color defLeftIconColor;
  final BoxShadow boxShadow;
  final double shadowOpacity;
  final Brightness brightness;
  final Widget title;
  final List<Widget>leftActions;
  final List<Widget>rightActions;
  final PreferredSizeWidget bottom;

  CustomAppBar({
    Key key,
    this.height,
    this.backgroundColor,
    this.gradients,
    this.bottomLineColor,
    this.defLeftIconColor,
    this.boxShadow,
    this.shadowOpacity = 0.1,
    this.brightness,
    this.title,
    this.leftActions,
    this.rightActions,
    this.bottom
  });


  @override
  Size get preferredSize {
    return Size(double.infinity, 
    (Platform.isIOS?iOSToolBarDefHeight:kToolbarHeight) + (bottom?.preferredSize?.height ?? 0.0));
  }

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppBarTheme appBarTheme = AppBarTheme.of(context);
    final Brightness brightness = widget.brightness
      ?? appBarTheme.brightness
      ?? theme.primaryColorBrightness;
    final SystemUiOverlayStyle overlayStyle = brightness == Brightness.light
      ? SystemUiOverlayStyle.light
      : SystemUiOverlayStyle.dark;

    double topPadding  = MediaQuery.of(context).padding.top;
    double contantHeight = widget.preferredSize.height;
    double maxHeight = widget.height??(contantHeight+ topPadding);

    Widget appBarCenterContent = Container(
      height: Platform.isIOS?iOSToolBarDefHeight:kToolbarHeight,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              // margin: EdgeInsets.only(left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: widget.leftActions ?? <Widget>[
                  Navigator?.canPop(context) ? 
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios,color: widget.defLeftIconColor??Colors.white), 
                    onPressed: () => Navigator?.pop(context),
                  ):Container(),
                ]
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: widget.title??Text(""),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              // margin: EdgeInsets.only(right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: widget.rightActions ?? <Widget>[
                  Container(),
                ]
              ),
            ),
          ),
        ],
      ),
    );

    Widget appBarBottomContent =  Container(
      height: widget.bottom?.preferredSize?.height ?? 0.0,
      child: widget.bottom??Container(),
    );

    Widget appBar = PreferredSize(
      preferredSize: Size(double.infinity, maxHeight),
      child: Container(
        alignment: Alignment.bottomCenter,
        width: double.infinity,
        height: maxHeight,
        decoration: BoxDecoration(
          color: widget.gradients != null?null:widget.backgroundColor ?? Theme.of(context).primaryColor,
          gradient: widget.gradients != null?LinearGradient(colors: widget.gradients):null,
          border: Border(
            bottom: BorderSide(
              color: widget.bottomLineColor??Color.fromRGBO(230, 230, 230, 1.0),
              width: 0.5,
            ),
          ),
          boxShadow: [
            widget.boxShadow ?? BoxShadow(
              color: Color.fromRGBO(150, 150, 150, 1.0).withOpacity(widget.shadowOpacity>0.1 ? 0.1:widget.shadowOpacity),
              offset: Offset(0.0, 0), //阴影xy轴偏移量
              blurRadius: 5.0, //阴影模糊程度
              spreadRadius: 2.0 //阴影扩散程度
            )
          ],
        ),
        child: Container(
          alignment: Alignment.bottomCenter,
          // color: Colors.purple,
          height: contantHeight,
          child: Column(
            children: <Widget>[
              appBarCenterContent,
              appBarBottomContent
            ],
          )
        ),
      ),
    );

    return Semantics(
      container: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: Material(
          color: Colors.transparent,
          child: Semantics(
            explicitChildNodes: true,
            child: appBar,
          ),
        ),
      ),
    );
    
  }
}
