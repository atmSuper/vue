import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioDemo extends StatefulWidget {
  @override
  _DioDemoState createState() => _DioDemoState();
}

class _DioDemoState extends State<DioDemo> {
  Dio _dio = Dio();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dio.options.baseUrl = "http://api.td0f7.cn:8083/";
    _dio.options.connectTimeout = 1000;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("网络请求Dio"),
      ),
      body: Column(
        children: [
          RaisedButton(
            onPressed: _get,
            child: Text("Get"),
          ),
          RaisedButton(
            onPressed: _post,
            child: Text("Post"),
          ),
          RaisedButton(
            onPressed: _try,
            child: Text("异常捕捉"),
          ),
        ],
      ),
    );
  }

  void _get() async {
    /**
     * get 查询
     * post 一般登陆 注册
     * put 修改资源
     * delete 删除资源
     */
    var result = await _dio.get(
      "dio/dio/test",
      queryParameters: {
        "id": "1",
      },
    );
    print(result);
    var result1 = await _dio.get(
      "dio/dio",
      queryParameters: {
        "id": "1",
      },
      options: Options(
        headers: {
          "token": "dsadasdas",
        },
      ),
    );
    print(result1);
  }

  void _post() async {
    var result1 = await _dio.post(
      "dio/dio",
      queryParameters: {
        "id": "1",
      },
      options: Options(
        headers: {
          "token": "dsadasdas",
        },
      ),
    );
    print(result1);
  }

  void _try() async {
    try {
      print("object");
      // dynamic result = await _dio.get("/dio/dio/time");
      // print(result);
      throw "测试异常";
    } on DioError {
      print("DioError");
    } on String {
      print("String");
    } catch (e) {
      print(e);
    }
  }
}
