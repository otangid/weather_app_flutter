import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:weather_app_flutter/utils/ext.dart';

class PrefCategory extends ConsumerWidget {
  const PrefCategory({super.key, required this.title, required this.children});
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: .symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: .only(left: 8),
            child: Text(title, style: context.textTheme.titleMedium),
          ),
          Container(
            margin: .only(top: 10),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainer.withValues(alpha: .5),
              borderRadius: .circular(16),
            ),
            clipBehavior: .hardEdge,
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}
