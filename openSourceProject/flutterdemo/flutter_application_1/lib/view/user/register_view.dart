import 'package:flutter/material.dart';
import 'package:flutter_application_1/base/view.dart';

class RegisterView extends StatefulWidget {

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController? _user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppbar("注册"),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(children: [
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
                  ),
                  Positioned(
                    right: 10,
                    top: 8,
                    child: RaisedButton(
                       child: 
                       Text("获取验证码"),
                       onPressed:() {
                       },
                    ),
                  )
                ],
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "验证码",
                  hintText: "请输入获取到的验证码"
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
              ),
              Container(
                child: TextField(
                  decoration: InputDecoration(
                     labelText: "登录密码",
                     hintText: "请输入登录密码",
                  ),
                  textInputAction: TextInputAction.next,
                  obscureText: true,
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
                  ),
                  Positioned(
                    right: 10,
                    top: 8,
                    child: Row(
                      children: [
                          Transform.scale(
                            scale: 2.0,
                            child: Switch(value: true, onChanged: (v){
                               print(v);
                            })
                          ),
                          SizedBox(width: 10),
                          Text("男")
                      ],
                    ),
                  )
                ],
              ),
              Stack(
                children: [
                  GestureDetector(
                    child: Container(
                       height: 60,
                       width: double.infinity,
                       child: Row(
                         children: [
                            Text("请选择日期",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                         ],
                       ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 8,
                    child: Row(
                      children: [
                        Transform.scale(
                            scale: 2.0,
                            child: Switch(value: true, onChanged: (v){
                               print(v);
                            })
                        ),
                        SizedBox(width: 5),
                        Text("阳历"),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                child: RaisedButton(
                  child: Text("注册"),
                  onPressed:_register,
                ),
              ),
          ],),
        )
    );
  }
  void _register() {
     print('注册');
  }
}