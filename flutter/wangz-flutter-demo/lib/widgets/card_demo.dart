import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/listview_demo.dart';

class CardDemo extends StatefulWidget {
  @override
  _CardDemoState createState() => _CardDemoState();
}

class _CardDemoState extends State<CardDemo> {
  List<Map> list = new List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var i = 0; i < 10; i++) {
      list.add({"age": 10 + i, "name": "wang" + i.toString()});
    }
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Card(
      shadowColor: Colors.red,
      elevation: 1,
      child: Column(
        children: [
          SizedBox(height: 8),
          Text(
            list[index]["name"],
          ),
          SizedBox(height: 8),
          Text(
            list[index]["age"].toString(),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("卡片视图"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        // child: ListView.builder(
        //   itemBuilder: _itemBuilder,
        //   itemCount: list.length,
        // ),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.add),
              title: Text("title"),
              tileColor: Colors.grey,
              subtitle: Text("subtitle"),
              trailing: Icon(Icons.home),
            ),
          ],
        ),
      ),
    );
  }
}
