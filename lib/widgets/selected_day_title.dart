import 'package:flutter/material.dart';
import 'package:lunar/calendar/Solar.dart';

class TimeTitle extends StatelessWidget {
  final DateTime dateTime;
  const TimeTitle({super.key, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    final dayDiff = Solar.fromDate(
      DateTime.now(),
    ).subtract(Solar.fromDate(dateTime));
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: dateTime.year != DateTime.now().year
                ? '${dateTime.year}年${dateTime.month}月'
                : '${dateTime.month}月',
            style: TextStyle(fontSize: 18, fontWeight: .bold),
          ),
          if (dayDiff != 0)
            TextSpan(
              text: dayDiff > 0 ? ' $dayDiff天前' : ' ${dayDiff.abs()}天后',
              style: TextStyle(fontSize: 14, fontWeight: .bold),
            ),
        ],
      ),
    );
  }
}
