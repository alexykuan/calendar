import 'package:calendar/screens/almanac.dart';
import 'package:calendar/widgets/inkwell_card.dart';
import 'package:flutter/material.dart';
import 'package:lunar/calendar/Lunar.dart';

class YijiCard extends StatelessWidget {
  final DateTime dateTime;
  const YijiCard({super.key, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    final lunar = Lunar.fromDate(dateTime);
    return Hero(
      tag: almanacCardHeroTag,
      child: InkwellCard(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AlmanacScreen(dateTime: dateTime),
            ),
          );
        },
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${lunar.getMonthInChinese()}月${lunar.getDayInChinese()}',
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const .only(top: 8.0),
              child: Text(
                '${lunar.getYearInGanZhi()}${lunar.getYearShengXiao()}年 ${lunar.getMonthInGanZhi()}月 ${lunar.getDayInGanZhi()}日',
                style: TextStyle(fontSize: 14, fontWeight: .bold),
              ),
            ),
            Padding(
              padding: const .only(top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            alignment: .middle,
                            child: Container(
                              width: 18,
                              height: 18,
                              margin: .only(right: 4),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  '宜',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextSpan(text: lunar.getDayYi().join('、')),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Container(
                              width: 18,
                              height: 18,
                              margin: EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  '忌',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextSpan(text: lunar.getDayJi().join('、')),
                        ],
                      ),
                      maxLines: 1,
                      overflow: .ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const almanacCardHeroTag = "almanac_card_hero_tag";
