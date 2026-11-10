import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';
import 'package:weather_app_flutter/utils/ext.dart';

class PrefList extends ConsumerWidget {
  const PrefList({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
    required this.entries,
    required this.entryValues,
    required this.onSelected,
  });
  final String title;
  final IconData icon;
  final int value;
  final List<String> entries;
  final List<int> entryValues;
  final Function(int value) onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
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
                  Text(title, style: context.textTheme.headlineSmall),
                  Gap(16),
                  Material(
                    color: context.colorScheme.surface,
                    borderRadius: .circular(16),
                    clipBehavior: .hardEdge,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: .zero,
                      itemCount: entries.length,
                      itemBuilder: (context, index) {
                        final fgColor = value == entryValues[index]
                            ? context.colorScheme.primary
                            : context.colorScheme.onSurface;
                        return Material(
                          color: context.colorScheme.surface,
                          child: InkWell(
                            onTap: () {
                              onSelected(entryValues[index]);
                              context.pop();
                            },
                            child: Padding(
                              padding: .symmetric(horizontal: 16, vertical: 8),
                              child: Row(
                                spacing: 16,
                                children: [
                                  Icon(
                                    value == entryValues[index] ? LucideIcons.checkCircle : LucideIcons.circle,
                                    size: 18,
                                    color: fgColor,
                                  ),
                                  Text(entries[index], style: context.textTheme.titleMedium),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(height: 1, indent: 42),
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
        },
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
                  Text(entries[entryValues.indexOf(value)], style: context.textTheme.labelMedium),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
