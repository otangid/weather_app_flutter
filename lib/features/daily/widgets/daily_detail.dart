import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:material_ui/material_ui.dart';
import 'package:weather_app_flutter/data/models/one_call/daily.dart';
import 'package:weather_app_flutter/features/settings/provider/settings_provider.dart';
import 'package:weather_app_flutter/features/widgets/detail_item.dart';
import 'package:weather_app_flutter/features/widgets/temp_text.dart';
import 'package:weather_app_flutter/utils/app_const.dart';
import 'package:weather_app_flutter/utils/app_util.dart';
import 'package:weather_app_flutter/utils/ext.dart';

class DailyDetail extends ConsumerWidget {
  const DailyDetail({super.key, this.daily});
  final Daily? daily;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempUnit = ref.watch(settingsProvider.select((s) => s.tempUnit));
    final speedUnit = ref.watch(settingsProvider.select((s) => s.speedUnit));
    final pressUnit = ref.watch(settingsProvider.select((s) => s.pressUnit));
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: .only(bottom: context.paddingBottom + 16),
      child: Column(
        children: [
          const Gap(16),
          Padding(
            padding: .symmetric(vertical: 16),
            child: Row(
              spacing: 16,
              mainAxisAlignment: .center,
              children: [
                SvgPicture.asset(
                  AppUtil.getWeatherIcon(daily?.weather?[0].icon),
                  width: 95,
                  height: 95,
                  colorFilter: .mode(context.colorScheme.onSurface, .srcATop),
                ),
                Column(
                  spacing: 8,
                  children: [
                    TempText(unit: tempUnit, value: daily?.temp?.max, style: context.textTheme.displaySmall?.bold),
                    TempText(unit: tempUnit, value: daily?.temp?.min, style: context.textTheme.displaySmall?.bold),
                  ],
                ),
              ],
            ),
          ),
          Text(
            AppUtil.getWeatherCondition(daily?.weather?[0].id ?? 0).toUpperCase(),
            style: context.textTheme.headlineMedium?.bold.clr(context.primary),
          ),
          Text(AppUtil.getWeatherDescription(daily?.weather?[0].id ?? 0)),
          const Gap(16),
          const Divider(height: 1, indent: 16, endIndent: 16),
          Padding(
            padding: .symmetric(vertical: 16),
            child: Text('Temperature', style: context.textTheme.titleLarge?.medium),
          ),
          Padding(
            padding: .symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('Morning', style: context.textTheme.labelMedium),
                    TempText(unit: tempUnit, value: daily?.temp?.morn, style: context.textTheme.titleMedium?.bold),
                  ],
                ),
                Container(width: 1, height: 24, color: context.colorScheme.outline),
                Column(
                  children: [
                    Text('Evening', style: context.textTheme.labelMedium),
                    TempText(unit: tempUnit, value: daily?.temp?.eve, style: context.textTheme.titleMedium?.bold),
                  ],
                ),
                Container(width: 1, height: 24, color: context.colorScheme.outline),
                Column(
                  children: [
                    Text('Day', style: context.textTheme.labelMedium),
                    TempText(unit: tempUnit, value: daily?.temp?.day, style: context.textTheme.titleMedium?.bold),
                  ],
                ),
                Container(width: 1, height: 24, color: context.colorScheme.outline),
                Column(
                  children: [
                    Text('Night', style: context.textTheme.labelMedium),
                    TempText(unit: tempUnit, value: daily?.temp?.night, style: context.textTheme.titleMedium?.bold),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: .symmetric(vertical: 16),
            child: Text('Feels Like', style: context.textTheme.titleLarge?.medium),
          ),
          Padding(
            padding: .symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('Morning', style: context.textTheme.labelMedium),
                    TempText(unit: tempUnit, value: daily?.feelsLike?.morn, style: context.textTheme.titleMedium?.bold),
                  ],
                ),
                Container(width: 1, height: 24, color: context.colorScheme.outline),
                Column(
                  children: [
                    Text('Evening', style: context.textTheme.labelMedium),
                    TempText(unit: tempUnit, value: daily?.feelsLike?.eve, style: context.textTheme.titleMedium?.bold),
                  ],
                ),
                Container(width: 1, height: 24, color: context.colorScheme.outline),
                Column(
                  children: [
                    Text('Day', style: context.textTheme.labelMedium),
                    TempText(unit: tempUnit, value: daily?.feelsLike?.day, style: context.textTheme.titleMedium?.bold),
                  ],
                ),
                Container(width: 1, height: 24, color: context.colorScheme.outline),
                Column(
                  children: [
                    Text('Night', style: context.textTheme.labelMedium),
                    TempText(
                      unit: tempUnit,
                      value: daily?.feelsLike?.night,
                      style: context.textTheme.titleMedium?.bold,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(height: 1, indent: 16, endIndent: 16),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text('More Information', style: context.textTheme.titleLarge?.medium),
          ),
          DetailItem(title: 'Clouds', value: '${daily?.clouds} %', padding: 16),
          DetailItem(title: 'Dew Point', value: AppUtil.formatTempText(tempUnit, daily?.dewPoint), padding: 16),
          DetailItem(
            title: 'Gust',
            value: '${AppUtil.formatSpeed(speedUnit, daily?.windGust)} ${AppUtil.unitSpeed(speedUnit)}',
            padding: 16,
          ),
          DetailItem(title: 'Humidity', value: '${daily?.humidity} %', padding: 16),
          DetailItem(
            title: 'Pressure',
            value: '${AppUtil.formatPress(pressUnit, daily?.pressure)} ${AppUtil.unitPress(pressUnit)}',
            padding: 16,
          ),
          DetailItem(title: 'Rain', value: '${((daily?.pop ?? 0) * 100).round()} %', padding: 16),
          DetailItem(title: 'Rainfall', value: '${daily?.rain} mm', padding: 16),
          DetailItem(title: 'UV Index', value: '${daily?.uvi}', padding: 16),
          DetailItem(title: 'Wind Degree', value: '${daily?.windDeg}$degChar', padding: 16),
          DetailItem(
            title: 'Wind Speed',
            value: '${AppUtil.formatSpeed(speedUnit, daily?.windSpeed)} ${AppUtil.unitSpeed(speedUnit)}',
            padding: 16,
            showDivider: false,
          ),
          const Gap(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/01d.svg',
                              width: 42,
                              height: 42,
                              colorFilter: ColorFilter.mode(context.colorScheme.primary, BlendMode.srcATop),
                            ),
                            Text(
                              AppUtil.getTimesLong(daily?.sunrise ?? 0, daily?.sunset ?? 0),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ),
                      const Gap(8),
                      const Divider(height: 1, thickness: 1),
                      DetailItem(title: 'Sunrise', value: AppUtil.getFormatDT(daily?.sunrise, 'HH:mm')),
                      DetailItem(
                        title: 'Sunset',
                        value: AppUtil.getFormatDT(daily?.sunset, 'HH:mm'),
                        showDivider: false,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 120,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  color: context.colorScheme.onSurface,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/01n.svg',
                              width: 42,
                              height: 42,
                              colorFilter: ColorFilter.mode(context.colorScheme.primary, BlendMode.srcATop),
                            ),
                            Text(
                              AppUtil.getTimesLong(daily?.moonrise ?? 0, daily?.moonset ?? 0),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ),
                      const Gap(8),
                      const Divider(height: 1, thickness: 1),
                      DetailItem(title: 'Moonrise', value: AppUtil.getFormatDT(daily?.moonrise, 'HH:mm')),
                      DetailItem(
                        title: 'Moonset',
                        value: AppUtil.getFormatDT(daily?.moonset, 'HH:mm'),
                        showDivider: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
