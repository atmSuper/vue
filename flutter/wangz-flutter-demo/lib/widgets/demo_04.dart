import 'package:flutter/material.dart';

class PageDemo extends StatefulWidget {
  List<Widget> widgets = [
    FlutterView(),
    AndroidView(),
    IosView(),
  ];
  @override
  _PageDemoState createState() => _PageDemoState();
}

class _PageDemoState extends State<PageDemo>
    with SingleTickerProviderStateMixin {
  List tabs = ["Flutter", "Android", "IOS"];
  TabController _controller;
  @override
  void initState() {
    // TODO: implement initState
    _controller = new TabController(
      length: tabs.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.home),
        //   onPressed: () {
        //     print("leading");
        //   },
        // ),
        centerTitle: true,
        title: Text("TabBar"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              print("add");
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              print("add");
            },
          ),
        ],
        elevation: 4,
        bottom: TabBar(
          controller: _controller,
          tabs: tabs
              .map((e) => Tab(
                    text: e,
                  ))
              .toList(),
        ),
      ),
      drawer: MyDrawer(),
      body: TabBarView(
        children: widget.widgets,
        controller: _controller,
      ),
    );
  }
}

class FlutterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Flutter"),
    );
  }
}

class AndroidView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Android"),
    );
  }
}

class IosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("IOS"),
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text("data"),
            ),
          ],
        ),
        removeTop: true,
      ),
    );
  }
}
