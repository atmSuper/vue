import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.green,
      child: Text(
        "文本",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class ButtomDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RaisedButton(
          onPressed: () {},
          child: Text("漂浮按钮"),
        ),
        FlatButton(
          onPressed: () {},
          child: Text("扁平按钮"),
        ),
        FlatButton.icon(
          onPressed: () {},
          icon: Icon(Icons.add),
          label: Text("data"),
          color: Colors.green,
          textColor: Colors.white,
        ),
        OutlineButton(
          onPressed: () {},
          child: Text("OutlineButton"),
        ),
        IconButton(icon: Icon(Icons.home), onPressed: () {}),
      ],
    );
  }
}

class ImageIconDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.add),
        IconButton(icon: Icon(Icons.home), onPressed: () {}),
        Container(
          width: double.infinity,
          child: Image.network(
            "https://bkimg.cdn.bcebos.com/pic/0df3d7ca7bcb0a46c467b8316c63f6246b60af74?x-bce-process=image/resize,m_lfit,w_268,limit_1/format,f_jpg",
            fit: BoxFit.fitWidth,
          ),
        ),
        Image.asset("images/image.jpeg"),
      ],
    );
  }
}

class CheckDemo extends StatefulWidget {
  @override
  _CheckDemoState createState() => _CheckDemoState();
}

class _CheckDemoState extends State<CheckDemo> {
  bool _check = false;
  bool _switch = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Checkbox(
          value: _check,
          onChanged: (v) {
            setState(() {
              _check = v;
            });
          },
        ),
        Switch(
          value: _switch,
          onChanged: (v) {
            setState(() {
              _switch = v;
            });
          },
        )
      ],
    );
  }
}

class ProgressDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: .5,
            valueColor: AlwaysStoppedAnimation(Colors.yellow),
          ),
          SizedBox(height: 16),
          Container(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.red),
            ),
          ),
          SizedBox(height: 16),
          CupertinoActivityIndicator(),
        ],
      ),
    );
  }
}

class ClickDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("tag");
      },
      onDoubleTap: () {
        print("double tag");
      },
      child: Text("data"),
    );
  }
}

class InputDemo extends StatefulWidget {
  @override
  _InputDemoState createState() => _InputDemoState();
}

class _InputDemoState extends State<InputDemo> {
  GlobalKey _key = GlobalKey<FormState>();
  TextEditingController _user = TextEditingController();
  TextEditingController _pass = TextEditingController();
  FocusNode _u = FocusNode();
  FocusNode _p = FocusNode();
  FocusScopeNode _focusScopeNode;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _user.dispose();
    _pass.dispose();
    _u.dispose();
    _p.dispose();
    if (_focusScopeNode != null) _focusScopeNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          TextFormField(
            autofocus: true,
            focusNode: _u,
            controller: _user,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.add),
              labelText: "账号",
              hintText: "请输入账号",
            ),
            validator: (v) {
              if (v == null || v.isEmpty) {
                return "账号必须输入！";
              }
            },
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (v) {
              print("object");
            },
          ),
          SizedBox(height: 8),
          TextFormField(
            focusNode: _p,
            controller: _pass,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.add),
              labelText: "密码",
              hintText: "请输入密码",
            ),
            validator: (v) {
              if (v == null || v.length < 5) {
                return "密码必须输入且大于5";
              }
            },
            textInputAction: TextInputAction.send,
            obscureText: true,
          ),
          SizedBox(height: 16),
          RaisedButton(
            onPressed: () {
              if (_focusScopeNode == null) {
                _focusScopeNode = FocusScope.of(context);
              }
              _focusScopeNode.requestFocus(_u);
              _focusScopeNode.unfocus();
              print((_key.currentState as FormState).validate().toString());
            },
            child: Text("提交"),
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
