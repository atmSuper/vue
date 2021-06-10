import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zhaoxiaowu_app/base/view.dart';
import 'package:zhaoxiaowu_app/global/global_theme.dart';
import 'package:zhaoxiaowu_app/viewmodel/theme_viewmodel.dart';

class SettingsTheme extends StatefulWidget {
  @override
  _SettingsThemeState createState() => _SettingsThemeState();
}

class _SettingsThemeState extends State<SettingsTheme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar("设置主题"),
      body: ListView.builder(
        itemBuilder: _itemBuilder,
        itemCount: themes.length,
        shrinkWrap: true,
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: themes[index],
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Provider.of<ThemeViewmodel>(context).getColor == index
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.apps,
                      color: Colors.white,
                    ),
                    SizedBox(width: 16),
                  ],
                )
              : Row(),
        ),
        onTap: () async {
          SharedPreferences sp = await SharedPreferences.getInstance();
          sp.setInt("color", index);
          context.read<ThemeViewmodel>().setColor(index);
        },
      ),
    );
  }
}
