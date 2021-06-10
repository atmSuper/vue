import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zhaoxiaowu_app/base/view.dart';
import 'package:zhaoxiaowu_app/eventbus/event_bus.dart';
import 'package:zhaoxiaowu_app/global/global.dart';
import 'package:zhaoxiaowu_app/viewmodel/login_viewmodel.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _user;
  TextEditingController _pass;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = new TextEditingController();
    _pass = new TextEditingController();
    loadData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _user.dispose();
    _pass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar("登陆"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0.r),
          child: Column(
            children: [
              Image.asset(
                "images/main.jpg",
                width: double.infinity,
                height: 260.0.h,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 16.0.h),
              TextField(
                decoration: InputDecoration(
                  labelText: "账号",
                  hintText: "请输入账号",
                  prefixIcon: Icon(Icons.person),
                ),
                controller: _user,
                autofocus: true,
                textInputAction: TextInputAction.next,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "请输入密码",
                  prefixIcon: Icon(Icons.lock),
                ),
                controller: _pass,
                obscureText: true,
                textInputAction: TextInputAction.send,
                onSubmitted: (String) {
                  print("submit");
                },
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "找回密码",
                    style: TextStyle(color: Colors.blue),
                    textAlign: TextAlign.right,
                  ),
                ),
                onTap: () {
                  print("找回密码");
                },
              ),
              SizedBox(height: 16.h),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  child: Text("登陆"),
                  onPressed: _login,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  child: Text("注册"),
                  onPressed: _register,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loadData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = await sp.getString("token");
    print(token);
    if (token != null) {
      Global.getInstance().dio.options.headers["token"] = token;
      context.read<LoginViewmodel>().tokenLogin(token);
    }
  }

  void _login() async {
    if (_user == null || _user.text.isEmpty) {
      EasyLoading.showError('账号不能为空！');
      return;
    } else if (_pass == null || _pass.text.isEmpty) {
      EasyLoading.showError('密码不能为空！');
      return;
    }
    context.read<LoginViewmodel>().login(_user.text, _pass.text);
  }

  void _register() async {
    dynamic params = await Navigator.of(context).pushNamed("register");
    if (params != null) {
      setState(() {
        _user.text = params["user"];
        _pass.text = params["pass"];
      });
    }
  }
}
