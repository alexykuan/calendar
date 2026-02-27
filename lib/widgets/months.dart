import 'dart:math';

import 'package:calendar/widgets/calendar_days.dart';
import 'package:flutter/material.dart';
import 'package:lunar/lunar.dart';

class MonthsPager extends StatefulWidget {
  final MonthPagerController? controller;
  const MonthsPager({super.key, this.controller});

  @override
  State<MonthsPager> createState() => _MonthsPagerState();
}

class _MonthsPagerState extends State<MonthsPager> {
  /// current date
  final DateTime now = DateTime.now();

  /// the last displayed month
  late DateTime lastDisplayedYear = DateTime(now.year + 100, 1, 1);

  late int totalMonths = (lastDisplayedYear.year - 1900) * 12;

  /// months since 1900.01 to 100 years in future
  late final PageController _pageController = PageController(
    initialPage: now.year * 12 + now.month - 1 - 1900 * 12,
  );

  /// the currently selected date
  DateTime currentSelected = DateTime.now();

  /// 当前展示的月份对应的 page 下标，用于选择非当月日期时跳转
  late int _currentPageIndex = now.year * 12 + now.month - 1 - 1900 * 12;

  int _pageIndexFor(DateTime date) => (date.year - 1900) * 12 + date.month - 1;

  void _syncFromController() {
    final controller = widget.controller;
    if (controller == null) return;
    final target = controller.currentTime;
    if (target == currentSelected) return;
    setState(() {
      currentSelected = target;
    });
    final targetPage = _pageIndexFor(target);
    if (targetPage != _currentPageIndex) {
      _currentPageIndex = targetPage;
      _pageController.jumpToPage(targetPage);
    }
  }

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_syncFromController);
  }

  @override
  void didUpdateWidget(MonthsPager oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_syncFromController);
      widget.controller?.addListener(_syncFromController);
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_syncFromController);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (value) {
        _currentPageIndex = value;
        final year = 1900 + value ~/ 12;
        final month = value % 12 + 1;
        final days = SolarUtil.getDaysOfMonth(year, month);
        widget.controller?.onMonthChanged(
          DateTime(year, month, min(currentSelected.day, days)),
        );
        setState(() {
          currentSelected = DateTime(
            year,
            month,
            min(currentSelected.day, days),
          );
        });
      },
      itemBuilder: (context, index) {
        int year = 1900 + index ~/ 12;
        int month = index % 12 + 1;
        return CalendarMonthDays(
          year: year,
          month: month,
          selectedDate: currentSelected,
          onDaySelected: (date) {
            setState(() {
              currentSelected = date;
            });
            final targetPage = _pageIndexFor(date);
            if (targetPage != _currentPageIndex) {
              _currentPageIndex = targetPage;
              _pageController.jumpToPage(targetPage);
            }
            widget.controller?.onMonthChanged(date);
          },
        );
      },
      itemCount: totalMonths,
    );
  }
}

/// month controller
class MonthPagerController extends ChangeNotifier {
  /// current displayed month
  DateTime currentTime = DateTime.now();

  /// jump to a month
  void onMonthChanged(DateTime month) {
    currentTime = month;
    notifyListeners();
  }
}
