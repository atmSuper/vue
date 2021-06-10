import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:zhaoxiaowu_app/base/view.dart';
import 'package:zhaoxiaowu_app/eventbus/event_bus.dart';
import 'package:zhaoxiaowu_app/global/global.dart';
import 'package:zhaoxiaowu_app/utils/alert_utils.dart';
import 'package:zhaoxiaowu_app/utils/date_utils.dart';
import 'package:zhaoxiaowu_app/viewmodel/accouting_add_viewmodel.dart';
import 'package:zhaoxiaowu_app/viewmodel/accouting_viewmodel.dart';

class AccoutingAddView extends StatefulWidget {
  @override
  _AccoutingAddViewState createState() => _AccoutingAddViewState();
}

class _AccoutingAddViewState extends State<AccoutingAddView> {
  TextEditingController _money;
  TextEditingController _desc;

  @override
  void initState() {
    _money = TextEditingController();
    _desc = TextEditingController();
    bus.on("accouting_add_result", (arg) {
      context.read<AccoutingViewmodel>().accountingHistory();
      setState(() {
        _money.text = "";
        _desc.text = "";
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _money.dispose();
    _desc.dispose();
    bus.off("accouting_add_result");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar("新增记账"),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text("类型"),
              trailing: Text(Provider.of<AccoutingAddViewmodel>(context)
                      .getTypes[
                  Provider.of<AccoutingAddViewmodel>(context).getType]["name"]),
              onTap: _showTypesAlert,
            ),
            Divider(height: 1),
            ListTile(
              title: Text("方式"),
              trailing: Text(
                  Provider.of<AccoutingAddViewmodel>(context).getMode == null
                      ? ""
                      : Provider.of<AccoutingAddViewmodel>(context)
                          .getMode["name"]),
              onTap: _accountingType,
            ),
            Divider(height: 1),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "请输入金额",
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                autofocus: true,
                controller: _money,
              ),
            ),
            Divider(height: 1),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "请输入备注",
                ),
                textInputAction: TextInputAction.send,
                controller: _desc,
              ),
            ),
            Divider(height: 1),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 10, right: 10),
              child: RaisedButton(
                onPressed: _submit,
                child: Text("新增"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTypesAlert() async {
    var result = await showObjectAlertDialog(
        context.read<AccoutingAddViewmodel>().getTypes, "选择类型", "name");
    print(result);
    if (result != null &&
        result != context.read<AccoutingAddViewmodel>().getType) {
      context.read<AccoutingAddViewmodel>().setMode(null);
      context.read<AccoutingAddViewmodel>().setType(result);
    }
  }

  void _accountingType() async {
    context.read<AccoutingAddViewmodel>().getModeAndAlert();
  }

  void _submit() async {
    context.read<AccoutingAddViewmodel>().insert(_money.text, _desc.text);
  }
}
