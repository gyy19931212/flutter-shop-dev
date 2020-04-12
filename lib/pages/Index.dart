import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../config/MyString.dart';
import 'Home.dart';
import 'Goods.dart';
import 'Cart.dart';
import 'Mine.dart';
import '../provide/IndexProvider.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///描述：入口文件
///author：gyy
class IndexPage extends StatelessWidget {
  List<BottomNavigationBarItem> bottomBars = new List();
  List<Widget> pages = new List();

  @override
  Widget build(BuildContext context) {
    //初始化首页的四个page
    _initBottomBars();
    _initPages();
    //初始化ScreenUtil
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: false)..init(context);

    return Provide<IndexProvide>(builder: (context, child , val){
      int currentIndex = val.bottomIndex;
      return Scaffold(
        //可以改造用 IndexStack
        body: _showPage(currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          //type必须指定，否则显示有问题
          type: BottomNavigationBarType.fixed,
          items: bottomBars,
          currentIndex: currentIndex,
          onTap: (index){
            Provide.value<IndexProvide>(context).changeBottomIndex(index);
//            _showPage(index);
          },
        ),
      );
    });

  }

  //初始化首页的四个page
  _initBottomBars() {
    bottomBars.add(BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home), title: Text(APP_HOME)));
    bottomBars.add(BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), title: Text(APP_GOODS)));
    bottomBars.add(BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), title: Text(APP_CART)));
    bottomBars.add(BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text(APP_MINE)));
  }

  _initPages() {
    pages.add(HomePage());
    pages.add(GoodsPage());
    pages.add(CartPage());
    pages.add(MinePage());
  }

  _showPage(int index) {
    return pages[index];
  }
}
