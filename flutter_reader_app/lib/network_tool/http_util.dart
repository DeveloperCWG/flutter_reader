
import 'dart:convert';

import 'package:dio/dio.dart';

enum RequestStatus{
  loading,
  success,
  fail,
}

class HttpUtil {

  static RequestStatus status = RequestStatus.loading;

  static Dio dio = Dio();
  
  static Future request(String url,{Map<String, dynamic> queryParameters}) async {
    try {
      Response response = await dio.get(url,queryParameters: queryParameters);
      if (response.statusCode == 200) {
        status = RequestStatus.success;
        return jsonEncode(response.data);
      }else{
         status = RequestStatus.fail;
        print("URL:$url 请求出错,error:${response.statusCode}");
        return "";
      }
    } catch (e) {
      status = RequestStatus.fail;
      print("URL:$url 请求出错,error:${e.toString()}");
      return "";
    }
  }
  
}

class HttpUrlInfo {

  static const String base_url = "http://api.zhuishushenqi.com";
  static const String base_mebile_url = "http://m.zhuishushenqi.com/book";

  static const String all_category = base_url+"/cats/lv2/statistics";// 所有小说分类
  static const String all_charts_category = base_url+"/ranking/gender"; //所有排行榜类型
  static const String one_charts_books = base_url+"/ranking"; //某个榜单的书籍
  static const String all_category_next = base_url+"/cats/lv2"; //分类下小类别
  static const String one_category_books = base_url+"/book/by-categories"; //根据分类获取小说列表
  static const String one_book_info = base_url+"/book"; //获取小说信息
  static const String one_book_btoc = base_url+"/btoc"; //获取小说正版源
  static const String one_book_atoc = base_url+"/atoc"; //获取小说正版源和盗版源(混合)
  static const String book_directories1 = base_url+"/atoc"; //获取小说目录(根据小说id)
  static const String book_directories2 = base_url+"/mix-atoc"; //获取小说目录(根据小说id)
  static const String book_content = base_mebile_url; //获取章节类容信息
  static const String book_search_hot = "http://b.zhuishushenqi.com/book/hot-word";//搜索热词
  static const String search_auto_fill = base_url+"/book/auto-complete"; //搜索自动联想
  static const String search_result = base_url+"/book/fuzzy-search"; //发起模糊搜索
  static const String book_new_chapters = base_url+"/book"; //发起模糊搜索


}