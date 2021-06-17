
import 'package:flutter_application_1/global/Global.dart';

Future registerModel(String json) async {
    return await Global.getInstance()!.dio!.post(
      "/zxw/user/register",
      queryParameters: {
        "json":json,
      }
    );
}