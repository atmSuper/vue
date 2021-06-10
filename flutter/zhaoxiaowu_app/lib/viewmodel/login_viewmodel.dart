import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zhaoxiaowu_app/global/global.dart';
import 'package:zhaoxiaowu_app/main.dart';
import 'package:zhaoxiaowu_app/model/login_model.dart';
import 'package:zhaoxiaowu_app/utils/event_utils.dart';

class LoginViewmodel extends ChangeNotifier {
  void login(String user, String pass) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    Response result = await loginModel(user, pass);
    print(result);
    if (result.data["success"]) {
      Global.getInstance().token = result.data["data"]["token"];
      Global.getInstance().user = result.data["data"]["user"];
      sp.setString("token", result.data["data"]["token"]);
      Global.getInstance().dio.options.headers["token"] =
          result.data["data"]["token"];
      Navigator.of(navigatorKey.currentContext).popAndPushNamed("menu");
    } else {
      EasyLoading.showError(result.data["msg"]);
    }
  }

  void tokenLogin(String token) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    Response result = await tokenLoginModel();
    if (result.data["success"]) {
      Global.getInstance().user = result.data["data"];
      Navigator.of(navigatorKey.currentContext).popAndPushNamed("menu");
    } else {
      sp.remove("token");
    }
  }
}
