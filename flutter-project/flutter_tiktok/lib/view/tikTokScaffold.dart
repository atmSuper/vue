import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tiktok/style/style.dart';
enum TikTokPagePositon {
  left,
  right,
  middle,
}
class TikTokScaffoldController extends ValueNotifier<TikTokPagePositon> {
  TikTokScaffoldController([
    TikTokPagePositon value = TikTokPagePositon.middle,
  ]) : super(value);

  Future? animateToPage(TikTokPagePositon pagePositon) {
    return _onAnimateToPage?.call(pagePositon);
  }

  Future? animateToLeft() {
    return _onAnimateToPage?.call(TikTokPagePositon.left);
  }

  Future? animateToRight() {
    return _onAnimateToPage?.call(TikTokPagePositon.right);
  }

  Future? animateToMiddle() {
    return _onAnimateToPage?.call(TikTokPagePositon.middle);
  }

  Future Function(TikTokPagePositon pagePositon)? _onAnimateToPage;
}

class TikTokScaffold extends StatefulWidget {

   /// 首页的顶部
  final Widget? header;
  
  const TikTokScaffold({ 
    Key? key, 
    this.header
    }) : super(key: key);
  
  @override
  _TikTokScaffoldState createState() => _TikTokScaffoldState();
}

class _TikTokScaffoldState extends State<TikTokScaffold> 
   with TickerProviderStateMixin {
  AnimationController? animationControllerX;
  AnimationController? animationControllerY;
  Animation<double>? animationX;
  Animation<double>? animationY;
  double offsetX = 0.0;
  double offsetY = 0.0;
  // int currentIndex = 0;
  double inMiddle = 0;
  
  double? screenWidth;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    // 先定义正常的结构
    Widget body = Stack(
        children: <Widget>[
         _MiddlePage(
            header: widget.header, 
         ),
        ],  
    );
    return body;
  }
}

// ignore: unused_element
class _MiddlePage extends StatelessWidget {
  
  final bool? absorbing;
  final bool? isStack;
  final Widget? page;

  final double? offsetX;
  final double? offsetY;
  final Function? onTopDrag;

  final Widget? header;
  final Widget? tabBar;

  const _MiddlePage({
    Key? key, 
    this.absorbing,
    this.isStack, 
    this.page, 
    this.offsetX, 
    this.offsetY, 
    this.onTopDrag, 
    @required this.header, 
    this.tabBar,
     }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget tabBarContainer = tabBar ??
        Container(
          height: 44,
          child: Placeholder(
            color: Colors.red,
          ),
        );
     Widget mainVideoList = Container(
      color: ColorPlate.back1,
      padding: EdgeInsets.only(
        bottom: isStack! ? 0 : 44 + MediaQuery.of(context).padding.bottom,
      ),
      child: page,
    ); 
     // 刷新标志
    Widget _headerContain;
     if (offsetY! >= 20) {
      _headerContain = Opacity(
        opacity: (offsetY! - 20) / 20,
        child: Transform.translate(
          offset: Offset(0, offsetY!),
          child: Container(
            height: 44,
            child: Center(
              child: const Text(
                "下拉刷新内容",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SysSize.normal,
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      _headerContain = Opacity(
        opacity: max(0, 1 - offsetY! / 20),
        child: Transform.translate(
          offset: Offset(0, offsetY!),
          child: SafeArea(
            child: Container(
              height: 44,
              child: header ?? Placeholder(color: Colors.green),
            ),
          ),
        ),
      );
    }
     Widget middle = Transform.translate(
      offset: Offset(offsetX! > 0 ? offsetX! : offsetX! / 5, 0),
      child: Stack(
        children: <Widget>[
          Container(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                mainVideoList,
                tabBarContainer,
              ],
            ),
          ),
          _headerContain,
        ],
      ),
    );
    if (page is! PageView) {
      return middle;
    }
    return AbsorbPointer(
      absorbing: absorbing!,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowGlow();
          return false;
        },
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            // 当手指离开时，并且处于顶部则拦截PageView的滑动事件 TODO: 没有触发下拉刷新
            if (notification.direction == ScrollDirection.idle &&
                notification.metrics.pixels == 0.0) {
              onTopDrag?.call();
              return false;
            }
            return false;
          },
          child: middle,
        ),
      ),
    );
  }
}