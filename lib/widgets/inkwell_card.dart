import 'package:flutter/material.dart';

/// 日期带波纹点击卡片
class InkwellCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Function() onTap;
  const InkwellCard({
    super.key,
    required this.onTap,
    required this.child,
    this.padding = const EdgeInsets.all(15),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .only(left: 12, top: 12, right: 12),
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        clipBehavior: .hardEdge,
        borderRadius: .circular(16),
        child: InkWell(
          onTap: onTap,
          child: Container(padding: padding, child: child),
        ),
      ),
    );
  }
}
