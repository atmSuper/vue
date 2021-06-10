import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("布局练习"),
      ),
      body: Container(
        // child: Column(
        //   children: [
        //     Container(
        //       color: Colors.red,
        //       width: 100,
        //       height: 100,
        //     ),
        //     Container(
        //       color: Colors.green,
        //       width: 150,
        //       height: 100,
        //     ),
        //     Container(
        //       color: Colors.yellow,
        //       width: 100,
        //       height: 100,
        //     ),
        //   ],
        // ),
        // child: Row(
        // textDirection: TextDirection.rtl,
        //   mainAxisSize: MainAxisSize.max,
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     Container(
        //       color: Colors.red,
        //       width: 100,
        //       height: 200,
        //     ),
        //     Container(
        //       color: Colors.green,
        //       width: 150,
        //       height: 100,
        //     ),
        //     Container(
        //       color: Colors.yellow,
        //       width: 100,
        //       height: 100,
        //     ),
        //   ],
        // ),
        // child: Flex(
        //   direction: Axis.vertical,
        //   children: [
        //     Expanded(
        //       child: Container(
        //         color: Colors.red,
        //         width: 100,
        //         height: 200,
        //       ),
        //       flex: 1,
        //     ),
        //     Expanded(
        //       child: Container(
        //         color: Colors.green,
        //         width: 100,
        //         height: 200,
        //       ),
        //       flex: 2,
        //     ),
        //     Expanded(
        //       child: Container(
        //         color: Colors.yellow,
        //         width: 100,
        //         height: 200,
        //       ),
        //       flex: 1,
        //     ),
        //   ],
        // ),
        // child: WrapDemo(),
        // child: StackDemo(),
        // child: AlignDemo(),
        // child: EdgeDemo(),
        child: ContainerDemo(),
      ),
    );
  }
}

class WrapDemo extends StatefulWidget {
  @override
  _WrapDemoState createState() => _WrapDemoState();
}

class _WrapDemoState extends State<WrapDemo> {
  List<int> list = List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var i = 0; i < 20; i++) {
      list.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      alignment: WrapAlignment.spaceAround,
      spacing: 1.0,
      runSpacing: 1.0,
      children: list
          .map((e) => Container(
                height: 100,
                width: 100,
                child: Text(e.toString()),
                color: Colors.blue,
              ))
          .toList(),
    );
  }
}

class StackDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          color: Colors.green,
          width: 100,
          height: 100,
        ),
        Container(
          color: Colors.red,
          width: 50,
          height: 20,
        ),
        Positioned(
          width: 20,
          height: 10,
          child: Container(
            color: Colors.yellow,
          ),
          // top: 10,
          // bottom: 10,
          // // left: 10,
          // right: 10,
        ),
      ],
    );
  }
}

class AlignDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      color: Colors.green,
      child: Align(
        //-1 - 1
        alignment: Alignment.topLeft,
        child: FlutterLogo(
          size: 60,
        ),
      ),
    );
  }
}

class EdgeDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: 100,
    //   height: 100,
    //   color: Colors.red,
    //   margin: EdgeInsets.all(8), //外边距
    //   padding: EdgeInsets.all(20), //内边距
    //   child: Text("data"),
    // );
    // return ConstrainedBox(
    //   constraints: BoxConstraints(
    //     minHeight: 50,
    //     minWidth: 50,
    //     maxHeight: 100,
    //     maxWidth: 100,
    //   ),
    //   child: Container(
    //     width: 10,
    //     height: 500,
    //     color: Colors.black,
    //   ),
    // );
    // return SizedBox(
    //   width: 100,
    //   height: 100,
    //   child: Container(
    //     width: 200,
    //     height: 10,
    //     color: Colors.yellow,
    //   ),
    // );
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red,
              Colors.green,
            ],
          ),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(2.0, 2.0),
              blurRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 100,
            right: 100,
            top: 20,
            bottom: 20,
          ),
          child: Text(
            "注册",
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class ContainerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(100),
      width: 100,
      height: 100,
      child: Text("data"),
      decoration: BoxDecoration(
        color: Colors.red,
      ),
      // transform: Matrix4.rotationZ(.5),
    );
  }
}
