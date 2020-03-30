import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_vm/appstyle_vm.dart';
import 'package:flutter_reader_app/public_widget/custom_appbar.dart';
import 'package:flutter_reader_app/public_widget/my_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStyleVm>(builder: (context, styVm, child){
      return Scaffold(
        backgroundColor: styVm.styleModel.bgColor,
        appBar: CustomAppBar(
          backgroundColor: styVm.styleModel.appBarBgColor,
          bottomLineColor: Colors.transparent,
          title: Text(
            "第三方pub",
            style: TextStyle(
              color: styVm.styleModel.textColor,
              fontSize: ScreenUtil().setSp(34),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: pubs.length,
          itemBuilder: (context, index) =>
            ListTile(
              title: AutoColorText(pubs[index]),
            )
        ),
      );
    });
  }
}

const List<String> pubs = [
  "flutter_swiper: ^1.1.6",
  "provider: ^4.0.4",
  "shared_preferences: ^0.5.6",
  "fluttertoast: ^4.0.1",
  "pull_to_refresh: ^1.5.8",
  "flutter_screenutil: ^1.0.2",
  "cached_network_image: ^2.0.0",
  "date_format: ^1.0.8",
  "common_utils: ^1.1.3 ",
  "flutter_html: ^0.11.1",
  "background_fetch: ^0.5.4",
  "fluro: ^1.6.2",
];