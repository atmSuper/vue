import 'package:flutter/material.dart';
import 'package:left_scroll_actions/cupertinoLeftScroll.dart';
import 'package:left_scroll_actions/global/actionListener.dart';
import 'package:left_scroll_actions/leftScroll.dart';
import 'package:provider/provider.dart';
import 'package:zhaoxiaowu_app/global/global.dart';
import 'package:zhaoxiaowu_app/utils/alert_utils.dart';
import 'package:zhaoxiaowu_app/utils/event_utils.dart';
import 'package:zhaoxiaowu_app/viewmodel/accouting_viewmodel.dart';

class AccoutingView extends StatefulWidget {
  @override
  _AccoutingViewState createState() => _AccoutingViewState();
}

class _AccoutingViewState extends State<AccoutingView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (context.read<AccoutingViewmodel>().getList.length == 0) loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("记账"),
        centerTitle: true,
        elevation: 10,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        DateTime.now().year.toString() + "年",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "本月预算",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "收入",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "支出",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Text(
                          Provider.of<AccoutingViewmodel>(context)
                                  .getMonth
                                  .toString() +
                              "月",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        onTap: _getMonth,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        Global.getInstance().user["money"].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        Provider.of<AccoutingViewmodel>(context)
                            .getIncome
                            .toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        Provider.of<AccoutingViewmodel>(context)
                            .getExpenditure
                            .toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: _itemBuilder,
        itemCount: Provider.of<AccoutingViewmodel>(context).getList == null
            ? 0
            : Provider.of<AccoutingViewmodel>(context).getList.length,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: _add,
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  Provider.of<AccoutingViewmodel>(context).getList[index]
                      ["date"],
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              Text(
                "收入:" +
                    Provider.of<AccoutingViewmodel>(context)
                        .getList[index]["income"]
                        .toString(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(width: 8),
              Text(
                "支出:" +
                    Provider.of<AccoutingViewmodel>(context)
                        .getList[index]["expenditure"]
                        .toString(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
        Divider(height: 1),
        Column(
          children: _childrens(
              Provider.of<AccoutingViewmodel>(context).getList[index]["data"]),
        ),
      ],
    );
  }

  List<Widget> _childrens(var datas) {
    List<Widget> widgets = [];
    for (var i = 0; i < datas.length; i++) {
      widgets.add(Container(height: 8));
      widgets.add(
        CupertinoLeftScroll(
          key: Key(i.toString()),
          closeTag: LeftScrollCloseTag('TODO: your tag'),
          child: Row(
            children: [
              Icon(Icons.add),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(datas[i]["type"]["action"] == 0 ? "收入" : "支出"),
                    Text(
                      "描述：" + datas[i]["desc"],
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Text(datas[i]["money"].toString()),
            ],
          ),
          buttons: [
            LeftScrollItem(
              text: '删除',
              color: Colors.red,
              onTap: () {
                context
                    .read<AccoutingViewmodel>()
                    .delete(datas[i]["id"].toString());
              },
            ),
          ],
        ),
      );
      widgets.add(Container(height: 8));
    }
    return widgets;
  }

  void loadData() async {
    context.read<AccoutingViewmodel>().setList([]);
    context.read<AccoutingViewmodel>().accountingHistory();
  }

  void _getMonth() async {
    List list = [];
    for (var i = 1; i <= 12; i++) {
      if (i <= DateTime.now().month) list.add(i);
    }
    var result = await showMonthList(list);
    if (result != null) {
      context.read<AccoutingViewmodel>().setMonth(result);
      loadData();
    }
  }

  void _add() {
    Navigator.of(context).pushNamed("accouting/add");
  }
}
