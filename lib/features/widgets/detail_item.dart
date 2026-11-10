import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_ui/material_ui.dart';
import 'package:weather_app_flutter/utils/ext.dart';

class DetailItem extends ConsumerWidget {
  const DetailItem({super.key, required this.title, required this.value, this.showDivider = true, this.padding});
  final String title, value;
  final bool showDivider;
  final double? padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding ?? 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(8),
          Row(
            children: [
              const Gap(12),
              Text(title, style: context.textTheme.bodyMedium?.semiBold),
              const Spacer(),
              Text(value),
              const Gap(12),
            ],
          ),
          const Gap(8),
          showDivider ? const Divider(height: 1, thickness: 1) : Container(),
        ],
      ),
    );
  }
}
