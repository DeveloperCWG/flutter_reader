import 'package:flutter/material.dart';
import 'package:flutter_reader_app/my_models/all_books_charts_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_reader_app/my_vm/appstyle_vm.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_reader_app/static_constant/constant.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_reader_app/public_widget/my_widgets.dart';
import 'package:flutter_reader_app/utils/utils_tool.dart';


class TwoPagePubWidget {

  static Widget getSwiperWidget(context, List<String> urls, {ValueChanged onIndexChanged,SwiperOnTap onTap}) => 
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.only(left: 15,right: 15,top: 5),
        child: AspectRatio(
          aspectRatio: 8 / 3, //配置宽高比
          child: Consumer<AppStyleVm>(builder: (context,vm,child) => 
            Swiper(
              pagination: SwiperPagination(
                margin: EdgeInsets.all(6),
                builder: DotSwiperPaginationBuilder(
                  color: vm.styleModel.bgColor,
                  activeColor: vm.styleModel.textSubColor,
                  size: 6,
                  activeSize: 6
                )
              ), //指示器
              scrollDirection: Axis.horizontal, //滚动方向
              controller: SwiperController(), //
              // viewportFraction: 0.8,
              scale: 0.9,
              autoplay: true,
              loop: true,
              itemCount: urls.length,
              onIndexChanged: onIndexChanged,
              onTap: onTap,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: urls[index],
                  placeholder: (context, str) => AppCommnWidgets.getLoadingWidget(context),
                  fit: BoxFit.cover,
                  // errorWidget: (context, str, obj) => ErrorWidget(obj),
                );
              },
            ),
          ),
        ),
      );

  static Widget getItemChildContentCellWidget(context, Book model, Function callback) => 
      InkWell(
        onTap: callback,
        child: Consumer<AppStyleVm>(
          builder: (context,vm,child) => 
            Container(
              width: ScreenUtil().setWidth(MyConstant.designWidth),
              height: ScreenUtil().setHeight(200),
              padding: EdgeInsets.only(
                top: 15,
                bottom: 15,
              ),
              decoration: BoxDecoration(
                // color: Colors.pink,
                border: Border(
                  bottom: BorderSide(
                    color: vm.styleModel.segmentLineColor,
                    width: 0.5,
                  )
                )
              ),
              child: Row(
                children: <Widget>[
                  AppCommnWidgets.getCoverImgWidget(
                    context, 
                    url: UtilTools.convertImageUrl(model.cover),
                    width: ScreenUtil().setWidth(150),
                  ),
                  getContentCenterWidget(context, model),
                ],
              ),
            ),
        ),
      );


  static Widget getContentCenterWidget(context, Book model){
    return Consumer<AppStyleVm>(builder: (context,vm,child) => 
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(left: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                model.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: vm.styleModel.textColor,
                  fontSize: ScreenUtil().setSp(32),
                ),
              ),
              Text(
                UtilTools.filteFofStr(model.shortIntro),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: vm.styleModel.textSubColor,
                  fontSize: ScreenUtil().setSp(28),
                ),
              ),
              getContentBottomWidget(context, model),
            ],
          ),
        ),
      ),
    );
  }
  
  static Widget getContentBottomWidget(context, Book model){
    return Consumer<AppStyleVm>(builder: (context,vm,child) => 
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.account_circle,
                size: ScreenUtil().setSp(33),
                color: vm.styleModel.searchIconColor,
              ),
              Text(
                model.author,
                style: TextStyle(
                  color: vm.styleModel.textSubColor,
                  fontSize: ScreenUtil().setSp(24),
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 5,right: 5,bottom: 2),
            child: Text(
              model.minorCate??model.cat??"",
              maxLines: 1,
              style: TextStyle(
                color:vm.styleModel.textSubColor,
                fontSize: ScreenUtil().setSp(20), 
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: (model.cat==null && model.minorCate==null) ? Colors.transparent:vm.styleModel.searchBgColor,
            ),
          )
        ],
      ),
    );
  }
}