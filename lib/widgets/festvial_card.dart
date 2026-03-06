import 'package:calendar/screen/solar_terms.dart';
import 'package:calendar/widgets/gesture_route.dart';
import 'package:calendar/widgets/inkwell_card.dart';
import 'package:flutter/material.dart';

/// 节日节气卡片
class FestivalCard extends StatelessWidget {
  final DateTime dateTime;
  const FestivalCard({super.key, required this.dateTime});

  /// 根据日期获取节日和节气信息最多三个
  getFestivalAndSolarTerm() {}

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: festivalHeroTag,
      child: InkwellCard(
        onTap: () {
          Navigator.of(context).push(
            GesturePageRoute(
              builder: (context) => FestivalAndSolarTermsScreen(),
            ),
          );
        },
        padding: .zero,
        child: Column(
          children: [
            ListTile(leading: Text('Fathers\' Day'), trailing: Text('1 day')),
            ListTile(leading: Text('Fathers\' Day'), trailing: Text('2 days')),
            ListTile(leading: Text('Fathers\' Day'), trailing: Text('3 days')),
          ],
        ),
      ),
    );
  }
}

/// 节日节气卡片 Hero 标签
const festivalHeroTag = 'festival_card_hero_tag';
