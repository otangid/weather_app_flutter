import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weather_app_flutter/utils/app_const.dart';
import 'package:weather_app_flutter/utils/ext.dart';

class Particles extends ConsumerWidget {
  const Particles({
    super.key,
    required this.component,
    required this.name,
    required this.desc,
    required this.value,
    required this.size,
  });
  final String component, name, desc;
  final double value, size;

  double? aqiGaugeMax(String component) {
    final last = limits[component]?.last;
    return last == null ? null : last * 1.25;
  }

  int? aqiLevel(String component, double value) {
    final limit = limits[component];
    if (limit == null) return null;
    for (var i = 0; i < limit.length; i++) {
      if (value < limit[i]) return i + 1;
    }
    return 5;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = aqiLevel(component, value);
    final max = aqiGaugeMax(component) ?? refMax[component] ?? (value > 0 ? value * 1.25 : 1.0);
    final color = level == null ? context.primary : aqiColors[level - 1];

    return GestureDetector(
      onTap: () => desc.isNotEmpty
          ? showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              showDragHandle: true,
              builder: (context) => Padding(
                padding: .only(left: 16, right: 16, bottom: context.paddingBottom + 16),
                child: Column(
                  mainAxisSize: .min,
                  children: [
                    Text(name, style: context.textTheme.headlineSmall),
                    Container(
                      margin: .only(top: 16),
                      padding: .all(16),
                      decoration: BoxDecoration(color: context.surface, borderRadius: .circular(16)),
                      child: Text(desc),
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
            )
          : null,
      child: SizedBox(
        width: size * 3 / 2,
        height: size,
        child: SfRadialGauge(
          enableLoadingAnimation: true,
          axes: [
            RadialAxis(
              showLabels: false,
              showTicks: false,
              maximum: max,
              axisLineStyle: AxisLineStyle(
                cornerStyle: .bothCurve,
                thickness: 10,
                color: context.onSurface.withValues(alpha: .25),
              ),
              annotations: [
                GaugeAnnotation(
                  angle: 90,
                  widget: Text(value.toStringAsFixed(1), style: context.textTheme.titleMedium?.bold),
                ),
                GaugeAnnotation(angle: 90, positionFactor: 1.01, widget: Text(component.toUpperCase())),
              ],
              pointers: [
                RangePointer(value: value.clamp(0.0, max).toDouble(), width: 10, cornerStyle: .bothCurve, color: color),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
