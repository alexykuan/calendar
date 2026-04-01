import 'package:calendar/widgets/vertical_text.dart';
import 'package:flutter/material.dart';
import 'package:lunar/calendar/Lunar.dart';
import 'package:lunar/calendar/Solar.dart';
import 'package:lunar/calendar/util/LunarUtil.dart';

/// 黄历信息卡片
class AlmanacCard extends StatelessWidget {
  final DateTime dateTime;
  const AlmanacCard({super.key, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    final solar = Solar.fromDate(dateTime);
    final lunar = Lunar.fromDate(dateTime);
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: .all(15),
        decoration: BoxDecoration(
          border: .all(
            color: Theme.of(context).colorScheme.primary,
            width: 1.5,
          ),
          borderRadius: .circular(10),
        ),
        child: Column(
          mainAxisSize: .min,
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    flex: 33,
                    child: Row(
                      mainAxisAlignment: .center,
                      crossAxisAlignment: .start,
                      children: [
                        VerticalCharText(
                          text: lunar.getDayYi().take(5).join(''),
                          textStyle: .new(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: .bold,
                          ),
                        ),
                        VerticalCharText(
                          text: lunar.getDayJi().take(5).join(''),
                          textStyle: .new(fontWeight: .bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 0.5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Expanded(
                    flex: 66,
                    child: Column(
                      mainAxisAlignment: .center,
                      children: [
                        SizedBox(height: 40),
                        Text(
                          '${solar.getDay()}',
                          style: .new(fontSize: 100, fontWeight: .bold),
                        ),
                        Text(
                          '${lunar.getMonthInChinese()}月${lunar.getDayInChinese()}',
                          style: .new(fontSize: 38),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${lunar.getYearGan() + lunar.getYearZhi() + lunar.getYearShengXiao()}年 ${lunar.getMonthGan() + lunar.getMonthZhi()}月 ${lunar.getDayGan() + lunar.getDayZhi()}日',
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 0.5,
              color: Theme.of(context).colorScheme.primary,
            ),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: .center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '胎神',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: .bold,
                                    ),
                                  ),
                                  WidgetSpan(child: SizedBox(height: 10)),
                                  TextSpan(
                                    text: '\n${lunar.getDayPositionTai()}',
                                  ),
                                ],
                              ),
                              textAlign: .center,
                            ),
                          ),
                        ),
                        Container(
                          height: 0.5,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        Expanded(
                          child: Center(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '星宿',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: .bold,
                                    ),
                                  ),
                                  WidgetSpan(child: SizedBox(height: 10)),
                                  TextSpan(
                                    text:
                                        '\n${'${lunar.getGong()}方${lunar.getXiu()}${lunar.getZheng()}${lunar.getAnimal()}'}-${lunar.getXiuLuck()}',
                                  ),
                                ],
                              ),
                              textAlign: .center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 0.5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Expanded(
                    flex: 1,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '彭祖\n',
                            style: TextStyle(fontSize: 18, fontWeight: .bold),
                          ),
                          WidgetSpan(child: SizedBox(height: 10)),
                          TextSpan(text: '\n'),
                          TextSpan(
                            text:
                                '${lunar.getPengZuGan().substring(0, 4)}\n${lunar.getPengZuGan().substring(4)}\n',
                          ),
                          TextSpan(
                            text:
                                '${lunar.getPengZuZhi().substring(0, 4)}\n${lunar.getPengZuZhi().substring(4)}',
                          ),
                        ],
                      ),
                      textAlign: .center,
                    ),
                  ),
                  Container(
                    width: 0.5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '五行',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: .bold,
                                    ),
                                  ),
                                  WidgetSpan(child: SizedBox(height: 10)),
                                  TextSpan(
                                    text:
                                        '\n${lunar.getDayNaYin()} ${lunar.getZhiXing()}执位',
                                  ),
                                ],
                              ),
                              textAlign: .center,
                            ),
                          ),
                        ),
                        Container(
                          height: 0.5,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        Expanded(
                          child: Center(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '冲煞',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: .bold,
                                    ),
                                  ),
                                  WidgetSpan(child: SizedBox(height: 10)),
                                  TextSpan(
                                    text:
                                        '\n${lunar.getDayShengXiao()}日冲${lunar.getDayChongShengXiao()}(${lunar.getDayChongGan() + lunar.getDayChong()})煞${lunar.getDaySha()}',
                                  ),
                                ],
                              ),
                              textAlign: .center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 0.5,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(
              height: 80,
              child: Row(
                children: List<Widget>.generate(12 * 2 - 1, (i) {
                  if (i.isEven) {
                    final index = i ~/ 2;
                    final timeLunar = Lunar.fromDate(
                      DateTime(
                        dateTime.year,
                        dateTime.month,
                        dateTime.day,
                        index * 2,
                      ),
                    );
                    final String luck =
                        LunarUtil.XIU_LUCK[LunarUtil
                            .XIU['${timeLunar.getTimeZhi()}${timeLunar.getWeek()}']] ??
                        '';
                    return Expanded(
                      child: SizedBox(
                        child: Center(
                          child: VerticalCharText(
                            text: '${LunarUtil.ZHI[index + 1]}$luck',
                            textStyle: TextStyle(
                              color: luck == '吉'
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      width: 0.5,
                      color: Theme.of(context).colorScheme.primary,
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
