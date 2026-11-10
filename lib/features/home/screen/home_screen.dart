import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';
import 'package:weather_app_flutter/data/controllers/aqi_controller.dart';
import 'package:weather_app_flutter/data/controllers/weather_controller.dart';
import 'package:weather_app_flutter/features/home/widgets/daily_item.dart';
import 'package:weather_app_flutter/features/settings/provider/settings_provider.dart';
import 'package:weather_app_flutter/features/widgets/temp_text.dart';
import 'package:weather_app_flutter/routes/app_router.dart';
import 'package:weather_app_flutter/utils/app_const.dart';
import 'package:weather_app_flutter/utils/app_util.dart';
import 'package:weather_app_flutter/utils/ext.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = EasyRefreshController(controlFinishRefresh: true);
    final weatherState = ref.watch(weatherControllerProvider);
    final aqiState = ref.watch(aqiControllerProvider).value;
    final city = ref.watch(settingsProvider.select((s) => s.city));
    final tempUnit = ref.watch(settingsProvider.select((s) => s.tempUnit));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: Icon(LucideIcons.locateFixed, size: 28),
        title: Text(city, maxLines: 2, overflow: .ellipsis),
        titleTextStyle: context.textTheme.titleMedium,
        titleSpacing: 0,
        actionsPadding: .only(right: 8),
        actions: [
          IconButton(onPressed: () => context.push(AppRoutes.SETTINGS), icon: Icon(LucideIcons.slidersHorizontal)),
        ],
      ),
      body: EasyRefresh(
        controller: controller,
        header: ClassicHeader(
          textStyle: context.textTheme.titleSmall?.clr(context.primary),
          messageStyle: context.textTheme.labelSmall,
        ),
        onRefresh: () async {
          await ref.read(weatherControllerProvider.notifier).refresh();
          await ref.read(aqiControllerProvider.notifier).refresh();
          await ref.read(aqiForecastControllerProvider.notifier).refresh();
          controller.finishRefresh();
        },
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: weatherState.when(
                data: (data) => Column(
                  children: [
                    Padding(
                      padding: .only(left: 20, top: 16, bottom: 10),
                      child: Row(
                        crossAxisAlignment: .start,
                        spacing: 12,
                        children: [
                          Text(
                            AppUtil.formatTemp(tempUnit, data.current?.temp),
                            style: context.textTheme.bodyMedium?.custom(size: 90, height: .9),
                          ),
                          TempText(unit: tempUnit, style: context.textTheme.headlineMedium),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Gap(26),
                        Material(
                          clipBehavior: .hardEdge,
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: AppUtil.getAqiColor(context, aqiState?.list?[0].main?.aqi ?? 0)),
                            borderRadius: .circular(20),
                          ),
                          child: InkWell(
                            onTap: () => context.push(AppRoutes.AQI),
                            child: Padding(
                              padding: const .symmetric(horizontal: 10, vertical: 8),
                              child: Row(
                                mainAxisSize: .min,
                                children: [
                                  Icon(
                                    LucideIcons.leaf,
                                    size: 18,
                                    color: AppUtil.getAqiColor(context, aqiState?.list?[0].main?.aqi ?? 0),
                                  ),
                                  const Gap(10),
                                  Text('AQI  ${aqiState?.list?[0].main?.aqi} ', style: context.textTheme.titleMedium),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Gap(8),
                        IconButton.outlined(
                          onPressed: () => context.push(AppRoutes.HOURLY),
                          icon: Icon(LucideIcons.clock, color: context.colorScheme.primary),
                        ),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        const Gap(26),
                        Text('Source:', style: context.textTheme.labelMedium),
                        const Gap(10),
                        Image.asset(owm, height: 20, color: context.onSurface),
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: SvgPicture.asset(
                          AppUtil.getWeatherIcon(data.current?.weather?[0].icon),
                          width: context.width / 1.5,
                          height: context.width / 1.5,
                          colorFilter: .mode(context.primary, .srcATop),
                          fit: .cover,
                        ),
                      ),
                    ),
                    Text(
                      AppUtil.getWeatherCondition(data.current?.weather?[0].id ?? 0).toUpperCase(),
                      style: context.textTheme.headlineMedium?.bold.clr(context.primary),
                    ),
                    Padding(
                      padding: const .symmetric(horizontal: 16),
                      child: Text(AppUtil.getWeatherDescription(data.current?.weather?[0].id ?? 0), textAlign: .center),
                    ),
                    Gap(16),
                    Text(
                      'Last update: ${AppUtil.getFormatDT(data.current?.dt, 'EEEE, dd/MM/yy HH:mm')}',
                      style: context.textTheme.labelSmall,
                    ),
                    const Gap(30),
                    OutlinedButton(
                      onPressed: () => context.push(AppRoutes.DAILY),
                      child: Text('See All', style: context.textTheme.bodyMedium?.clr(context.primary)),
                    ),
                    const Gap(26),
                    Padding(
                      padding: const .symmetric(horizontal: 26),
                      child: Row(
                        mainAxisAlignment: .spaceBetween,
                        children: List.generate(5, (index) => DailyItem(daily: data.daily?[index])),
                      ),
                    ),
                    Gap(context.paddingBottom + 16),
                  ],
                ),
                error: (_, e) => Column(
                  mainAxisAlignment: .center,
                  spacing: 16,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/null.svg',
                      width: 120,
                      height: 120,
                      colorFilter: .mode(context.colorScheme.error, .srcATop),
                    ),
                    Text('Can\'t get weather data.'),
                    Padding(
                      padding: const .all(16),
                      child: Text(e.toString(), style: context.textTheme.labelSmall, maxLines: 10, overflow: .ellipsis),
                    ),
                  ],
                ),
                loading: () => Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
