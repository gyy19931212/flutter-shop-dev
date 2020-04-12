import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/colors/MyColors.dart';
import '../api/service_method.dart';
import 'dart:convert';
import 'package:flutter_easyrefresh/easy_refresh.dart';

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
                  _buildAdvers(context, advertesPicture), //广告图片

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
    if(navigatorList.length > 10) {
      navigatorList = navigatorList.sublist(0, 10);
    }
    var tempIndex=-1;
    return Container(
      color: MyColors.colorTheme,
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
  Widget _buildGridItem(BuildContext context,item,index){
    // print('------------------${item}');
    return InkWell(

      onTap: (){
//        _goCategory(context,index,item['mallCategoryId']);
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'],width:ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  //广告图片
  _buildAdvers(BuildContext context, String imageUrl) {
    return Container(
      child: Image.network(imageUrl)
    );
  }

}
