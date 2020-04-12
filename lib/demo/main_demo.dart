import 'package:flutter/material.dart';
import 'package:flutter_app/demo/TimerPage.dart';
import 'package:flutter_app/demo/RoutePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RoutePage(),
      routes: {
//        "firstRoute": (context)=> FirstRoutePage("dd")
      },
      //路由守卫
      onGenerateRoute: (RouteSettings settings){
        var name = settings.name;
        switch(name) {
          case "firstRoute" :
            print("onGenerateRoute " + name);
            return MaterialPageRoute(builder: (context) {
                return FirstRoutePage("dd");
            });
            break;
        }
      },
    );
  }
}


