import 'package:calendar/bean/festival.dart';
import 'package:calendar/screens/solar_terms.dart';
import 'package:calendar/widgets/festival_item.dart';
import 'package:calendar/widgets/inkwell_card.dart';
import 'package:flutter/material.dart';

/// 节日节气卡片
class FestivalCard extends StatelessWidget {
  final DateTime dateTime;
  const FestivalCard({super.key, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    final festivals = getFestivals(dateTime, max: 3);
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...festivals.map((item) {
              return FestivalItem(item: item, sourceDateTime: dateTime);
            }),
          ],
        ),
      ),
    );
  }
}

/// 节日节气卡片 Hero 标签
const festivalHeroTag = 'festival_card_hero_tag';
