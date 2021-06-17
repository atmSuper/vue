import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tiktok/view/TikTokHeader.dart';
import 'package:flutter_tiktok/view/tikTokScaffold.dart';
import 'package:flutter_tiktok/view/tiktokTabBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver{
  TikTokPageTag tabBarType = TikTokPageTag.home;

  PageController _pageController = PageController(); //pageController制作无限滚动栏

  @override
  Widget build(BuildContext context) {
    var header = TikTokHeader(
       onSearch: (){
           print('555');
       },
    );
    return TikTokScaffold(header: header);
  }
}