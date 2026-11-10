import 'package:material_ui/material_ui.dart';
import 'package:weather_app_flutter/utils/app_util.dart';
import 'package:weather_app_flutter/utils/ext.dart';

class TempText extends StatelessWidget {
  const TempText({super.key, this.value, required this.unit, this.style});
  final dynamic value;
  final int unit; // 'C', 'F', 'K'
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: style,
        children: [
          value != null ? TextSpan(text: AppUtil.formatTemp(unit, value)) : TextSpan(),
          TextSpan(
            text: unit == 2 ? ' ' : ' °',
            style: TextStyle(color: context.primary),
          ),
          TextSpan(
            text: unit == 0
                ? 'C'
                : unit == 1
                ? 'F'
                : 'K',
          ),
        ],
      ),
    );
  }
}
