import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登陆"),
      ),
      body: RaisedButton(
        onPressed: () {
          Navigator.of(context).pushNamed("menu", arguments: "菜单");
        },
        child: Text("登陆"),
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dynamic arguments = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(arguments.toString()),
      ),
      body: RaisedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("返回"),
      ),
    );
  }
}
