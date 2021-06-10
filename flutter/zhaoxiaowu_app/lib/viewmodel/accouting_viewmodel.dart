import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zhaoxiaowu_app/global/global.dart';
import 'package:zhaoxiaowu_app/main.dart';
import 'package:zhaoxiaowu_app/model/accouting_model.dart';
import 'package:zhaoxiaowu_app/model/login_model.dart';
import 'package:zhaoxiaowu_app/utils/event_utils.dart';

class AccoutingViewmodel extends ChangeNotifier {
  List _list = [];
  int _month;
  double _expenditure = 0; //支出
  double _income = 0; //收入

  double get getExpenditure {
    return _expenditure;
  }

  void setExpenditure(double val) {
    _expenditure = val;
    notifyListeners();
  }

  double get getIncome {
    return _income;
  }

  void setIncome(double val) {
    _income = val;
    notifyListeners();
  }

  List get getList {
    return _list;
  }

  void setList(List list) {
    _list = list;
    notifyListeners();
  }

  int get getMonth {
    if (_month == null) {
      _month = DateTime.now().month;
    }
    return _month;
  }

  void setMonth(int month) {
    _month = month;
    notifyListeners();
  }

  void accountingHistory() async {
    Response result = await getAccountingHistory(
        DateTime.now().year.toString() +
            (getMonth < 10 ? "0" + getMonth.toString() : getMonth.toString()));
    print(result);
    if (result.data["success"]) {
      setList(result.data["data"]["data"]);
      setExpenditure(result.data["data"]["expenditure"]);
      setExpenditure(result.data["data"]["income"]);
    } else {
      postMessage("fail", result.data["msg"]);
    }
  }

  void delete(String id) async {
    Response result = await deleteAccoutingList(id);
    print(result);
    if (result.data["success"]) {
      accountingHistory();
    } else {
      postMessage("fail", result.data["msg"]);
    }
  }
}
