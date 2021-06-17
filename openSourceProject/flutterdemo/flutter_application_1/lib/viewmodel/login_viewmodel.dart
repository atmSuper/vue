
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/global/Global.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/model/login-model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewmodel extends ChangeNotifier{
    void login(String user,String pass) async{
       SharedPreferences sp = await SharedPreferences.getInstance();
       Response result = await loginModel(user, pass);
       print(result);
       if(result.data['success']) {
         Global.getInstance()!.token = result.data['data']['token'];
         Global.getInstance()!.user = result.data['data']['user'];
         sp.setString('token', result.data['data']['token']);
         Global.getInstance()!.dio!.options.headers['token'] = result.data['data']['token'];
         BuildContext context = navigatorKey.currentState!.overlay!.context;
         Navigator.of(context).popAndPushNamed('menu');
       } else {
         EasyLoading.showError(result.data['msg']);
       }
    }
    void tokenLogin(String token) async {
        SharedPreferences sp = await SharedPreferences.getInstance();
        Response result = await tokenLoginModel();
        if(result.data['success']) {
            Global.getInstance()!.user = result.data['data'];
            print('成功');
            BuildContext context = navigatorKey.currentState!.overlay!.context;
            Navigator.of(context).popAndPushNamed('menu');
        } else{
            sp.remove("token");
        }
    }
}