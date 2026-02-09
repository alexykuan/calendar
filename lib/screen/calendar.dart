import 'package:calendar/widgets/calendar_days.dart';
import 'package:calendar/widgets/pinned_flexiable_sliver.dart';
import 'package:calendar/widgets/weeky_titles.dart';
import 'package:calendar/widgets/yiji_card.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    final calendarCellHeight = (MediaQuery.of(context).size.width - 6 * kCalendarSpace) / 7.0;
    return CustomScrollView(
      physics: ClampingScrollPhysics(),
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          expandedHeight: kToolbarHeight + 30,
          backgroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Calendar', style: TextStyle(fontSize: 18)),
            expandedTitleScale: 1.3,
            centerTitle: false,
            titlePadding: EdgeInsets.only(left: 16, bottom: (kToolbarHeight - 16) / 2),
          ),
          centerTitle: false,
          pinned: true,
          floating: true,
          surfaceTintColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add, color: Colors.black),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert, color: Colors.black),
            ),
          ],
        ),
        PinnedHeaderSliver(child: WeeklyTitles()),
        PinnedFlexibleSliver(
          maxHeight: calendarCellHeight * 5 + kCalendarSpace * 4,
          minHeight: calendarCellHeight,
          collapseAnchor: calendarCellHeight * 3 + kCalendarSpace * 3,
          child: CalendarMonthDays(year: 2026, month: 2),
        ),
        PinnedHeaderSliver(
          child: Container(
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(child: YijiCard(dateTime: DateTime.now())),
        SliverFillRemaining(child: Container(color: Colors.amber)),
      ],
    );
  }
}
