import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/main.dart';
import 'package:flutter_demo/model/MvvmDemoModel.dart';

class MvvmDemoViewmodel extends ChangeNotifier {
  MvvmDemoModel _model = MvvmDemoModel();

  void get(String id) async {
    var result = await _model.get(id);
    print(result.statusMessage.toString());
    // Navigator.of(navigatorKey.currentContext).pushNamed("dio");
  }
}
