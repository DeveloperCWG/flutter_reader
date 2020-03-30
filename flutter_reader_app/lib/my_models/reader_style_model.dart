import 'package:flutter/material.dart';

const readerStyleColors = [
  Colors.white,//明亮
  Color.fromRGBO(20, 20, 20, 1.0),//暗黑
  Color.fromRGBO(253, 245, 230, 1.0),//亚麻
  Color.fromRGBO(238,229,222, 1.0),//桃花
  Color.fromRGBO(240,255,240, 1.0),
  Color.fromRGBO(255,255,240, 1.0),//象牙
  Color.fromRGBO(240,255,240, 1.0),//蜂蜜
  Color.fromRGBO(255,248,220, 1.0),//玉米色
];

const readerTextColors = [
  Colors.black,
  Colors.white70,
];

class ReaderStyleModel {
  double fontSize;
  int colorIndex;
  bool isDark;
  
  Color getTextColor(){
    return this.colorIndex == 1?readerTextColors[1]:readerTextColors[0];
  }

  ReaderStyleModel({
    this.fontSize = 17.0,
    this.colorIndex,
  }){
    this.isDark = this.colorIndex==0?false:true;
  }

  factory ReaderStyleModel.fromJson(Map<String,dynamic> json){
    return ReaderStyleModel(
      fontSize: json["fontSize"],
      colorIndex: json["colorIndex"],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "fontSize": this.fontSize,
      "colorIndex": this.colorIndex,
    };
  }
}