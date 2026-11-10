import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app_flutter/utils/app_util.dart';
import 'package:weather_app_flutter/utils/ext.dart';

class HomeShimmer extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.onSurface,
      highlightColor: context.primary.withValues(alpha: .5),
      period: Duration(milliseconds: 1000),
      child: Column(
        children: [
          Padding(
            padding: .only(left: 20, top: 16, bottom: 10),
            child: Row(
              crossAxisAlignment: .start,
              spacing: 12,
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: .circular(16)),
                  child: Text('AA', style: context.textTheme.bodyMedium?.custom(size: 90, height: .9)),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: .circular(8)),
                  child: Text('AA', style: context.textTheme.headlineMedium),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Gap(26),
              Material(
                clipBehavior: .hardEdge,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white),
                  borderRadius: .circular(20),
                ),
                child: Padding(
                  padding: const .symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    mainAxisSize: .min,
                    children: [
                      Icon(LucideIcons.leaf, size: 18, color: Colors.white),
                      const Gap(10),
                      Text('AQI  0 ', style: context.textTheme.titleMedium),
                    ],
                  ),
                ),
              ),
              const Gap(8),
              IconButton.filled(
                onPressed: () {},
                icon: Icon(LucideIcons.clock, color: Colors.white),
              ),
            ],
          ),
          const Gap(10),
          Row(
            children: [
              const Gap(26),
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: .circular(4)),
                child: Text('Source:', style: context.textTheme.labelMedium),
              ),
              const Gap(10),
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: .circular(16)),
                height: 20,
                width: 20,
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Container(
                width: context.width / 1.5,
                height: context.width / 1.5,
                decoration: BoxDecoration(color: Colors.white, borderRadius: .circular(500)),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: .circular(16)),
            child: Text(AppUtil.getWeatherCondition(0).toUpperCase(), style: context.textTheme.headlineMedium?.bold),
          ),
          Container(
            margin: .only(top: 4),
            padding: const .symmetric(horizontal: 16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: .circular(16)),
            child: Text(AppUtil.getWeatherDescription(0), textAlign: .center),
          ),
          Gap(16),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: .circular(16)),
            child: Text(
              'Last update: ${AppUtil.getFormatDT(null, 'EEEE, dd/MM/yy HH:mm')}',
              style: context.textTheme.labelSmall,
            ),
          ),
          const Gap(30),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: .circular(24)),
            child: OutlinedButton(
              onPressed: () {},
              child: Text('See All', style: context.textTheme.bodyMedium),
            ),
          ),
          const Gap(26),
          Padding(
            padding: const .symmetric(horizontal: 26),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: List.generate(
                5,
                (index) => Column(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: .circular(8)),
                    ),
                    Container(
                      margin: .only(top: 4),
                      width: 32,
                      height: 12,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: .circular(4)),
                    ),
                    Container(
                      width: 42,
                      margin: .only(top: 8),
                      padding: const .symmetric(horizontal: 5, vertical: 3),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary.withValues(alpha: .75),
                        borderRadius: .circular(6),
                      ),
                      child: Text('', style: context.textTheme.bodySmall),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Gap(context.paddingBottom + 16),
        ],
      ),
    );
  }
}
