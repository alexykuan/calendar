import 'package:flutter/material.dart';

Future<void> showCalendarMoreActionsDialog(BuildContext context) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Calendar More Actions',
    transitionDuration: Duration(milliseconds: 300),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      // 缩放：0 → 1
      final scale = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutBack));

      // 透明度：0 → 1
      final opacity = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

      // 对齐方式：右上角 → 居中
      return FadeTransition(
        opacity: opacity,
        child: ScaleTransition(
          scale: scale,
          alignment: .topRight,
          child: child,
        ),
      );
    },
    pageBuilder:
        (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: .only(
                right: 16,
                top: kToolbarHeight + MediaQuery.of(context).padding.top,
              ),
              child: Material(
                color: Colors.transparent,
                elevation: 4,
                child: Container(
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: .circular(12),
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                  ),
                  child: Column(
                    mainAxisSize: .min,
                    children: [
                      ListTile(
                        dense: true,
                        title: Text(
                          '搜索日程',
                          style: TextStyle(fontWeight: .bold),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                          '日期跳转',
                          style: TextStyle(fontWeight: .bold),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                          '日期推算',
                          style: TextStyle(fontWeight: .bold),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        title: Text('设置', style: TextStyle(fontWeight: .bold)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
  );
}
