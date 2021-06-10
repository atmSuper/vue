import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zhaoxiaowu_app/global/global_theme.dart';
import 'package:zhaoxiaowu_app/routes/routes.dart';
import 'package:zhaoxiaowu_app/viewmodel/accouting_add_viewmodel.dart';
import 'package:zhaoxiaowu_app/viewmodel/accouting_viewmodel.dart';
import 'package:zhaoxiaowu_app/viewmodel/login_viewmodel.dart';
import 'package:zhaoxiaowu_app/viewmodel/register_viewmodel.dart';
import 'package:zhaoxiaowu_app/viewmodel/theme_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  int color = await sp.getInt("color") ?? 0;
  ThemeViewmodel themeViewmodel = ThemeViewmodel();
  themeViewmodel.setColor(color);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LoginViewmodel()),
      ChangeNotifierProvider(create: (context) => RegisterViewmodel()),
      ChangeNotifierProvider(create: (context) => themeViewmodel),
      ChangeNotifierProvider(create: (context) => AccoutingViewmodel()),
      ChangeNotifierProvider(create: (context) => AccoutingAddViewmodel()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final JPush jpush = new JPush();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    const bool inProduction = const bool.fromEnvironment("dart.vm.product");
    try {
      jpush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {
        print("flutter onReceiveNotification: $message");
      }, onOpenNotification: (Map<String, dynamic> message) async {
        print("flutter onOpenNotification: $message");
      }, onReceiveMessage: (Map<String, dynamic> message) async {
        print("flutter onReceiveMessage: $message");
      }, onReceiveNotificationAuthorization:
              (Map<String, dynamic> message) async {
        print("flutter onReceiveNotificationAuthorization: $message");
      });
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    print("开发模式" + inProduction.toString());
    jpush.setup(
      appKey: "e700e2560560848cdeb0b283", //你自己应用的 AppKey
      channel: "developer-default",
      production: inProduction,
      debug: inProduction, //debug日志 true=打印
    );
    jpush.applyPushAuthority(
        new NotificationSettingsIOS(sound: true, alert: true, badge: true));

    // Platform messages may fail, so we use a try/catch PlatformException.
    jpush.getRegistrationID().then((rid) {
      print("flutter get registration id : $rid");
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: '赵小屋',
        theme: ThemeData.light().copyWith(
          primaryColor: themes[Provider.of<ThemeViewmodel>(context).getColor],
          buttonTheme: ButtonThemeData(
            buttonColor: themes[Provider.of<ThemeViewmodel>(context).getColor],
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        // builder: (context, widget) {
        //   EasyLoading.init();
        //   return MediaQuery(
        //     //Setting font does not change with system font size
        //     data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        //     child: widget,
        //   );
        // },
        builder: EasyLoading.init(),
        routes: routes,
      ),
    );
  }
}
