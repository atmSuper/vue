import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/CountProvider.dart';
import 'package:flutter_demo/view/MvvmDemoView.dart';
import 'package:flutter_demo/viewmodel/MvvmDemoViewmodel.dart';
import 'package:flutter_demo/widgets/alert_dialog_demo.dart';
import 'package:flutter_demo/widgets/bottom_navigator.dart';
import 'package:flutter_demo/widgets/card_demo.dart';
import 'package:flutter_demo/widgets/debug_demo.dart';
import 'package:flutter_demo/widgets/demo_01.dart';
import 'package:flutter_demo/widgets/demo_04.dart';
import 'package:flutter_demo/widgets/demo_05.dart';
import 'package:flutter_demo/widgets/dio_demo.dart';
import 'package:flutter_demo/widgets/grid_view_demo.dart';
import 'package:flutter_demo/widgets/layout_demo.dart';
import 'package:flutter_demo/widgets/listview_demo.dart';
import 'package:flutter_demo/widgets/navigator_demo.dart';
import 'package:flutter_demo/widgets/provider_demo.dart';
import 'package:flutter_demo/widgets/table_demo.dart';
import 'package:provider/provider.dart';

//view层调用viewmodel，viewmodel通知model层，model再发送请求返回给viewmodel，viewmodel处理返回结果并刷新view

main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CountProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MvvmDemoViewmodel(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => LoginPage(),
        "layout": (context) => LayoutDemo(),
        "page": (content) => PageDemo(),
        "navigator": (context) => BottomNavigatorBarDemo(),
        "lv": (context) => ListviewDemo(),
        "grid": (context) => GridViewDemo(),
        "alert": (context) => AlertDialogDemo(),
        "table": (context) => TableDemo(),
        "card": (context) => CardDemo(),
        "demo05": (context) => Demo05(),
        "debug": (context) => DebugDemo(),
        "provider": (context) => ProviderDemo(),
        "provider2": (context) => ProviderDemoTwo(),
        "dio": (context) => DioDemo(),
        "mvvmdemo": (context) => MvvmDemoView(),
      },
      initialRoute: "/",
      onGenerateRoute: (RouteSettings s) {
        print(s.name);
        switch (s.name) {
          case "menu":
            return MaterialPageRoute(
              builder: (context) {
                return MenuPage();
              },
              settings: s,
            );
            break;
          default:
        }
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WangZhong"),
        elevation: 10.0,
        centerTitle: true,
      ),
      body: InputDemo(),
    );
  }
}

class CountPage extends StatefulWidget {
  @override
  _CountPageState createState() => _CountPageState();
}

class _CountPageState extends State<CountPage> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("$count"),
        RaisedButton(
          onPressed: () {
            setState(() {
              count++;
            });
          },
          child: Text("点击"),
        ),
      ],
    );
  }
}
