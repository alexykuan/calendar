import 'package:calendar/widgets/calendar_day.dart';
import 'package:calendar/widgets/weeky_titles.dart';
import 'package:flutter/material.dart';
import 'package:lunar/lunar.dart';

/// A widget to display the days of a month in a calendar view.
///
class CalendarMonthDays extends StatefulWidget {
  /// whether to show the days of other months
  final bool showOtherMonthDays;
  final int year;
  final int month;
  final FirstDayOfWeek firstDayOfWeek;
  const CalendarMonthDays({
    super.key,
    this.showOtherMonthDays = true,
    required this.year,
    required this.month,
    this.firstDayOfWeek = FirstDayOfWeek.monday,
  });

  @override
  State<CalendarMonthDays> createState() => _CalendarMonthDaysState();
}

class _CalendarMonthDaysState extends State<CalendarMonthDays> {
  /// days before the first day of the month to fill the week
  int daysBeforeMonth = 0;

  /// days after the last day of the month to fill the week
  int daysAfterMonth = 0;

  int daysInMonth = 0;

  /// the first day of the month
  DateTime firstDayOfMonth = DateTime.now();

  @override
  void initState() {
    firstDayOfMonth = DateTime(widget.year, widget.month, 1);
    daysInMonth = SolarUtil.getDaysOfMonth(widget.year, widget.month);
    final lastDayOfMonth = DateTime(widget.year, widget.month, daysInMonth);

    /// 往前面补x天
    if (widget.firstDayOfWeek.indice != firstDayOfMonth.weekday) {
      daysBeforeMonth = (firstDayOfMonth.weekday - widget.firstDayOfWeek.indice + 7) % 7;
    }

    /// 往后面补x天
    if (widget.firstDayOfWeek.indice != (lastDayOfMonth.weekday % 7) + 1) {
      daysAfterMonth = (widget.firstDayOfWeek.indice - (lastDayOfMonth.weekday % 7) - 1 + 7) % 7;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1,
          mainAxisSpacing: kCalendarSpace,
          crossAxisSpacing: kCalendarSpace,
        ),
        itemBuilder: (context, index) {
          final DateTime date = index < daysBeforeMonth
              ? firstDayOfMonth.subtract(Duration(days: daysBeforeMonth - index))
              : firstDayOfMonth.add(Duration(days: index - daysBeforeMonth));
          return CalendarDayWidget(date: date);
        },
        itemCount: daysBeforeMonth + daysInMonth + daysAfterMonth,
      ),
    );
  }
}

const kCalendarSpace = 6.0;
