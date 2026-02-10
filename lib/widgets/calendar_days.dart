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
  final Function(DateTime)? onDaySelected;
  final DateTime selectedDate;
  const CalendarMonthDays({
    super.key,
    this.showOtherMonthDays = true,
    required this.year,
    required this.month,
    required this.selectedDate,
    this.onDaySelected,
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
      daysBeforeMonth =
          (firstDayOfMonth.weekday - widget.firstDayOfWeek.indice + 7) % 7;
    }

    /// 往后面补x天
    if (widget.firstDayOfWeek.indice != (lastDayOfMonth.weekday % 7) + 1) {
      daysAfterMonth =
          (widget.firstDayOfWeek.indice -
              (lastDayOfMonth.weekday % 7) -
              1 +
              7) %
          7;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: GridView.builder(
        padding: .symmetric(horizontal: kCalendarHorizontalPadding),
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1,
          mainAxisSpacing: kCalendarSpace,
          crossAxisSpacing: kCalendarSpace,
        ),
        itemBuilder: (context, index) {
          final DateTime date = index < daysBeforeMonth
              ? firstDayOfMonth.subtract(
                  Duration(days: daysBeforeMonth - index),
                )
              : firstDayOfMonth.add(Duration(days: index - daysBeforeMonth));
          return CalendarDayWidget(
            date: date,
            isSelected: widget.selectedDate == date,
            onTap: () {
              setState(() {
                widget.onDaySelected?.call(date);
              });
            },
          );
        },
        itemCount: daysBeforeMonth + daysInMonth + daysAfterMonth,
      ),
    );
  }
}

const kCalendarSpace = 4.0;
const kCalendarHorizontalPadding = 10.0;

/// 计算某年某月日历需要的行数（与 [CalendarMonthDays] 逻辑一致）。
int getCalendarRowCount(
  int year,
  int month, {
  FirstDayOfWeek firstDayOfWeek = FirstDayOfWeek.monday,
}) {
  final firstDayOfMonth = DateTime(year, month, 1);
  final daysInMonth = SolarUtil.getDaysOfMonth(year, month);
  final lastDayOfMonth = DateTime(year, month, daysInMonth);

  int daysBeforeMonth = 0;
  if (firstDayOfWeek.indice != firstDayOfMonth.weekday) {
    daysBeforeMonth =
        (firstDayOfMonth.weekday - firstDayOfWeek.indice + 7) % 7;
  }

  int daysAfterMonth = 0;
  if (firstDayOfWeek.indice != (lastDayOfMonth.weekday % 7) + 1) {
    daysAfterMonth = (firstDayOfWeek.indice -
            (lastDayOfMonth.weekday % 7) -
            1 +
            7) %
        7;
  }

  final totalCells = daysBeforeMonth + daysInMonth + daysAfterMonth;
  return (totalCells / 7).ceil();
}

/// 计算某月某日在该月日历中的行索引（0-based，与 [CalendarMonthDays] 逻辑一致）。
int getCalendarRowForDay(
  int year,
  int month,
  int day, {
  FirstDayOfWeek firstDayOfWeek = FirstDayOfWeek.monday,
}) {
  final firstDayOfMonth = DateTime(year, month, 1);
  final daysInMonth = SolarUtil.getDaysOfMonth(year, month);

  int daysBeforeMonth = 0;
  if (firstDayOfWeek.indice != firstDayOfMonth.weekday) {
    daysBeforeMonth =
        (firstDayOfMonth.weekday - firstDayOfWeek.indice + 7) % 7;
  }

  final cellIndex = daysBeforeMonth + (day - 1).clamp(0, daysInMonth - 1);
  return cellIndex ~/ 7;
}
