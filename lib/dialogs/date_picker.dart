import 'package:flutter/material.dart';

/// 显示日期选择对话框，返回用户选择的日期
Future<void> showDatePickerDialog(
  BuildContext context, {
  String title = '选择日期',
  bool lunarOption = false,
  bool showYearOption = false,
  DateTime? endTimeLimit,
  DateTime? startTimeLimit,
}) {
  return showGeneralDialog(
    barrierLabel: 'Date Picker',
    barrierDismissible: true,
    context: context,
    transitionDuration: Duration(milliseconds: 300),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final translationY = Tween<Offset>(
        begin: Offset(0.0, 1.0),
        end: Offset(0.0, 0.0),
      ).animate(CurvedAnimation(parent: animation, curve: Curves.linear));
      // 透明度：0 → 1
      final opacity = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));
      return FadeTransition(
        opacity: opacity,
        child: SlideTransition(position: translationY, child: child),
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) {
      return Align(
        alignment: .bottomCenter,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: .circular(32),
            ),
            margin: .only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewPadding.bottom,
            ),
            padding: .all(22),
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .center,
              children: [
                Text(title, style: TextStyle(fontSize: 18, fontWeight: .bold)),
                lunarOption ? Container() : SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: .circular(12),
                          color: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                        ),
                        child: Center(child: Text('取消')),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: .circular(12),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Center(
                          child: Text(
                            '确定',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
