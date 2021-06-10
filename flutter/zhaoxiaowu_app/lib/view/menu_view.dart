import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zhaoxiaowu_app/base/view.dart';
import 'package:zhaoxiaowu_app/global/global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuView extends StatefulWidget {
  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbarActions(
        "菜单",
        [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed("theme");
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("王众"),
              accountEmail: Text(
                "81024198@qq.com",
              ),
            ),
            ListTile(
              title: Text("支出上限"),
              subtitle: Text(Global.getInstance().user["money"].toString()),
              trailing: Icon(Icons.navigate_next),
              onTap: () {},
            ),
            Divider(height: 1),
            ListTile(
              title: Text("注册日期"),
              subtitle: Text(Global.getInstance().user["date"]),
              trailing: Icon(Icons.navigate_next),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(height: 1),
            ListTile(
              title: Text("退出登陆"),
              trailing: Icon(Icons.exit_to_app),
              onTap: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.remove("token");
                Navigator.of(context).popAndPushNamed("/");
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            child: new Swiper(
              itemBuilder: (BuildContext context, int index) {
                return new Image.network(
                  "http://via.placeholder.com/350x150",
                  fit: BoxFit.fill,
                );
              },
              itemCount: 3,
              pagination: new SwiperPagination(),
              control: new SwiperControl(),
            ),
          ),
          SizedBox(
            height: 16.0.h,
          ),
          Container(
            margin: EdgeInsets.all(8),
            width: double.infinity,
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("accouting");
              },
              child: Text("记账"),
            ),
          ),
        ],
      ),
    );
  }
}
