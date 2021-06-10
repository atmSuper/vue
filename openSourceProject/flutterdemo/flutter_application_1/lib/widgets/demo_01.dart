import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.green,
      child: Text(
        "文本",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class InputDemo extends StatefulWidget {
  @override
  _InputDemoState createState() => _InputDemoState();
}

class _InputDemoState extends State<InputDemo> {
  GlobalKey _key = GlobalKey<FormState>();
  // TextEditingController _user = TextEditingController();
  // TextEditingController _pass = TextEditingController();
  // FocusNode _u = FocusNode();
  // FocusNode _p = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Form(
       key: _key,
       child: Column(
         children: [
            Text("data",
               style: TextStyle(color: Colors.white),
            ),
            Text("data2"),
            Text("data3"),
         ],
       ),
    );
  }
}

class CheckDemo extends StatefulWidget {
  @override
  _CheckDemoState createState() => _CheckDemoState();
}

class _CheckDemoState extends State<CheckDemo> {
  // bool _check = false;
  bool _switch = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("data2"),
        // Switch(
        //   value: _switch,
        //   onChanged: (v) {
        //     setState(() {
        //       _switch = v;
        //     });
        //   },
        // )
      ],
    );
  }
}