import 'package:zhaoxiaowu_app/global/global.dart';

Future getAccountingType(int action) async {
  return await Global.getInstance().dio.get(
    "/zxw/AccountingType",
    queryParameters: {
      "action": action,
    },
  );
}

Future insertAccouting(String json) async {
  return await Global.getInstance().dio.put(
    "/zxw/AccountingHistory",
    queryParameters: {
      "json": json,
    },
  );
}
