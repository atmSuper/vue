import 'package:zhaoxiaowu_app/global/global.dart';

Future registerModel(String json) async {
  return await Global.getInstance().dio.post(
    "/zxw/user/register",
    queryParameters: {
      "json": json,
    },
  );
}
