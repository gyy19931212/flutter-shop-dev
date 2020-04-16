import 'package:flutter/material.dart';

class DemoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: mGridViewCount (context),
    );
  }
}

//GridView.count
mGridViewCount(BuildContext context) {
  return GridView.count(
    crossAxisCount: 2,
    children: List.generate(
      100,
          (index) {
        return Center(
          child: Text(
            'Item $index',
            style: Theme.of(context).textTheme.headline,
          ),
        );
      },
    ),
  );
}
//测试Transform
mTransform() {
  return Center(
    child: Transform(
      transform: Matrix4.rotationZ(0.0),
      child: Container(
        color: Colors.blue,
        width: 100.0,
        height: 100.0,
      ),
    ),
  );
}

//测试OverflowBox
mOverflowBox() {
  return Container(
    alignment: Alignment.center,
    color: Colors.green,
    padding: const EdgeInsets.all(5.0),
    child: Container(
      alignment: Alignment.center,
      width: 100.0,
      height: 100.0,
      color: Colors.red,
      child: OverflowBox(
        alignment: Alignment.topLeft,
        maxWidth: 150.0,
        maxHeight: 150.0,
        child: Container(
          color: Color(0x33FF00FF),
          width: 250.0,
          height: 250.0,
        ),
      ),
    ),
  );
 }

 //测试Offstage
class mOffstage extends StatefulWidget {
  @override
  _viewWidgetState createState() => _viewWidgetState();
}

class _viewWidgetState extends State<mOffstage> {
  bool offstage;

  @override
  initState() {
    super.initState();
    offstage = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 200,
        ),
        new Offstage(
          offstage: offstage,
          child: Container(color: Colors.blue, height: 100.0),
        ),
        new RaisedButton(
          child: Text("点击切换显示"),
          onPressed: () {
            setState(() {
              offstage = !offstage;
            });
          },
        ),
      ],
    );
  }
}
