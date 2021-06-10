import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogDemo extends StatefulWidget {
  @override
  _AlertDialogDemoState createState() => _AlertDialogDemoState();
}

class _AlertDialogDemoState extends State<AlertDialogDemo> {
  List<int> list = new List();
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
    return Scaffold(
      appBar: AppBar(
        title: Text("弹框演示"),
      ),
      body: Column(
        children: [
          RaisedButton(
            onPressed: _showAlert,
            child: Text("对话框"),
          ),
          RaisedButton(
            onPressed: _showListDialog,
            child: Text("列表对话框"),
          ),
        ],
      ),
    );
  }

  void _showListDialog() async {
    var result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text("标题"),
          children: list
              .map(
                (e) => GestureDetector(
                  child: Text(e.toString()),
                  onTap: () {
                    Navigator.pop(context, e);
                  },
                ),
              )
              .toList(),
        );
      },
    );
    print(result);
  }

  void _showAlert() async {
    var result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("标题"),
          content: Text("确认删除吗？"),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("取消"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text("确认"),
            ),
          ],
        );
      },
    );
    print(result);
  }
}
