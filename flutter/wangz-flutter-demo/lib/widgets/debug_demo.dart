import 'package:flutter/material.dart';

class DebugDemo extends StatefulWidget {
  @override
  _DebugDemoState createState() => _DebugDemoState();
}

class _DebugDemoState extends State<DebugDemo> {
  int count = 10;
  String test;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("调试"),
      ),
      body: Text(
        count.toString(),
        style: Theme.of(context).textTheme.headline1,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            count++;
            if (count == 15) {
              test = "wang" * 80000;
              print(test);
            }
          });
        },
      ),
    );
  }
}
