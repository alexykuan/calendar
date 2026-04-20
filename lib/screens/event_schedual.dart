import 'package:calendar/dialogs/dialog_date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventSchedualScreen extends StatefulWidget {
  const EventSchedualScreen({super.key});

  @override
  State<EventSchedualScreen> createState() => _EventSchedualScreenState();
}

class _EventSchedualScreenState extends State<EventSchedualScreen> {
  final ScrollController _scrollController = ScrollController();

  /// 折叠进度：0 展开，1 折叠。用 [ValueNotifier] 避免滚动时每帧 [setState] 重建整棵列表。
  final ValueNotifier<double> _collapseFraction = ValueNotifier(0.0);

  static const double _expandedHeight = 200.0;

  /// 当前编辑的日程类型 默认是普通日程
  EventSchedualType _schedualType = EventSchedualType.schedual;

  void _onScrollUpdateCollapse() {
    final offset = _scrollController.offset;
    final f = (offset / (_expandedHeight - kToolbarHeight - 80)).clamp(
      0.0,
      1.0,
    );
    if ((f - _collapseFraction.value).abs() < 0.002) return;
    _collapseFraction.value = f;
  }

  @override
  void initState() {
    _scrollController.addListener(_onScrollUpdateCollapse);
    super.initState();
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
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          ValueListenableBuilder(
            valueListenable: _collapseFraction,
            builder: (context, fraction, child) {
              return SliverAppBar(
                pinned: true,
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest,
                leading: CloseButton(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      showDatePickerDialog(context);
                    },
                    icon: Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
                actionsPadding: .only(right: 16),
                flexibleSpace: FlexibleSpaceBar(
                  title: Opacity(
                    opacity: 1 - fraction,
                    child: Text(
                      '创建${_schedualType.name}',
                      style: const TextStyle(fontWeight: .bold),
                    ),
                  ),
                  centerTitle: false,
                  titlePadding: const EdgeInsets.only(left: 16, bottom: 80),
                ),
                title: Opacity(
                  opacity: fraction >= 0.6 ? 1.0 : 0.0,
                  child: Text('创建${_schedualType.name}'),
                ),
                centerTitle: true,
                bottom: PreferredSize(
                  preferredSize: Size(double.infinity, 60),
                  child: EventSchedualTypes(
                    selectedType: _schedualType,
                    onTypeSelected: (type) {
                      setState(() {
                        _schedualType = type;
                      });
                    },
                  ),
                ),
                expandedHeight: _expandedHeight,
              );
            },
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: Container(color: Colors.amberAccent),
          ),
        ],
      ),
    );
  }
}

/// 日程类型枚举
enum EventSchedualType {
  schedual(name: '日程'),
  birthday(name: '生日'),
  aniversary(name: '纪念日'),
  countdown(name: '倒数日');

  final String name;
  const EventSchedualType({required this.name});
}

class EventSchedualTypes extends StatelessWidget {
  final EventSchedualType selectedType;
  final Function(EventSchedualType)? onTypeSelected;
  const EventSchedualTypes({
    super.key,
    required this.selectedType,
    this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: EventSchedualType.values.map((e) {
        final isSelected = e == selectedType;
        return Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              onTypeSelected?.call(e);
            },
            child: Padding(
              padding: .symmetric(vertical: 10),
              child: Column(
                mainAxisSize: .min,
                children: [
                  Icon(CupertinoIcons.table),
                  Text(
                    e.name,
                    style: TextStyle(
                      fontWeight: .bold,
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
