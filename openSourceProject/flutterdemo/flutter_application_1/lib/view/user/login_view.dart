import 'package:flutter/material.dart';
import 'package:flutter_application_1/base/view.dart';



class LoginView extends StatefulWidget {

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                autocorrect: true,
                textInputAction: TextInputAction.next,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "请输入密码",
                  prefixIcon: Icon(Icons.lock),
                ),
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
              ),
              SizedBox(height: 16.0,),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  child: Text("登录"),
                  onPressed:(){
                    print('5555');
                  }
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
}