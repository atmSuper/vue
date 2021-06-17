import 'package:flutter/material.dart';
import 'package:flutter_application_1/base/view.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/utils/date_utils.dart';
import 'package:flutter_application_1/viewmodel/CounterModel.dart';
import 'package:flutter_application_1/viewmodel/register_viewmodel.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
class RegisterView extends StatefulWidget {

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController? _user;
  TextEditingController? _pass;
  TextEditingController? _phone;
  TextEditingController? _code;
  TextEditingController? _name;  
  DateTime? _dateTime;
  int _gender = 0 ;
  int _solar = 0 ;
  int count =0;

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
    _user?.dispose();
    _pass?.dispose();
    _phone?.dispose();
    _name?.dispose();
  }
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
                    controller: _phone,
                  ),
                  Positioned(
                    right: 10,
                    top: 8,
                    child: RaisedButton(
                       child: 
                       Text(count > 0 ? count.toString()+"秒后再次获取":"获取验证码"),
                       onPressed: count > 0 ? null: _getCode, 
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
                controller: _code,
              ),
              Container(
                child: TextField(
                  decoration: InputDecoration(
                     labelText: "登录密码",
                     hintText: "请输入登录密码",
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
                    top: 8,
                    child: Row(
                      children: [
                          Transform.scale(
                            scale: 2.0,
                            child: Switch(value: _gender == 0 ? false : true,
                             onChanged: (v){
                                print(v);
                              _gender = v ? 1 : 0; 
                            })
                          ),
                          SizedBox(width: 10),
                          Text(_gender == 0 ? "男":"女")
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
                            Text(_dateTime != null ? getYMD(_dateTime) : "请选择日期",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                         ],
                       ),
                    ),
                    onTap: _alertDateTime,
                  ),
                  Positioned(
                    right: 10,
                    top: 8,
                    child: Row(
                      children: [
                        Transform.scale(
                            scale: 2.0,
                            child: Switch(value: _solar == 0 ? false:true , 
                            onChanged: (v){
                               setState(() {
                                  _solar = v ? 1 :0;
                               });   
                            })
                        ),
                        SizedBox(width: 5),
                        Text(_solar == 0 ? "阳历":"阴历")
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
                  onPressed:(){
                     _register(context);
                  },
                ),
              ),
          ],),
        )
    );
  }
  void _alertDateTime() async{
     BuildContext context = navigatorKey.currentState!.overlay!.context;
     showDatePicker(
        context: context, 
        initialDate: DateTime.now(), 
        firstDate: DateTime(2010), 
        lastDate: DateTime.now()).then((value) {
              setState(() {
                  _dateTime = value;
              });
            }
        ).catchError((e){
            print(e);
        });
  }
  void _getCode() {
    setState(() {
      count = 60;
      _task();
    });
  }
  void _task() {
      Future.delayed(new Duration(seconds: 1),(){
           setState(() {
             count--;
             if(count>0) {
               _task();
             }
           });
      });
  }
  void _register(BuildContext context) {
     if(_user!.text.isEmpty) {
        EasyLoading.showError("账号不能为空");
        return;
     } 
     context.read<RegisterViewmodel>().login(
       _user!.text,
       _pass!.text,
       _name!.text,
       _phone!.text,
       _code!.text,
       _gender,
       getYMD(_dateTime),
       _solar
     );
  }
}