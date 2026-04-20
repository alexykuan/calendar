import 'package:calendar/screens/event_schedual.dart';
import 'package:flutter/material.dart';

Future<void> showCalendarNoteActionsDialog(BuildContext context) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Calendar Note Actions',
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
                right: 48,
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
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EventSchedualScreen(),
                            ),
                          );
                        },
                        dense: true,
                        title: Text(
                          '创建日程',
                          style: TextStyle(fontWeight: .bold),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                          '日常打卡',
                          style: TextStyle(fontWeight: .bold),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                          '记录账单',
                          style: TextStyle(fontWeight: .bold),
                        ),
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
