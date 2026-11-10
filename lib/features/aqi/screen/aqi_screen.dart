import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weather_app_flutter/data/controllers/aqi_controller.dart';
import 'package:weather_app_flutter/features/aqi/widgets/aqi_forecast_chart.dart';
import 'package:weather_app_flutter/features/aqi/widgets/particles.dart';
import 'package:weather_app_flutter/routes/app_router.dart';
import 'package:weather_app_flutter/utils/app_const.dart';
import 'package:weather_app_flutter/utils/app_util.dart';
import 'package:weather_app_flutter/utils/ext.dart';

class AqiScreen extends ConsumerWidget {
  const AqiScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aqiRefreshState = ref.watch(aqiForecastControllerProvider);
    final aqiState = ref.watch(aqiControllerProvider).value;
    final aqiForecastState = ref.watch(aqiForecastControllerProvider).value;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(onPressed: () => context.pop(), icon: Icon(LucideIcons.arrowLeft)),
        titleSpacing: 0,
        title: Text('Air Quality'),
        actionsPadding: .only(right: 8),
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(aqiForecastControllerProvider.notifier).refresh();
              await ref.read(aqiControllerProvider.notifier).refresh();
            },
            icon: Icon(LucideIcons.refreshCw),
          ),
          IconButton(onPressed: () => context.push(AppRoutes.SETTINGS), icon: Icon(LucideIcons.slidersHorizontal)),
        ],
      ),
      body: SingleChildScrollView(
        padding: .only(bottom: context.paddingBottom + 16),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Visibility(
              visible: aqiRefreshState.when(data: (_) => false, error: (_, _) => false, loading: () => true),
              child: LinearProgressIndicator(),
            ),
            Container(
              margin: const .symmetric(horizontal: 16, vertical: 8),
              padding: const .all(16),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: .circular(25),
                border: Border(
                  right: BorderSide(width: 8, color: context.colorScheme.primary),
                  bottom: BorderSide(width: 8, color: context.colorScheme.primary),
                ),
              ),
              child: Row(
                crossAxisAlignment: .start,
                spacing: 16,
                children: [
                  SizedBox(
                    width: 86,
                    height: 86,
                    child: SfRadialGauge(
                      enableLoadingAnimation: true,
                      axes: [
                        RadialAxis(
                          showLabels: false,
                          showTicks: false,
                          maximum: 5,
                          axisLineStyle: AxisLineStyle(
                            cornerStyle: .bothCurve,
                            thickness: 10,
                            color: context.colorScheme.onSurface.withValues(alpha: .25),
                          ),
                          annotations: [
                            GaugeAnnotation(
                              angle: 90,
                              widget: Text(
                                '${aqiState?.list?[0].main?.aqi ?? 0}/5',
                                style: context.textTheme.titleMedium?.bold,
                              ),
                            ),
                            GaugeAnnotation(angle: 90, positionFactor: 1.0, widget: Text('AQI')),
                          ],
                          pointers: [
                            RangePointer(
                              value: aqiState?.list?[0].main?.aqi?.toDouble() ?? 0,
                              width: 10,
                              cornerStyle: .bothCurve,
                              color: AppUtil.getAqiColor(context, aqiState?.list?[0].main?.aqi ?? 0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          AppUtil.getAqiTitle(aqiState?.list?[0].main?.aqi ?? 0),
                          style: context.textTheme.titleMedium?.bold.clr(
                            AppUtil.getAqiColor(context, aqiState?.list?[0].main?.aqi ?? 0),
                          ),
                        ),
                        Text(
                          AppUtil.getAqiInfo(aqiState?.list?[0].main?.aqi ?? 0),
                          style: context.textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const .symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Text('Good'),
                  const Gap(16),
                  Expanded(
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: aqiColor1,
                        borderRadius: .horizontal(left: .circular(10)),
                      ),
                    ),
                  ),
                  Expanded(child: Container(width: 18, height: 18, color: aqiColor2)),
                  Expanded(child: Container(width: 18, height: 18, color: aqiColor3)),
                  Expanded(child: Container(width: 18, height: 18, color: aqiColor4)),
                  Expanded(
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: aqiColor5,
                        borderRadius: .horizontal(right: .circular(10)),
                      ),
                    ),
                  ),
                  const Gap(16),
                  Text('Poor'),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Particles(
                  component: 'so2',
                  name: 'Sulphur Dioxide',
                  desc: SO2,
                  value: aqiState?.list?[0].components?.so2 ?? 0,
                  size: 85,
                ),
                Particles(
                  component: 'no2',
                  name: 'Nitrogen Dioxide',
                  desc: NO2,
                  value: aqiState?.list?[0].components?.no2 ?? 0,
                  size: 85,
                ),
                Particles(
                  component: 'pm10',
                  name: 'Coarse Particles',
                  desc: PM10,
                  value: aqiState?.list?[0].components?.pm10 ?? 0,
                  size: 85,
                ),
              ],
            ),
            const Gap(26),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Particles(
                  component: 'pm2.5',
                  name: 'Fine Particles',
                  desc: PM25,
                  value: aqiState?.list?[0].components?.pm25 ?? 0,
                  size: 85,
                ),
                Particles(
                  component: 'o3',
                  name: 'Ozone',
                  desc: O3,
                  value: aqiState?.list?[0].components?.o3 ?? 0,
                  size: 85,
                ),
                Particles(
                  component: 'co',
                  name: 'Carbon Monoxide',
                  desc: CO,
                  value: aqiState?.list?[0].components?.co ?? 0,
                  size: 85,
                ),
              ],
            ),
            const Gap(26),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Particles(
                  component: 'nh3',
                  name: 'Ammonia',
                  desc: NH3,
                  value: aqiState?.list?[0].components?.nh3 ?? 0,
                  size: 85,
                ),
                Stack(
                  alignment: .center,
                  children: [
                    Opacity(
                      opacity: 0,
                      child: Particles(component: '', name: '', desc: '', value: 0, size: 85),
                    ),
                    Container(
                      margin: .only(top: 16, bottom: 24),
                      padding: const .symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: context.colorScheme.primary, borderRadius: .circular(25)),
                      child: Text(
                        'All in μg/m3',
                        style: context.textTheme.labelMedium?.clr(context.colorScheme.onPrimary),
                      ),
                    ),
                  ],
                ),
                Particles(
                  component: 'no',
                  name: 'Nitrogen Monoxide',
                  desc: NO,
                  value: aqiState?.list?[0].components?.no ?? 0,
                  size: 85,
                ),
              ],
            ),
            const Gap(30),
            aqiForecastState?.list?.let((list) => AqiForecastChart(list: list)) ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
