import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/model/register-model.dart';
import 'package:flutter_application_1/utils/rsa/rsa_utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisterViewmodel extends ChangeNotifier{
    void login(String user,String pass, String name, 
             String phone, String code,int gender,String dateTime,int solar) async{
                String pwd = await encodeString(pass);
                Response result = await registerModel(json.encode({
                     "username":user,
                     "password":pwd,
                     "phone":phone,
                     "name":name,
                     "gender":gender,
                     "birthday":dateTime,
                     "solar":solar,  
                }));
                print(result);
                if(result.data['success']){
                    
                }else{
                  EasyLoading.showError(result.data['msg']);
                }
            }
        
         
    
}