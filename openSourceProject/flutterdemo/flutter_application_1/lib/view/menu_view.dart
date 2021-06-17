import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/base/view.dart';
import 'package:flutter_application_1/global/Global.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuView extends StatefulWidget {
  const MenuView({ Key? key }) : super(key: key);

  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: getAppbarAction("菜单", [IconButton(
          icon: Icon(Icons.settings),
          onPressed: (){
            //  Navigator.of(context).push
          },
       )]),
       drawer: Drawer(
         child: ListView(
           padding: EdgeInsets.zero,
           children: [
             UserAccountsDrawerHeader(
               accountName: Text("网站"), 
               accountEmail: Text('5966333333@qq.com')
              ),
              ListTile(
                title: Text('支出上线'),
                subtitle: Text("566666"),
                trailing: Icon(Icons.navigate_next),
                onTap: (){

                },
              ),
              Divider(height: 1),
              ListTile(
                title: Text("注册日期"),
                subtitle: Text("2021-5-16"),
                trailing: Icon(Icons.navigate_next),
                onTap: (){
                },
              ),
              Divider(height: 1),
              ListTile(
                title: Text('退出登录'),
                trailing: Icon(Icons.exit_to_app),
                onTap: () async{
                   SharedPreferences sp = await SharedPreferences.getInstance();
                   sp.remove("token");
                   Navigator.of(context).popAndPushNamed("/");
                },
              )
           ],
         ),
       ),
       body: SingleChildScrollView(
         child: Column(
          children: [
             Container(
               height: 300,
               child: new Swiper(
                  itemBuilder: (BuildContext context,int index){
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
             Container(
               margin: EdgeInsets.all(8),
               width: double.infinity,
               child: RaisedButton(
                 onPressed: (){
                    
                 },
                 child: Text('记账'),
               ),
             )
          ],
       ))
    );
  }
}