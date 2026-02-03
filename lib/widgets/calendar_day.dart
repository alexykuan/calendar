import 'package:flutter/material.dart';
import 'package:lunar/calendar/util/HolidayUtil.dart';
import 'package:lunar/lunar.dart';

class CalendarDayWidget extends StatefulWidget {
  final DateTime date;
  final bool show;
  const CalendarDayWidget({super.key, required this.date, this.show = true});

  @override
  State<CalendarDayWidget> createState() => _CalendarDayWidgetState();
}

class _CalendarDayWidgetState extends State<CalendarDayWidget> {
  @override
  Widget build(BuildContext context) {
    var holiday = HolidayUtil.getHolidayByYmd(widget.date.year, widget.date.month, widget.date.day);
    final isWeekend = widget.date.weekday == DateTime.saturday || widget.date.weekday == DateTime.sunday;
    return Container(
      decoration: BoxDecoration(
        borderRadius: (holiday != null && !holiday.isWork()) || isWeekend ? BorderRadius.circular(8) : null,
        color: (holiday != null && !holiday.isWork()) || isWeekend ? Colors.red.withValues(alpha: 0.1) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${widget.date.day}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          holiday != null && !holiday.isWork()
              ? Text(holiday.getName(), style: TextStyle(fontSize: 10, color: Colors.red))
              : Text(Lunar.fromDate(widget.date).getDayInChinese(), style: TextStyle(fontSize: 10)),
        ],
      ),
    );
  }
}
