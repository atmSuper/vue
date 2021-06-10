import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:zhaoxiaowu_app/eventbus/event_bus.dart';
import 'package:zhaoxiaowu_app/global/global.dart';
import 'package:zhaoxiaowu_app/model/accouting_add_model.dart';
import 'package:zhaoxiaowu_app/utils/alert_utils.dart';
import 'package:zhaoxiaowu_app/utils/date_utils.dart';

class AccoutingAddViewmodel extends ChangeNotifier {
  List<Map> _types = [
    {"name": "收入", "id": 0},
    {"name": "支出", "id": 1}
  ];
  int _type = 0; //类型选中下标
  List _modes = []; //方式集合
  var _mode; //选中的方式对象

  List<Map> get getTypes {
    return _types;
  }

  int get getType {
    return _type;
  }

  void setType(int val) {
    _type = val;
    notifyListeners();
  }

  List get getModes {
    return _modes;
  }

  void setModes(List list) {
    _modes = list;
    notifyListeners();
  }

  Map get getMode {
    return _mode;
  }

  void setMode(Map mode) {
    _mode = mode;
    notifyListeners();
  }

  void getModeAndAlert() async {
    if (getModes != null && getModes.length > 0) {
      //如果数据不等于空则直接选择
      var val = await showObjectAlertDialog(getModes, "选择方式", "name");
      if (val != null && getMode != getModes[val]) {
        setMode(getModes[val]);
      }
      return;
    }
    var result = await getAccountingType(_types[_type]["id"]);
    print(result.data);
    if (result.data["success"]) {
      _modes = result.data["data"];
      var val = await showObjectAlertDialog(getModes, "选择方式", "name");
      if (val != null && getMode != getModes[val]) {
        setMode(getModes[val]);
      }
    } else {
      EasyLoading.showError(result.data["msg"]);
    }
  }

  void insert(String money, String desc) async {
    Map map = {
      "t_id": _mode["id"],
      "u_id": Global.getInstance().user["id"],
      "action": _type,
      "money": money,
      "desc": desc,
      "date": getYMD(DateTime.now()),
    };
    var result = await insertAccouting(json.encode(map));
    if (result.data["success"]) {
      EasyLoading.showSuccess(result.data["msg"]);
      setMode(null);
      setType(0);
      bus.emit("accouting_add_result");
    } else {
      EasyLoading.showError(result.data["msg"]);
    }
  }
}
