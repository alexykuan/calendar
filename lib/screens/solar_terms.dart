import 'package:calendar/bean/festival.dart';
import 'package:calendar/widgets/festival_item.dart';
import 'package:calendar/widgets/festvial_card.dart';
import 'package:calendar/widgets/inkwell_card.dart';
import 'package:flutter/material.dart';
import 'package:lunar/calendar/Solar.dart';
import 'package:lunar/calendar/util/SolarUtil.dart';

class FestivalAndSolarTermsScreen extends StatefulWidget {
  const FestivalAndSolarTermsScreen({super.key});

  @override
  State<FestivalAndSolarTermsScreen> createState() =>
      _FestivalAndSolarTermsScreenState();
}

class _MonthFestivalData {
  const _MonthFestivalData({
    required this.monthFirstDay,
    required this.festivals,
    required this.dayDiffs,
  });
  final DateTime monthFirstDay;
  final List<Festival> festivals;

  /// 与 [festivals] 一一对应，距 [sourceDateTime] 的天数
  final List<int> dayDiffs;
}

class _FestivalAndSolarTermsScreenState
    extends State<FestivalAndSolarTermsScreen> {
  final DateTime dateTime = DateTime.now();

  final ScrollController _scrollController = ScrollController();
  static const double _expandedHeight = 120.0;

  /// 各月节日在首屏前一次性算好，避免滑到新月份时在 build 里跑 [getFestivals]
  late final List<_MonthFestivalData> _monthSections;

  /// 折叠进度：0 展开，1 折叠。用 [ValueNotifier] 避免滚动时每帧 [setState] 重建整棵列表。
  final ValueNotifier<double> _collapseFraction = ValueNotifier(0.0);

  void _onScrollUpdateCollapse() {
    final offset = _scrollController.offset;
    final f = (offset / (_expandedHeight - kToolbarHeight)).clamp(0.0, 1.0);
    if ((f - _collapseFraction.value).abs() < 0.002) return;
    _collapseFraction.value = f;
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScrollUpdateCollapse);
    final sourceSolar = Solar.fromDate(dateTime);
    _monthSections = List.generate(12 - dateTime.month + 1, (index) {
      final monthFirstDay = DateTime(
        dateTime.year,
        dateTime.month + index,
        index == 0 ? dateTime.day : 1,
      );
      final daysOfMonth =
          SolarUtil.getDaysOfMonth(monthFirstDay.year, monthFirstDay.month) - 1;
      final festivals = getFestivals(
        monthFirstDay,
        step: daysOfMonth - (monthFirstDay.day - 1),
        max: daysOfMonth - (monthFirstDay.day - 1),
      );
      final dayDiffs = festivals
          .map((f) => Solar.fromDate(f.dateTime).subtract(sourceSolar))
          .toList(growable: false);
      return _MonthFestivalData(
        monthFirstDay: monthFirstDay,
        festivals: festivals,
        dayDiffs: dayDiffs,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScrollUpdateCollapse);
    _scrollController.dispose();
    _collapseFraction.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: festivalHeroTag,
      child: Material(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            ValueListenableBuilder<double>(
              valueListenable: _collapseFraction,
              builder: (context, fraction, _) {
                return SliverAppBar(
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest,
                  floating: false,
                  pinned: true,
                  expandedHeight: _expandedHeight,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Opacity(
                      opacity: 1 - fraction,
                      child: const Text(
                        '节日倒数',
                        style: TextStyle(fontWeight: .bold),
                      ),
                    ),
                    centerTitle: false,
                    titlePadding: const EdgeInsets.only(left: 16),
                  ),
                  title: Opacity(
                    opacity: fraction >= 0.8 ? 1.0 : 0.0,
                    child: const Text('节日倒数'),
                  ),
                  centerTitle: true,
                );
              },
            ),
            SliverPadding(
              padding: .only(bottom: MediaQuery.of(context).viewPadding.bottom),
              sliver: SliverList.builder(
                itemBuilder: (context, index) {
                  final data = _monthSections[index];
                  return RepaintBoundary(
                    child: FestivalsOfMonth(
                      sourceDateTime: dateTime,
                      monthFirstDay: data.monthFirstDay,
                      festivals: data.festivals,
                      dayDiffs: data.dayDiffs,
                    ),
                  );
                },
                itemCount: _monthSections.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 一个月的节日节气数据展示（数据与 [dayDiffs] 均由父级预计算）
class FestivalsOfMonth extends StatelessWidget {
  final DateTime sourceDateTime;
  final DateTime monthFirstDay;
  final List<Festival> festivals;
  final List<int> dayDiffs;

  const FestivalsOfMonth({
    super.key,
    required this.sourceDateTime,
    required this.monthFirstDay,
    required this.festivals,
    required this.dayDiffs,
  });

  @override
  Widget build(BuildContext context) {
    assert(festivals.length == dayDiffs.length);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16),
          child: Text(
            '${monthFirstDay.month}月',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        InkwellCard(
          onTap: () => {},
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < festivals.length; i++)
                FestivalItem(
                  item: festivals[i],
                  sourceDateTime: sourceDateTime,
                  dayDiff: dayDiffs[i],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
