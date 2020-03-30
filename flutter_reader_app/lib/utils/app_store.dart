import 'package:shared_preferences/shared_preferences.dart';

enum StoreStutus{
  start,
  success,
  fail,
}

class AppStoreUtil {

  static String all_category_key = "all_category_key";
  static String all_category_next = "all_category_next_key";
  static String all_charts_category = "all_charts_category";
  static String one_charts_books = "one_charts_books";
  static String reader_style = "reader_style";
  static String search_his_texts = "search_his_texts";
  static String reader_his_list = "reader_his_list";

  static StoreStutus status = StoreStutus.start;

  static Future<String> getStoreString(String key) async{
     try {
       SharedPreferences pres = await SharedPreferences.getInstance();
       status = StoreStutus.success;
       return pres.getString(key);
     } catch (e) {
       status = StoreStutus.fail;
       print("key:$key   本地取值出错:${e.toString()}");
       return null;
     }
  }

  static Future<bool> setStoreString(String key,value) async{
    try {
      SharedPreferences pres = await SharedPreferences.getInstance();
      return pres.setString(key,value);
    } catch (e) {
      print("本地存值出错:${e.toString()}");
      return null;
    }
  }

  static Future<bool> clear() async{
    try {
      SharedPreferences pres = await SharedPreferences.getInstance();
      return pres.clear();
    } catch (e) {
      print("本地缓存清除出错:${e.toString()}");
      return null;
    }
  }

}
