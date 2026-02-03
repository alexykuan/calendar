/// 一周七天 带中文简称枚举
enum WeekDay {
  monday('一'),
  tuseDay('二'),
  wednesday('三'),
  thursday('四'),
  friday('五'),
  saturday('六'),
  sunday('日');

  final String name;
  const WeekDay(this.name);
}
