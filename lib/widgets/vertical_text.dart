// 纯竖排文字组件（无旋转，从上到下单行）
import 'package:flutter/widgets.dart';

class VerticalCharText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final double spacing; // 字符之间的垂直间距

  const VerticalCharText({
    super.key,
    required this.text,
    required this.textStyle,
    this.spacing = 2,
  });

  @override
  Widget build(BuildContext context) {
    // 拆分每个字符，生成垂直排列的Text列表
    List<Widget> charWidgets = [];
    for (int i = 0; i < text.length; i++) {
      charWidgets.add(Text(text[i], style: textStyle));
      // 最后一个字符不加间距
      if (i != text.length - 1) {
        charWidgets.add(SizedBox(height: spacing));
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min, // 仅包裹内容（单行竖排）
      children: charWidgets, // 字符垂直排列，实现从上到下单行竖排
    );
  }
}
