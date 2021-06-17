import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tiktok/pages/homePage.dart';
import 'package:flutter_tiktok/style/style.dart';

void main() {
  if(kReleaseMode){
     ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails){
         debugPrint(flutterErrorDetails.toString());
         return Material(
           child: Center(
             child: Text(
               "发生错误了....... ",
               textAlign: TextAlign.center,
             ),
           ),
         );  
     }; 
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tiktok',
      theme: ThemeData(
        brightness: Brightness.dark, // 应用整体主题的亮度。用于按钮之类的小部件，以确定在不使用主色或强调色时选择什么颜色
        hintColor: Colors.white,  // 用于提示文本或占位符文本的颜色，例如在TextField中。
        accentColor: Colors.white, //小部件的前景色（旋钮、文本、滚动边缘效果等）。
        primaryColor: ColorPlate.orange, // 用于主题交互元素的颜色。这种颜色通常用于按钮和可点击元素中的文本和图标 
        primaryColorBrightness: Brightness.dark, //用于确定放置在原色之上的文本和图标的颜色
        scaffoldBackgroundColor: ColorPlate.back1, //脚手架的背景颜色。
        dialogBackgroundColor: ColorPlate.back2, //Dialog元素的背景颜色。
        accentColorBrightness: Brightness.light,// 强调颜色的亮度。用于确定放置在强调色之上的文本和图标的颜色（例如浮动操作按钮上的图标）
        textTheme: TextTheme(
          bodyText1: StandardTextStyle.normal,
        ),
      ),
      home: HomePage(),
    );
  }
}


