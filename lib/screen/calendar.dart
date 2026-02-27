import 'package:calendar/widgets/amplified_scroll_physics.dart';
import 'package:calendar/widgets/calendar_days.dart';
import 'package:calendar/widgets/months.dart';
import 'package:calendar/widgets/pinned_flexiable_sliver.dart';
import 'package:calendar/widgets/selected_day_title.dart';
import 'package:calendar/widgets/weeky_titles.dart';
import 'package:calendar/widgets/yiji_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunar/lunar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final MonthPagerController _monthPagerController = MonthPagerController();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  void dispose() {
    // 离开页面时恢复默认（允许所有方向）
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final calendarCellHeight =
        (MediaQuery.of(context).size.width -
            6 * kCalendarSpace -
            2 * kCalendarHorizontalPadding) /
        7.0;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      floatingActionButton: ListenableBuilder(
        listenable: _monthPagerController,
        builder: (context, child) {
          return Offstage(
            offstage:
                Solar.fromDate(
                  DateTime.now(),
                ).subtract(Solar.fromDate(_monthPagerController.currentTime)) ==
                0,
            child: TextButton(
              onPressed: () {
                _monthPagerController.onMonthChanged(DateTime.now());
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '今',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 18,
                      fontWeight: .bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      body: CustomScrollView(
        physics: const AmplifiedScrollPhysics(
          speedFactor: 1.8,
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            floating: true,
            surfaceTintColor: Colors.transparent,
            title: ListenableBuilder(
              listenable: _monthPagerController,
              builder: (context, _) {
                return TimeTitle(dateTime: _monthPagerController.currentTime);
              },
            ),
            titleSpacing: 16,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
          PinnedHeaderSliver(child: WeeklyTitles()),
          ListenableBuilder(
            listenable: _monthPagerController,
            builder: (context, _) {
              final rowCount = getCalendarRowCount(
                _monthPagerController.currentTime.year,
                _monthPagerController.currentTime.month,
              );
              final maxH =
                  calendarCellHeight * rowCount +
                  kCalendarSpace * (rowCount > 0 ? rowCount - 1 : 0);
              final selectedRow = getCalendarRowForDay(
                _monthPagerController.currentTime.year,
                _monthPagerController.currentTime.month,
                _monthPagerController.currentTime.day,
              );
              final collapseAnchor =
                  (selectedRow * (calendarCellHeight + kCalendarSpace)).clamp(
                    0.0,
                    maxH - calendarCellHeight,
                  );
              return PinnedFlexibleSliver(
                maxHeight: maxH,
                minHeight: calendarCellHeight,
                collapseAnchor: collapseAnchor,
                child: MonthsPager(controller: _monthPagerController),
              );
            },
          ),
          PinnedHeaderSliver(
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
          PinnedHeaderSliver(
            child: ListenableBuilder(
              listenable: _monthPagerController,
              builder: (context, child) {
                return YijiCard(dateTime: _monthPagerController.currentTime);
              },
            ),
          ),
          SliverFillRemaining(
            child: Container(
              height: double.infinity,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
          ),
        ],
      ),
    );
  }
}
