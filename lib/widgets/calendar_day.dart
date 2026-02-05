import 'package:flutter/material.dart';
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
    final isHolidayTargetDay = holiday?.getTarget() == Solar.fromDate(widget.date).toYmd();
    final jieQi = Lunar.fromDate(widget.date).getCurrentJieQi()?.getName();
    return Container(
      decoration: BoxDecoration(
        borderRadius: (holiday != null && !holiday.isWork()) ? BorderRadius.circular(8) : null,
        color: (holiday != null && !holiday.isWork()) ? Colors.red.withValues(alpha: 0.1) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${widget.date.day}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          holiday != null && !holiday.isWork() && isHolidayTargetDay
              ? Text(holiday.getName(), style: TextStyle(fontSize: 10, color: Colors.red))
              : Text(jieQi ?? Lunar.fromDate(widget.date).getDayInChinese(), style: TextStyle(fontSize: 10)),
        ],
      ),
    );
  }
}
