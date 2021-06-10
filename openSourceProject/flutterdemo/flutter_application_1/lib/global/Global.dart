import 'package:dio/dio.dart';

class Global {
  static Global? _instance;
  Dio? dio;
  
  static Global? getInstance() {
    if(_instance == null) _instance = new Global();
    return _instance;
  }

  Global() {
     dio = new Dio();
     dio!.options = BaseOptions(
      baseUrl: "https://zxw.td0f7.cn",
      connectTimeout: 5000,
      sendTimeout: 5000,
      receiveTimeout: 5000,
      contentType: Headers.formUrlEncodedContentType,
      responseType: ResponseType.json,
    );
     dio!.interceptors.add(InterceptorsWrapper(
        onRequest: (options,handler) {
           print('5555');
          return handler.next(options);
        },
        onResponse: (response,handler) {
          print('2222');
           return handler.next(response);
        },
        onError: (DioError e,handler) {
          print(e.toString());
          String msg = "";
          if (e.type == DioErrorType.connectTimeout) {
             msg = "连接超时错误";
          } else {
             msg = "接口错误！";
          }
        }
     ));
  }
}