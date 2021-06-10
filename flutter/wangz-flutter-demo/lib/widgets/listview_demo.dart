import 'package:flutter/material.dart';

class ListviewDemo extends StatefulWidget {
  @override
  _ListviewDemoState createState() => _ListviewDemoState();
}

class _ListviewDemoState extends State<ListviewDemo> {
  List<int> list = List();
  ScrollController _controller;
  bool show = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.offset >= 100 && show == false) {
        setState(() {
          show = true;
        });
      } else if (_controller.offset < 100 && show == true) {
        setState(() {
          show = false;
        });
      }
    });
    for (var i = 0; i < 100; i++) {
      list.add(i);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("滚动列表"),
      ),
      floatingActionButton: show
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                _controller.animateTo(
                  0,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.linear,
                );
              },
            )
          : null,
      body: Scrollbar(
        // child: RefreshIndicator(
        //   child: ListView(
        //     children: list.map((e) => Text(e.toString())).toList(),
        //     // shrinkWrap: true,
        //     // reverse: true,
        //     // itemExtent: 50,
        //   ),
        //   onRefresh: _onRefresh,
        // ),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Text(list[index].toString());
          },
          itemCount: list.length,
          controller: _controller,
        ),
      ),
    );
  }

  Future _onRefresh() async {
    await Future.delayed(
      Duration(seconds: 3),
      () {
        print("object");
      },
    );
  }
}
