import 'package:flutter/material.dart';
import 'package:lunar/lunar.dart';

/// 单日展示用的农历/节假日等计算结果，避免每帧重复计算
class _DayDisplayData {
  const _DayDisplayData({
    this.holidayName,
    this.isRestDay = false,
    this.isHolidayTargetDay = false,
    required this.subtitle,
  });
  final String? holidayName;
  final bool isRestDay;
  final bool isHolidayTargetDay;
  final String subtitle;
}

const int _kDayDisplayCacheMaxSize = 120;

final Map<String, _DayDisplayData> _dayDisplayCache = {};
final List<String> _dayDisplayCacheKeys = [];

_DayDisplayData _computeDayDisplayData(DateTime date) {
  final lunar = Lunar.fromDate(date);
  final holiday = HolidayUtil.getHolidayByYmd(date.year, date.month, date.day);
  final isHolidayTargetDay =
      holiday?.getTarget() == Solar.fromDate(date).toYmd();
  final jieQi = lunar.getCurrentJieQi()?.getName();
  final subtitle = jieQi ?? lunar.getDayInChinese();
  return _DayDisplayData(
    holidayName: isHolidayTargetDay ? holiday?.getName() : null,
    isRestDay: holiday != null && !holiday.isWork(),
    isHolidayTargetDay: isHolidayTargetDay,
    subtitle: subtitle,
  );
}

_DayDisplayData _getDayDisplayData(DateTime date) {
  final key = '${date.year}-${date.month}-${date.day}';
  var data = _dayDisplayCache[key];
  if (data != null) return data;
  data = _computeDayDisplayData(date);
  if (_dayDisplayCacheKeys.length >= _kDayDisplayCacheMaxSize) {
    final evict = _dayDisplayCacheKeys.removeAt(0);
    _dayDisplayCache.remove(evict);
  }
  _dayDisplayCacheKeys.add(key);
  _dayDisplayCache[key] = data;
  return data;
}

class CalendarDayWidget extends StatefulWidget {
  final DateTime date;
  final bool show;
  final bool isSelected;
  final Function onTap;
  const CalendarDayWidget({
    super.key,
    required this.date,
    required this.onTap,
    this.isSelected = false,
    this.show = true,
  });

  @override
  State<CalendarDayWidget> createState() => _CalendarDayWidgetState();
}

class _CalendarDayWidgetState extends State<CalendarDayWidget> {
  @override
  Widget build(BuildContext context) {
    final data = _getDayDisplayData(widget.date);
    final isToday =
        Solar.fromDate(DateTime.now()).subtract(Solar.fromDate(widget.date)) ==
        0;
    return RepaintBoundary(
      child: GestureDetector(
        onTap: () => widget.onTap(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: (data.isRestDay || widget.isSelected || isToday)
                ? BorderRadius.circular(8)
                : null,
            color: (data.isRestDay || isToday)
                ? Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: isToday ? 1.0 : 0.2)
                : null,
            border: widget.isSelected
                ? Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1,
                  )
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${widget.date.day}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isToday
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),

              Text(
                data.holidayName ?? data.subtitle,
                style: TextStyle(
                  fontSize: 10,
                  color: isToday
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
