import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:zhaoxiaowu_app/base/view.dart';
import 'package:zhaoxiaowu_app/eventbus/event_bus.dart';
import 'package:zhaoxiaowu_app/global/global.dart';
import 'package:zhaoxiaowu_app/utils/date_utils.dart';
import 'package:zhaoxiaowu_app/viewmodel/register_viewmodel.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController _user;
  TextEditingController _pass;
  TextEditingController _phone;
  TextEditingController _code;
  TextEditingController _name;
  DateTime _dateTime;
  int _gender = 0; //0=男 1=女
  int _solar = 0; //0=阳历 1=阴历/农历
  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = TextEditingController();
    _pass = TextEditingController();
    _phone = TextEditingController();
    _code = TextEditingController();
    _name = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _user.dispose();
    _pass.dispose();
    _phone.dispose();
    _code.dispose();
    _name.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar("注册"),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: "登陆账号",
              hintText: "请输入登陆用户名",
            ),
            textInputAction: TextInputAction.next,
            controller: _user,
          ),
          Stack(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "手机号码",
                  hintText: "请输入手机号码",
                ),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.send,
                controller: _phone,
              ),
              Positioned(
                right: 10,
                child: RaisedButton(
                  child:
                      Text(count > 0 ? count.toString() + "秒后再次获取" : "获取验证码"),
                  onPressed: count > 0 ? null : _getCode,
                ),
              ),
            ],
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "验证码",
              hintText: "请输入获取到的验证码",
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            controller: _code,
          ),
          Container(
            child: TextField(
              decoration: InputDecoration(
                labelText: "登陆密码",
                hintText: "请输入登陆密码",
              ),
              textInputAction: TextInputAction.next,
              obscureText: true,
              controller: _pass,
            ),
          ),
          Stack(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "中文姓名",
                  hintText: "请输入中文姓名",
                ),
                textInputAction: TextInputAction.next,
                controller: _name,
              ),
              Positioned(
                right: 10,
                child: Row(
                  children: [
                    Switch(
                      value: _gender == 0 ? false : true,
                      onChanged: (v) {
                        setState(() {
                          _gender = v ? 1 : 0;
                        });
                      },
                    ),
                    SizedBox(width: 8),
                    Text(
                      _gender == 0 ? "男" : "女",
                    ),
                  ],
                ),
              ),
            ],
          ),
          Stack(
            children: [
              GestureDetector(
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Text(_dateTime != null ? getYMD(_dateTime) : "请选择日期"),
                    ],
                  ),
                ),
                onTap: _alertDateTime,
              ),
              Positioned(
                right: 10,
                child: Row(
                  children: [
                    Switch(
                      value: _solar == 0 ? false : true,
                      onChanged: (v) {
                        setState(() {
                          _solar = v ? 1 : 0;
                        });
                      },
                    ),
                    SizedBox(width: 8),
                    Text(
                      _solar == 0 ? "阳历" : "阴历",
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(10),
            child: RaisedButton(
              child: Text("注册"),
              onPressed: _register,
            ),
          ),
        ],
      ),
    );
  }

  void _alertDateTime() async {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2010),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        _dateTime = value;
      });
    }).catchError((e) {
      print(e);
    });
  }

  void _getCode() {
    setState(() {
      count = 60;
    });
    _task();
  }

  void _task() {
    Future.delayed(new Duration(seconds: 1), () {
      setState(() {
        count--;
        if (count > 0) {
          _task();
        }
      });
    });
  }

  void _register() {
    if (_user.text == null || _user.text.isEmpty) {
      EasyLoading.showError("账号不能为空！");
      return;
    } else if (_pass.text == null || _pass.text.isEmpty) {
      EasyLoading.showError("密码不能为空！");
      return;
    } else if (_name.text == null || _name.text.isEmpty) {
      EasyLoading.showError("姓名不能为空！");
      return;
    } else if (_phone.text == null || _phone.text.isEmpty) {
      EasyLoading.showError("手机号不能为空！");
      return;
    } else if (_code.text == null || _code.text.isEmpty) {
      EasyLoading.showError("验证码不能为空！");
      return;
    } else if (_dateTime == null) {
      EasyLoading.showError("生日不能为空！");
      return;
    }
    context.read<RegisterViewmodel>().login(
          _user.text,
          _pass.text,
          _name.text,
          _phone.text,
          _code.text,
          _gender,
          getYMD(_dateTime),
          _solar,
        );
  }
}
