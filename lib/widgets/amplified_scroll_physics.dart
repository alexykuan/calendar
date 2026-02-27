import 'package:flutter/material.dart';

/// 放大滑动效果：相同手势产生更大滚动距离
class AmplifiedScrollPhysics extends ScrollPhysics {
  const AmplifiedScrollPhysics({
    this.speedFactor = 1.5,
    super.parent,
  });

  final double speedFactor;

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    return offset * speedFactor;
  }

  @override
  AmplifiedScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return AmplifiedScrollPhysics(
      speedFactor: speedFactor,
      parent: buildParent(ancestor),
    );
  }
}
