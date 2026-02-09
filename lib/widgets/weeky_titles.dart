import 'package:calendar/bean/day.dart';
import 'package:flutter/material.dart';

class WeeklyTitles extends StatelessWidget {
  final FirstDayOfWeek firstDayOfWeek;
  const WeeklyTitles({super.key, this.firstDayOfWeek = FirstDayOfWeek.monday});

  @override
  Widget build(BuildContext context) {
    final offset = switch (firstDayOfWeek) {
      FirstDayOfWeek.monday => 0,
      FirstDayOfWeek.saturday => 5,
      FirstDayOfWeek.sunday => 6,
    };
    return Material(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: List.generate(
            7,
            (index) => Expanded(
              child: Center(
                child: Text(
                  WeekDay.values[(index + offset) % 7].name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// first day of a week
enum FirstDayOfWeek {
  monday(1),
  saturday(6),
  sunday(7);

  final int indice;
  const FirstDayOfWeek(this.indice);
}
