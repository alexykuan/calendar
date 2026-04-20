import 'package:calendar/dialogs/dialog_more_actions.dart';
import 'package:calendar/dialogs/dialog_note_actions.dart';
import 'package:calendar/widgets/calendar_days.dart';
import 'package:calendar/widgets/festvial_card.dart';
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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: .dark,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _monthPagerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            child: FloatingActionButton(
              onPressed: () {
                _monthPagerController.onMonthChanged(DateTime.now());
              },
              child: const Text('今'),
            ),
          );
        },
      ),
      body: ListenableBuilder(
        listenable: _monthPagerController,
        builder: (context, _) {
          final calendarCellHeight =
              (MediaQuery.of(context).size.width -
                  6 * kCalendarSpace -
                  2 * kCalendarHorizontalPadding) /
              7.0;

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

          return CustomScrollView(
            physics: ClampingScrollPhysics(),
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                surfaceTintColor: Colors.transparent,
                title: ListenableBuilder(
                  listenable: _monthPagerController,
                  builder: (context, _) {
                    return TimeTitle(
                      dateTime: _monthPagerController.currentTime,
                    );
                  },
                ),
                titleSpacing: 16,
                actions: [
                  IconButton(
                    onPressed: () {
                      showCalendarNoteActionsDialog(context);
                    },
                    icon: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showCalendarMoreActionsDialog(context);
                    },
                    icon: Icon(
                      Icons.more_vert,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              PinnedHeaderSliver(child: WeeklyTitles()),
              PinnedFlexibleSliver(
                maxHeight: maxH,
                minHeight: calendarCellHeight,
                collapseAnchor: collapseAnchor,
                child: MonthsPager(controller: _monthPagerController),
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
              SliverToBoxAdapter(
                child: YijiCard(dateTime: _monthPagerController.currentTime),
              ),
              SliverToBoxAdapter(
                child: FestivalCard(
                  dateTime: _monthPagerController.currentTime,
                ),
              ),
              SliverFillRemaining(hasScrollBody: true),
            ],
          );
        },
      ),
    );
  }
}
