import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:zhaoxiaowu_app/main.dart';
import 'package:zhaoxiaowu_app/model/register_model.dart';
import 'package:zhaoxiaowu_app/utils/event_utils.dart';
import 'package:zhaoxiaowu_app/utils/rsa/rsa_utils.dart';

class RegisterViewmodel extends ChangeNotifier {
  void login(String user, String pass, String name, String phone, String code,
      int gender, String dateTime, int solar) async {
    String pwd = await encodeString(pass);
    Response result = await registerModel(json.encode({
      "username": user,
      "password": pwd,
      "phone": phone,
      "name": name,
      "gender": gender,
      "birthday": dateTime,
      "solar": solar,
    }));
    print(result);
    if (result.data["success"]) {
      Navigator.pop(navigatorKey.currentContext, {
        "user": user,
        "pass": pass,
      });
    } else {
      EasyLoading.showError(result.data["msg"]);
    }
  }
}
