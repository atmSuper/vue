import 'package:dio/dio.dart';

class MvvmDemoModel {
  /**
   * 登陆方法
   * id 参数
   */
  dynamic get(String id) async {
    return await Dio().get(
      "http://api.td0f7.cn:8083/dio/dio/test",
      queryParameters: {
        "id": id,
      },
    );
  }
}
