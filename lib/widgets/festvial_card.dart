import 'package:calendar/screen/solar_terms.dart';
import 'package:calendar/widgets/inkwell_card.dart';
import 'package:flutter/material.dart';

/// 节日节气卡片
class FestivalCard extends StatelessWidget {
  final DateTime dateTime;
  const FestivalCard({super.key, required this.dateTime});

  /// 根据日期获取节日和节气信息（测试数据）。
  /// 真实逻辑后续用日期解析再填充
  List<Map<String, String>> getFestivalAndSolarTerm() {
    return [
      {'title': 'Fathers\' Day', 'detail': '1 day'},
      {'title': 'Mother\'s Day', 'detail': '2 days'},
      {'title': 'Children\'s Day', 'detail': '3 days'},
      {'title': 'Some Holiday', 'detail': '4 days'},
      {'title': 'Next Holiday', 'detail': '5 days'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    final items = getFestivalAndSolarTerm();
    final visibleCount = items.length.clamp(0, 3);
    final visibleItems = items.take(visibleCount);
    return Hero(
      tag: festivalHeroTag,
      child: InkwellCard(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FestivalAndSolarTermsScreen(),
            ),
          );
        },
        padding: .zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...visibleItems.map(
              (item) => ListTile(
                dense: true,
                visualDensity: VisualDensity.compact,
                title: Text(item['title'] ?? ''),
                trailing: Text(item['detail'] ?? ''),
              ),
            ),
            if (items.length > visibleCount)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  '+${items.length - visibleCount} more',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// 节日节气卡片 Hero 标签
const festivalHeroTag = 'festival_card_hero_tag';
