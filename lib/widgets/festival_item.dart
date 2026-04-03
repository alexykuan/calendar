import 'package:calendar/bean/festival.dart';
import 'package:flutter/material.dart';
import 'package:lunar/calendar/Solar.dart';

class FestivalItem extends StatelessWidget {
  final Festival item;
  final DateTime sourceDateTime;

  /// 若由父级预先算好距 [sourceDateTime] 的天数，可避免重复 [Solar.subtract]
  final int? dayDiff;

  const FestivalItem({
    required this.item,
    required this.sourceDateTime,
    this.dayDiff,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final solar = Solar.fromDate(item.dateTime);
    final diff = dayDiff ?? solar.subtract(Solar.fromDate(sourceDateTime));
    return ListTile(
      dense: true,
      contentPadding: .zero,
      visualDensity: VisualDensity.compact,
      title: Text(item.name, style: TextStyle(fontSize: 16)),
      subtitle: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: item.lunar != null
                  ? '${item.lunar!.getMonthInChinese()}月${item.lunar!.getDayInChinese()}'
                  : '${solar.getMonth()}月${solar.getDay()}日',
            ),
            WidgetSpan(
              alignment: .middle,
              child: Container(
                margin: .symmetric(horizontal: 6),
                width: 1,
                height: 12,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            TextSpan(text: '周${solar.getWeekInChinese()}'),
          ],
        ),
        style: TextStyle(fontSize: 14),
      ),
      trailing: Offstage(
        offstage: diff == 0,
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: '$diff', style: TextStyle(fontSize: 28)),
              TextSpan(text: '天', style: TextStyle(fontSize: 14)),
            ],
          ),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
