// 自定义无横向滚动的CupertinoPageRoute
import 'package:flutter/cupertino.dart';

class GesturePageRoute<T> extends CupertinoPageRoute<T> {
  GesturePageRoute({required super.builder});

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // 返回：正常iOS动画 + 手势
    if (animation.status == AnimationStatus.reverse) {
      return super.buildTransitions(
        context,
        animation,
        secondaryAnimation,
        child,
      );
    }

    // 进入：保留动画给Hero，但页面完全不移动
    return SlideTransition(
      position: AlwaysStoppedAnimation(Offset.zero),
      child: FadeTransition(opacity: AlwaysStoppedAnimation(1.0), child: child),
    );
  }
}
