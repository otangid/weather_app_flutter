import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:weather_app_flutter/utils/ext.dart';

class Pref extends ConsumerWidget {
  const Pref({super.key, required this.title, required this.subTitle, required this.icon, required this.onTap});
  final String title;
  final String subTitle;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: .symmetric(horizontal: 16, vertical: 8),
          child: Row(
            spacing: 16,
            children: [
              Icon(icon, size: 22, color: context.colorScheme.primary),
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text(title, style: context.textTheme.titleMedium),
                  Text(subTitle, style: context.textTheme.labelMedium),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
