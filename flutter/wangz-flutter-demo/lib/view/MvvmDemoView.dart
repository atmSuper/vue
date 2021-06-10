import 'package:flutter/material.dart';
import 'package:flutter_demo/viewmodel/MvvmDemoViewmodel.dart';
import 'package:provider/provider.dart';

class MvvmDemoView extends StatefulWidget {
  @override
  _MvvmDemoViewState createState() => _MvvmDemoViewState();
}

class _MvvmDemoViewState extends State<MvvmDemoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mvvm设计模式"),
      ),
      body: Column(
        children: [
          RaisedButton(
            child: Text("调用viewmodel"),
            onPressed: () async {
              context.read<MvvmDemoViewmodel>().get("id");
            },
          ),
        ],
      ),
    );
  }
}
