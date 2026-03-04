import 'dart:ffi';

import 'package:calendar/widgets/almanac_card.dart';
import 'package:calendar/widgets/yiji_card.dart';
import 'package:flutter/material.dart';
import 'package:lunar/calendar/Solar.dart';

/// 农历黄历
class AlmanacScreen extends StatefulWidget {
  final DateTime dateTime;

  const AlmanacScreen({super.key, required this.dateTime});

  @override
  State<AlmanacScreen> createState() => _AlmanacScreenState();
}

class _AlmanacScreenState extends State<AlmanacScreen> {
  final _controller = PageController(initialPage: 365);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late var solar = Solar.fromDate(widget.dateTime);
  late var dateTime = widget.dateTime;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Hero(
        tag: almanacCardHeroTag,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              '${solar.getYear()}年${solar.getMonth()}月${solar.getDay()}日星期${solar.getWeekInChinese()}',
            ),
            centerTitle: true,
          ),
          body: PageView.builder(
            controller: _controller,
            onPageChanged: (value) {
              setState(() {
                dateTime = value >= 365
                    ? widget.dateTime.add(Duration(days: value - 365))
                    : widget.dateTime.subtract(Duration(days: 365 - value));
                solar = Solar.fromDate(dateTime);
              });
            },
            itemBuilder: (context, index) {
              return AlmanacCard(dateTime: dateTime);
            },
            itemCount: 365 * 2,
          ),
        ),
      ),
    );
  }
}
