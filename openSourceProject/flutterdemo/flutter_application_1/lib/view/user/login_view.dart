import 'package:flutter/material.dart';
import 'package:flutter_application_1/base/view.dart';
import 'package:flutter_application_1/global/Global.dart';
import 'package:flutter_application_1/viewmodel/CounterModel.dart';
import 'package:flutter_application_1/viewmodel/login_viewmodel.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginView extends StatefulWidget {

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController? _user;
  TextEditingController? _pass; 
  
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
     print('结束了');
    _user?.dispose();
    _pass?.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: getAppbar("登录"),
       body: SingleChildScrollView(
         child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(children: [
              Image.asset(
                "images/main.jpg",
                width: double.infinity,
                height: 260.0,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                   labelText: "账号",
                   hintText: "请输入账号",
                   prefixIcon: Icon(Icons.person)
                ),
                controller: _user,
                autocorrect: true,
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
              SizedBox(height: 16.0,),
              GestureDetector(
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "找回密码",
                    style: TextStyle(color: Colors.blue),
                    textAlign: TextAlign.right,
                  ),
                ),
                onTap: (){
                  print("找回密码");
                },
              ),
              SizedBox(height: 5.0,),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  child: Text("登录222"),
                  onPressed: (){
                     _login();
                    // // login();
                  },
                ),
              ),
              SizedBox(height: 5.0,),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  child: Text('注册'),
                  onPressed: (){
                    print("注册");
                    Navigator.of(context).pushNamed("register");
                  },
                ),
              )
            ],),
         ),
         ),
    );
  }
  void loadData() async {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String? token = await sp.getString("token");
      if(token!=null) {
          Global.getInstance()!.dio!.options.headers["token"] = token;
          context.read<LoginViewmodel>().tokenLogin(token);
      }
  }
  void _login() async {
     if(_user!.text.isEmpty){
         EasyLoading.showError("账号不能为空！");
     }
     context.read<LoginViewmodel>().login(_user!.text,_pass!.text);
  }
}
