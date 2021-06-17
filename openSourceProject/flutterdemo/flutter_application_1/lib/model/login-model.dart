

import 'package:flutter_application_1/global/Global.dart';
import 'package:flutter_application_1/utils/rsa/rsa_utils.dart';


Future loginModel(String user,String pass) async{
       String pwd = await encodeString(pass);
       return await Global.getInstance()!.dio!.post("/zxw/user",queryParameters:  {
           "username":user,
           "password":pwd
       }
      );
}

Future tokenLoginModel() async {
    return await Global.getInstance()!.dio!.get("/zxw/user");
}