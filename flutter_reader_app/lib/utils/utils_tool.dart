import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

class UtilTools {
  static String filteFofStr(String str) => 
    str.replaceAll(" ", "").replaceAll("\n", "");
  
  static String numFormatToStr(num scr){
    String result;
    if (scr>10000) {
      result = (scr/10000).toStringAsFixed(1)+"万";
    }else{
      result = scr.toString();
    }
    return result;
  }
  static String convertImageUrl(String imageUrl) {
    return imageUrl?.replaceAll("%2F", "/")?.replaceAll("%3A", ":")?.substring(7);
  }

    //返回格式化后的更新日期
  static String getTimeLine(BuildContext context, String date) {
    var timeMillis = DateUtil.getDateMsByTimeStr(DateTime.parse(date).toString());
    return TimelineUtil.format(
      timeMillis,
      locale: Localizations.localeOf(context).languageCode,
      dayFormat: DayFormat.Common
    );
  }
}

extension StringExtension on String{


}