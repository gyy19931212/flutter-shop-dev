import 'package:flutter/material.dart';
import 'dart:async';

///第一个flutter界面
/// Timer定时器使用
class firstPage extends StatefulWidget {

  @override
  _firstPageState createState() => _firstPageState();
}

class _firstPageState extends State<firstPage> {
  var text = "firstPage";


  @override
  void initState() {
    ///初始化，这个函数在生命周期中只调用一次
    super.initState();

    new Timer(Duration(seconds: 2), () {
      _incrementCounter();
    });
  }


  void _incrementCounter() {
    setState(() {
      text = "firstPage + firstPage";
    });
  }
  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(color: Colors.cyanAccent,
    child: Center(
        child: Text(
          text,
      style: TextStyle(decoration: TextDecoration.none),
          textAlign: TextAlign.center,
        )
    ),

    );
  }


  


}
