import 'package:flutter/material.dart';
import 'package:zhaoxiaowu_app/main.dart';

Future showMonthList(List list) async {
  return await showDialog(
    context: navigatorKey.currentContext,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text("选择统计月份"),
        children: list.map((e) {
          return SimpleDialogOption(
            child: Text(e.toString() + "月"),
            onPressed: () {
              Navigator.pop(context, e);
            },
          );
        }).toList(),
      );
    },
    barrierDismissible: false,
  );
}

Future showObjectAlertDialog(List list, String title, String content) async {
  return await showDialog(
    context: navigatorKey.currentContext,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text(title),
        children: list.asMap().keys.map((e) {
          return SimpleDialogOption(
            child: Text(list[e][content]),
            onPressed: () {
              Navigator.pop(context, e);
            },
          );
        }).toList(),
      );
    },
    barrierDismissible: false,
  );
}
