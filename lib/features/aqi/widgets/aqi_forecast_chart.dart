import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_app_flutter/data/models/aqi/data.dart';
import 'package:weather_app_flutter/utils/app_const.dart';
import 'package:weather_app_flutter/utils/app_util.dart';
import 'package:weather_app_flutter/utils/ext.dart';

class AqiForecastChart extends StatelessWidget {
  const AqiForecastChart({super.key, required this.list});
  final List<Data> list;

  DateTime _time(Data d) => DateTime.fromMillisecondsSinceEpoch((d.dt ?? 0) * 1000);

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) return const SizedBox.shrink();

    // Indeks jam terakhir yang <= sekarang
    final now = DateTime.now();
    var start = list.lastIndexWhere((d) => !_time(d).isAfter(now));
    if (start < 0) start = 0;
    final end = (start + 11).clamp(0, list.length - 1);

    return Container(
      height: 240,
      margin: .symmetric(horizontal: 8),
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        title: ChartTitle(text: 'AQI Forecast', alignment: .center, textStyle: context.textTheme.titleMedium),
        zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
        primaryXAxis: DateTimeCategoryAxis(
          dateFormat: DateFormat('HH:mm'),
          intervalType: .hours,
          interval: 2,
          labelStyle: context.textTheme.labelSmall,
          initialVisibleMinimum: _time(list[start]),
          initialVisibleMaximum: _time(list[end]),
          majorGridLines: const MajorGridLines(width: 0),
          majorTickLines: MajorTickLines(size: 2, color: context.primary),
          axisLine: const AxisLine(),
          plotOffset: 2,
        ),
        primaryYAxis: NumericAxis(
          isVisible: true,
          minimum: 0,
          maximum: 6,
          interval: 2,
          labelStyle: context.textTheme.labelSmall,
          majorGridLines: const MajorGridLines(width: 0),
          majorTickLines: MajorTickLines(size: 2, color: context.primary),
          axisLine: const AxisLine(),
          plotOffset: 4,
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          color: context.primary,
          duration: 1500,
          builder: (data, point, series, pointIndex, seriesIndex) {
            final d = data as Data;
            final aqi = (d.main?.aqi ?? 1).clamp(1, 5);
            return Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                '${DateFormat('dd/MM HH:mm').format(_time(d))} · ${aqiLabels[aqi - 1]}',
                style: context.textTheme.labelSmall?.clr(context.onPrimary),
              ),
            );
          },
        ),
        series: [
          ColumnSeries<Data, DateTime>(
            dataSource: list,
            xValueMapper: (d, _) => _time(d),
            yValueMapper: (d, _) => d.main?.aqi ?? 0,
            pointColorMapper: (d, _) => AppUtil.getAqiColor(context, d.main?.aqi ?? 0),
            width: .7,
            spacing: 0,
            isTrackVisible: true,
            trackPadding: 0,
            trackColor: context.onSurface.withValues(alpha: .25),
            borderRadius: .circular(8),
            animationDuration: 600,
          ),
        ],
      ),
    );
  }
}
