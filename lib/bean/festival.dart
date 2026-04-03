import 'package:lunar/calendar/Lunar.dart';
import 'package:lunar/calendar/Solar.dart';
import 'package:lunar/calendar/util/HolidayUtil.dart';

/// 节日包装类 lunar代表传统农历节日, dateTime代表阳历节日
class Festival {
  final String name;
  final Lunar? lunar;
  final DateTime dateTime;

  Festival({required this.name, this.lunar, required this.dateTime});
}

/// 获取节日和节气其它传统节日宜忌纪念日数据以及法定假日，这里最多只会取三个
/// [max] 最多获取的节日数量
/// [startDateTime] 从这个日期开始往后获取节日数据
/// [step] 从[startDateTime]开始往后获取节日数据的天数，默认100天
List<Festival> getFestivals(
  DateTime startDateTime, {
  int max = 31,
  int step = 100,
}) {
  int festivalCount = 0;
  var festivals = <Festival>[];

  /// 最多拿100天的数据
  for (var day = 0; day < step && festivalCount <= max; day++) {
    var date = startDateTime.add(Duration(days: day));
    var holiday = HolidayUtil.getHolidayByYmd(date.year, date.month, date.day);

    /// 先获取法定假日数据
    if (holiday != null &&
        holiday.getTarget() ==
            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}') {
      festivals.add(Festival(name: holiday.getName(), dateTime: date));
      festivalCount++;
    }

    /// 获取节日节气
    var lunar = Lunar.fromDate(date);
    var jie = lunar.getJie();
    var qi = lunar.getQi();
    if ((jie.isNotEmpty || qi.isNotEmpty) && jie != '清明') {
      festivals.add(
        Festival(name: jie.isNotEmpty ? jie : qi, lunar: lunar, dateTime: date),
      );
      festivalCount++;
    }

    /// 阳历节日
    var solar = Solar.fromDate(date);
    var solarfestivals = solar.getFestivals();
    var otherFestivals = solar.getOtherFestivals();

    /// 排除掉法定假日和节气节日重复的情况
    if ((solarfestivals.isNotEmpty &&
        (holiday == null || holiday.getName() != solarfestivals.first))) {
      festivals.add(Festival(name: solarfestivals.first, dateTime: date));
      festivalCount++;
    }

    /// 排除掉法定假日和节气节日重复的情况
    if ((otherFestivals.isNotEmpty &&
        (holiday == null || holiday.getName() != otherFestivals.first))) {
      festivals.add(Festival(name: otherFestivals.first, dateTime: date));
      festivalCount++;
    }
  }
  return festivals.take(max).toList();
}
