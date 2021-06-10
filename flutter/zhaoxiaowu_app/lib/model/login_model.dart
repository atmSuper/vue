import 'package:zhaoxiaowu_app/global/global.dart';
import 'package:zhaoxiaowu_app/utils/rsa/rsa_utils.dart';

Future loginModel(String user, String pass) async {
  String pwd = await encodeString(pass);
  return await Global.getInstance().dio.post(
    "/zxw/user",
    queryParameters: {
      "username": user,
      "password": pwd,
    },
  );
}

Future tokenLoginModel() async {
  return await Global.getInstance().dio.get("/zxw/user");
}
