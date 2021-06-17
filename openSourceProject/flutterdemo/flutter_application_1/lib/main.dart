import 'package:flutter/material.dart';
import 'package:flutter_application_1/global/Global.dart';
import 'package:flutter_application_1/routes/routes.dart';
import 'package:flutter_application_1/viewmodel/CounterModel.dart';
import 'package:flutter_application_1/viewmodel/login_viewmodel.dart';
import 'package:flutter_application_1/viewmodel/register_viewmodel.dart';
import 'package:flutter_application_1/widgets/demo_01.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
void main() {
  runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=>LoginViewmodel()),
      ChangeNotifierProvider(create: (context)=>RegisterViewmodel()),
      ChangeNotifierProvider(create: (context) => CounterModel())
  ],
   child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('StatelessWidget build');
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo 666',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: EasyLoading.init(),
      routes: routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      loadData();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('2222');
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:999999999999999999999999999999999999999',
              textAlign: TextAlign.left,
              maxLines: 2,
              style: TextStyle(fontSize: 25.0),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
void loadData() async{
    await Global.getInstance()!.dio!.get("/dio/dio");
}

