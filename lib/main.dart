import 'package:flutter/material.dart';
import './config/colors/MyColors.dart';
import './pages/Index.dart';
import 'package:provide/provide.dart';
import 'provide/IndexProvider.dart';

void main() {
  //初始化具体的peovider
  IndexProvide indexProvide = IndexProvide();

  //初始化Providers
  Providers provides = new Providers();
  provides
    ..provide(Provider<IndexProvide>.value(indexProvide));

  runApp(ProviderNode(child: MyApp(), providers: provides));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: MyColors.colorTheme
      ),
      home: IndexPage(),

    );
  }
}


