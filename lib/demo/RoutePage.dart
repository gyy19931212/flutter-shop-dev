import 'package:flutter/material.dart';

///1, 普通路由，传参
///2，命名路由传参
class FirstRoutePage extends StatelessWidget {
  var text;

  FirstRoutePage(this.text);

  @override
  Widget build(BuildContext context) {

    //获取上个界面的参数
    var a = ModalRoute.of(context).settings.arguments.toString();
    print("ModalRoute" + a);

    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            //接受上一个界面的参数
            Text("我是上个界面传递的： " + text),
            RaisedButton(onPressed: (){
              //传参给上一个界面
              Navigator.pop(context, "第二个界面 - 数据");
            },
              child: Text("点击返回"),
            )
          ],
        ),
      ),
    );
  }

}


class RoutePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateRoutePage();
  }

}

class StateRoutePage extends State<RoutePage>{
  var result = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text("我是第一个界面"),
            RaisedButton(onPressed: () async{
              var result1 = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                //传参给下一个界面
                return FirstRoutePage("第一个界面 - 数据");
              }));

              setState(() {
                result = result1;
              });
            },

              child: Text("点击跳转" + result),
            ),
            RaisedButton(
              child: Text("打开命名路由" + result),
              onPressed: () async {
                //传递给一下一个界面的数据
                var result1 = await Navigator.of(context).pushNamed("firstRoute", arguments: {"name": "哈哈哈"});
                setState(() {
                  result = result1;
                });
              } ,

            )
          ],
        ),
      ),
    );
  }

}
