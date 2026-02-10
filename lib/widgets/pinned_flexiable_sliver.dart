import 'package:flutter/material.dart';

/// 类似 [SliverPersistentHeader] 的可伸缩固定 Sliver，支持：
/// - 固定在 CustomScrollView 顶部（pinned）
/// - 最大/最小高度，随滚动在两者之间变化
/// - 收起位置起点 [collapseAnchor]，决定收起后显示内容的那一段
///
/// [collapseAnchor] 范围 0 到 (maxHeight - minHeight)：
/// - 0：收起后显示区域为 0～minHeight（从底部开始收起）
/// - maxHeight - minHeight：收起后显示区域为 (maxHeight-minHeight)～maxHeight（从顶部开始收起）
/// - 中间值：从上下往中间收起，收起后显示中间一段
class PinnedFlexibleSliver extends StatelessWidget {
  const PinnedFlexibleSliver({
    super.key,
    required this.maxHeight,
    required this.minHeight,
    this.collapseAnchor = 0,
    required this.child,
  }) : assert(maxHeight >= minHeight && minHeight >= 0),
       assert(collapseAnchor >= 0 && collapseAnchor <= (maxHeight - minHeight));

  /// 展开时的最大高度
  final double maxHeight;

  /// 收起时的最小高度
  final double minHeight;

  /// 收起时的位置起点，范围 [0, maxHeight - minHeight]
  /// 收起后可见区域为 [collapseAnchor, collapseAnchor + minHeight]
  final double collapseAnchor;

  /// 子组件，按 [maxHeight] 高度布局，滚动时通过裁剪显示对应区段
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _PinnedFlexibleSliverDelegate(
        maxHeight: maxHeight,
        minHeight: minHeight,
        collapseAnchor: collapseAnchor,
        child: child,
      ),
    );
  }
}

class _PinnedFlexibleSliverDelegate extends SliverPersistentHeaderDelegate {
  _PinnedFlexibleSliverDelegate({
    required this.maxHeight,
    required this.minHeight,
    required this.collapseAnchor,
    required this.child,
  });

  final double maxHeight;
  final double minHeight;
  final double collapseAnchor;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final currentHeight = (maxExtent - shrinkOffset).clamp(minExtent, maxExtent);
    final maxScroll = maxExtent - minExtent;
    final t = maxScroll > 0 ? (shrinkOffset / maxScroll).clamp(0.0, 1.0) : 1.0;

    // 可见区域在「完整内容」坐标系中的上、下边界
    // t=0 展开: visibleTop=0, visibleBottom=maxExtent
    // t=1 收起: visibleTop=collapseAnchor, visibleBottom=collapseAnchor+minExtent
    final visibleTop = collapseAnchor * t;

    return SizedBox(
      height: currentHeight,
      child: ClipRect(
        child: OverflowBox(
          alignment: Alignment.topCenter,
          minHeight: 0,
          maxHeight: maxExtent,
          child: Transform.translate(
            offset: Offset(0, -visibleTop),
            child: SizedBox(
              height: maxExtent,
              width: double.infinity,
              child: RepaintBoundary(child: child),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _PinnedFlexibleSliverDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        collapseAnchor != oldDelegate.collapseAnchor ||
        child != oldDelegate.child;
  }
}
