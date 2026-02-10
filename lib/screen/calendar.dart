import 'package:calendar/widgets/calendar_days.dart';
import 'package:calendar/widgets/months.dart';
import 'package:calendar/widgets/pinned_flexiable_sliver.dart';
import 'package:calendar/widgets/selected_day_title.dart';
import 'package:calendar/widgets/weeky_titles.dart';
import 'package:calendar/widgets/yiji_card.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final MonthPagerController _monthPagerController = MonthPagerController();

  @override
  Widget build(BuildContext context) {
    final calendarCellHeight =
        (MediaQuery.of(context).size.width -
            6 * kCalendarSpace -
            2 * kCalendarHorizontalPadding) /
        7.0;
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: CustomScrollView(
        // 到顶/底时用弹性而非瞬间夹紧，避免抽动感
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: kToolbarHeight + 30,
            flexibleSpace: FlexibleSpaceBar(
              title: ListenableBuilder(
                listenable: _monthPagerController,
                builder: (context, child) {
                  return TimeTitle(dateTime: _monthPagerController.currentTime);
                },
              ),
              expandedTitleScale: 1.3,
              centerTitle: false,
              titlePadding: EdgeInsets.only(
                left: 16,
                bottom: (kToolbarHeight - 16) / 2,
              ),
            ),
            centerTitle: false,
            pinned: true,
            floating: true,
            surfaceTintColor: Colors.transparent,
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
              final maxH = calendarCellHeight * rowCount +
                  kCalendarSpace * (rowCount > 0 ? rowCount - 1 : 0);
              final selectedRow = getCalendarRowForDay(
                _monthPagerController.currentTime.year,
                _monthPagerController.currentTime.month,
                _monthPagerController.currentTime.day,
              );
              final collapseAnchor = (selectedRow *
                      (calendarCellHeight + kCalendarSpace))
                  .clamp(0.0, maxH - calendarCellHeight);
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
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
          ),
        ],
      ),
    );
  }
}
