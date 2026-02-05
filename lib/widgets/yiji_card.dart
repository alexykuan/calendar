import 'package:flutter/material.dart';
import 'package:lunar/calendar/Lunar.dart';

class YijiCard extends StatelessWidget {
  final DateTime dateTime;
  const YijiCard({super.key, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    final lunar = Lunar.fromDate(dateTime);
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${lunar.getMonthInChinese()}月${lunar.getDayInChinese()}',
              style: TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '${lunar.getYearInGanZhi()}${lunar.getYearShengXiao()}年 ${lunar.getMonthInGanZhi()}月 ${lunar.getDayInGanZhi()}日',
                style: TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Container(
                              width: 20,
                              height: 20,
                              margin: EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(6)),
                              child: Center(
                                child: Text(
                                  '宜',
                                  style: TextStyle(
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
                              width: 20,
                              height: 20,
                              margin: EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(6)),
                              child: Center(
                                child: Text(
                                  '忌',
                                  style: TextStyle(
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
