// 自定义无横向滚动的CupertinoPageRoute
import 'package:flutter/cupertino.dart';

class GesturePageRoute<T> extends CupertinoPageRoute<T> {
  GesturePageRoute({required super.builder});

  // 重写过渡动画构建逻辑
  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // 禁用跳转时的横向滚动动画（直接显示child）
    return child;

    // 若需侧滑返回时有动画，跳转时无动画，可加判断：
    // if (animation.status == AnimationStatus.reverse) {
    //   // 侧滑返回时保留默认动画
    //   return super.buildTransitions(context, animation, secondaryAnimation, child);
    // }
    // // 跳转时无动画
    // return child;
  }
}
