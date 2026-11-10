import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_ui/material_ui.dart';
import 'package:weather_app_flutter/data/models/one_call/daily.dart';
import 'package:weather_app_flutter/utils/app_util.dart';
import 'package:weather_app_flutter/utils/ext.dart';

class DailyItem extends ConsumerWidget {
  final Daily? daily;
  const DailyItem({super.key, required this.daily});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SvgPicture.asset(
          AppUtil.getWeatherIcon(daily?.weather?[0].icon),
          width: 42,
          height: 42,
          colorFilter: .mode(context.colorScheme.onSurface, .srcATop),
          fit: .cover,
        ),
        Text(AppUtil.getFormatDT(daily?.dt, 'EEE')),
        Container(
          margin: .only(top: 8),
          padding: const .symmetric(horizontal: 5, vertical: 3),
          decoration: BoxDecoration(
            color: context.colorScheme.primary.withValues(alpha: .75),
            borderRadius: .circular(6),
          ),
          child: Text(
            AppUtil.getFormatDT(daily?.dt, 'dd/MM'),
            style: context.textTheme.bodySmall?.clr(context.colorScheme.onPrimary),
          ),
        ),
      ],
    );
  }
}
