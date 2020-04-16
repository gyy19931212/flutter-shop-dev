import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/colors/MyColors.dart';
import '../api/service_method.dart';
import 'dart:convert';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

///描述：
///author：gyy
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: _buildBody(context),
      backgroundColor: MyColors.colorF6F6F8,
    );
  }

  _buildBody(BuildContext context) {
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    GlobalKey<RefreshFooterState> _keyFooter =
        new GlobalKey<RefreshFooterState>();

    return FutureBuilder(
        future: request('homePageContext', formData: formData),
        builder: (context, val) {
          if (val.hasData) {
            var data = json.decode(val.data.toString());
            List<Map> swiperDataList =
                (data['data']['slides'] as List).cast(); // 顶部轮播组件数
            List<Map> navigatorList =
                (data['data']['category'] as List).cast(); //类别列表
            String advertesPicture =
                data['data']['advertesPicture']['PICTURE_ADDRESS']; //广告图片
            String leaderImage = data['data']['shopInfo']['leaderImage']; //店长图片
            String leaderPhone = data['data']['shopInfo']['leaderPhone']; //店长电话
            List<Map> recommendList =
                (data['data']['recommend'] as List).cast(); // 商品推荐
            String floor1Title =
                data['data']['floor1Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
            String floor2Title =
                data['data']['floor2Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
            String floor3Title =
                data['data']['floor3Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
            List<Map> floor1 =
                (data['data']['floor1'] as List).cast(); //楼层1商品和图片
            List<Map> floor2 =
                (data['data']['floor2'] as List).cast(); //楼层1商品和图片
            List<Map> floor3 =
                (data['data']['floor3'] as List).cast(); //楼层1商品和图片

            return EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: _keyFooter,
                loadingText: "加载更多",
                textColor: MyColors.colorWhite,
                bgColor: MyColors.colorTheme,
              ),
              child: Scrollbar(
                  child: Column(
                children: <Widget>[
                  _buildSwipe(context, swiperDataList), //轮播图
                  _buildGrid(context, navigatorList), //grid布局
                  _buildImage(context, advertesPicture, null), //广告图片
                  _buildImage(context, leaderImage, leaderPhone), //店长图片
                  _buildRecommend(context, recommendList), //商品推荐
                ],
              )),
              loadMore: () {},
            );
          } else {
            return Center(child: Text("数据加载中"));
          }
        });
  }

  //轮播图
  _buildSwipe(BuildContext context, List<Map> swiperDataList) {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(360),
      color: Colors.amberAccent,
      child: Swiper(
        itemCount: swiperDataList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Image.network("${swiperDataList[index]['image']}",
                fit: BoxFit.cover),
          );
        },
        pagination: SwiperPagination(),
        onTap: (int index) {},
        autoplay: true,
      ),
    );
  }

  //grid
  _buildGrid(BuildContext context, List<Map> navigatorList) {
    if (navigatorList.length > 10) {
      navigatorList = navigatorList.sublist(0, 10);
    }
    var tempIndex = -1;
    return Container(
      height: ScreenUtil().setHeight(300),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(5),
        children: navigatorList.map((item) {
          tempIndex++;
          return _buildGridItem(context, item, tempIndex);
        }).toList(),
      ),
    );
  }

  //grid item
  Widget _buildGridItem(BuildContext context, item, index) {
    // print('------------------${item}');
    return InkWell(
      onTap: () {
//        _goCategory(context,index,item['mallCategoryId']);
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  //广告图片 GestureTapCallback
  _buildImage(BuildContext context, String imageUrl, String phone) {
    return GestureDetector(
      child: Container(
        child: Image.network(imageUrl),
      ),
      onTap: () async {
        if (phone.isNotEmpty && await canLaunch("tel:17717572318")) {
          await launch("tel:17717572318");
          print('17717572318');
        }
      },
    );
  }

  //商品推荐
  _buildRecommend(BuildContext context, List<Map> recommendList) {
    return Column(
      children: <Widget>[
        SizedBox(height: ScreenUtil().setHeight(10)),
        Container(
          padding: EdgeInsets.only(left: 10),
          height: ScreenUtil().setHeight(60),
          width: double.infinity,
          alignment: Alignment.centerLeft,
          child: Text(
            '商品推荐',
            style: TextStyle(
              color: MyColors.colorRed,
            ),
          ),
        ),
        Divider(
          height: 1.0,
          indent: 0.0,
          color: MyColors.color999999,
        ),
        Container(
          height: ScreenUtil().setHeight(350),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recommendList.length,
              itemBuilder: (context, index) {
                return __recommendItem(context, recommendList, index);
              }),
        ),
      ],
    );
  }

  //商品推荐 listview的item
  __recommendItem(BuildContext context, List<Map> recommendList, int index) {
    return Container(
        decoration: BoxDecoration(
            color: MyColors.colorWhite,
            border: Border(
                right: Divider.createBorderSide(context,
                    color: MyColors.color999999, width: 0.5))),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Image.network('${recommendList[index]['image']}',
                  width: ScreenUtil().setHeight(250),
                  height: ScreenUtil().setHeight(250)),
            ),
            Text('${recommendList[index]['mallPrice']}'),
            SizedBox(height: 5),
            Text('${recommendList[index]['price']}',
            style: TextStyle(
              color: MyColors.color999999,
              decoration: TextDecoration.lineThrough
            ),),
          ],
        ));
//    return Container(
//        Padding(padding: EdgeInsets.all(20)),
//      child: Column(
//        children: <Widget>[
//      child: Image.network('${recommendList[index]['image']}',
//          width: ScreenUtil().setHeight(300),
//          height: ScreenUtil().setHeight(300)),),
//
//          Text('${recommendList[index]['mallPrice']}'),
//          Text('${recommendList[index]['price']}'),
//        ],)
//      );
  }
}
