import 'package:flutter/material.dart';


///描述：管理底部tab 的provide
///author：gyy
class IndexProvide with ChangeNotifier{
 int bottomIndex = 0;

 changeBottomIndex(int bottomIndex) {
   this.bottomIndex = bottomIndex;
   notifyListeners();
}

}