import 'package:flutter/material.dart';
import 'package:zhaoxiaowu_app/global/global_theme.dart';

class ThemeViewmodel extends ChangeNotifier {
  int _color = 0;

  int get getColor {
    return _color;
  }

  void setColor(int color) {
    print("color:" + color.toString());
    print(themes);
    if (color > themes.length - 1) return;
    _color = color;
    notifyListeners();
  }
}
