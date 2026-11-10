import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:weather_app_flutter/data/models/one_call/hourly.dart';
import 'package:weather_app_flutter/features/settings/provider/settings_provider.dart';
import 'package:weather_app_flutter/features/widgets/detail_item.dart';
import 'package:weather_app_flutter/features/widgets/temp_text.dart';
import 'package:weather_app_flutter/utils/app_const.dart';
import 'package:weather_app_flutter/utils/app_util.dart';
import 'package:weather_app_flutter/utils/ext.dart';

class HourlyItem extends ConsumerWidget {
  final int index;
  final Hourly? hourly;
  const HourlyItem({super.key, required this.index, this.hourly});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempUnit = ref.watch(settingsProvider.select((s) => s.tempUnit));
    final speedUnit = ref.watch(settingsProvider.select((s) => s.speedUnit));
    final pressUnit = ref.watch(settingsProvider.select((s) => s.pressUnit));
    final distUnit = ref.watch(settingsProvider.select((s) => s.distUnit));
    return Material(
      color: context.colorScheme.surfaceContainer.withValues(alpha: .5),
      borderRadius: .circular(20),
      clipBehavior: .hardEdge,
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            showDragHandle: true,
            builder: (context) => Padding(
              padding: .only(left: 16, right: 16, bottom: context.paddingBottom + 16),
              child: Column(
                mainAxisSize: .min,
                children: [
                  Row(
                    mainAxisAlignment: .center,
                    children: [
                      SvgPicture.asset(
                        AppUtil.getWeatherIcon(hourly?.weather?[0].icon),
                        width: 46,
                        height: 46,
                        colorFilter: .mode(context.colorScheme.primary, .srcATop),
                        fit: BoxFit.cover,
                      ),
                      const Gap(10),
                      TempText(unit: tempUnit, value: hourly?.temp, style: context.textTheme.displaySmall?.bold),
                    ],
                  ),
                  Text(AppUtil.getWeatherCondition(hourly?.weather?[0].id ?? 0), style: context.textTheme.titleMedium),
                  Text(AppUtil.getFormatDT(hourly?.dt, 'EEEE, dd/MM HH:mm'), style: context.textTheme.labelMedium),
                  const Gap(24),
                  Material(
                    color: context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    clipBehavior: Clip.hardEdge,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DetailItem(title: 'Clouds', value: '${hourly?.clouds} %'),
                          DetailItem(title: 'Dew Point', value: AppUtil.formatTempText(tempUnit, hourly?.dewPoint)),
                          DetailItem(title: 'Feels Like', value: AppUtil.formatTempText(tempUnit, hourly?.feelsLike)),
                          DetailItem(
                            title: 'Gust',
                            value:
                                '${AppUtil.formatSpeed(speedUnit, hourly?.windGust)} ${AppUtil.unitSpeed(speedUnit)}',
                          ),
                          DetailItem(title: 'Humidity', value: '${hourly?.humidity} %'),
                          DetailItem(
                            title: 'Pressure',
                            value:
                                '${AppUtil.formatPress(pressUnit, hourly?.pressure)} ${AppUtil.unitPress(pressUnit)}',
                          ),
                          DetailItem(title: 'Rain', value: '${((hourly?.pop ?? 0) * 100).round()} %'),
                          DetailItem(title: 'Rainfall', value: '${hourly?.rain?.oneh ?? 0} mm/h'),
                          DetailItem(title: 'UV Index', value: '${hourly?.uvi}'),
                          DetailItem(
                            title: 'Visibility',
                            value: '${AppUtil.formatDist(distUnit, hourly?.visibility)} ${AppUtil.unitDist(distUnit)}',
                          ),
                          DetailItem(
                            title: 'Wind',
                            value:
                                '${AppUtil.formatSpeed(speedUnit, hourly?.windSpeed)} ${AppUtil.unitSpeed(speedUnit)}',
                          ),
                          DetailItem(title: 'Wind Degree', value: '${hourly?.windDeg}$degChar', showDivider: false),
                        ],
                      ),
                    ),
                  ),
                  const Gap(10),
                  FilledButton(
                    onPressed: () => context.pop(),
                    child: const SizedBox(
                      width: double.infinity,
                      child: Text('Close', textAlign: TextAlign.center),
                    ),
                  ),
                ],
              ),
            ),
          );
          // Get.dialog(Hourly?Dialog(hourly?));
        },
        child: Padding(
          padding: EdgeInsets.only(left: index % 2 != 0 ? 10 : 0, right: index % 2 != 0 ? 0 : 10, top: 16, bottom: 16),
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            children: [
              Text(AppUtil.getFormatDT(hourly?.dt, 'EEE'), style: context.textTheme.titleSmall),
              Text(AppUtil.getFormatDT(hourly?.dt, 'HH:mm'), style: context.textTheme.labelMedium),
              SvgPicture.asset(
                AppUtil.getWeatherIcon(hourly?.weather?[0].icon),
                width: 42,
                height: 42,
                colorFilter: .mode(context.colorScheme.primary, BlendMode.srcATop),
                fit: .cover,
              ),
              TempText(unit: tempUnit, value: hourly?.temp, style: context.textTheme.headlineSmall?.bold),
              Text('UV: ${hourly?.uvi}', style: context.textTheme.labelSmall),
              Text('Rain: ${((hourly?.pop ?? 0) * 100).round()} %', style: context.textTheme.labelSmall),
            ],
          ),
        ),
      ),
    );
  }
}
