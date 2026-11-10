import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';
import 'package:weather_app_flutter/data/controllers/aqi_controller.dart';
import 'package:weather_app_flutter/data/controllers/weather_controller.dart';
import 'package:weather_app_flutter/features/settings/provider/settings_provider.dart';
import 'package:weather_app_flutter/utils/app_util.dart';
import 'package:weather_app_flutter/utils/ext.dart';

class PrefApikey extends ConsumerWidget {
  const PrefApikey({super.key, required this.value});
  final String value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: .symmetric(horizontal: 16, vertical: 8),
        child: Row(
          spacing: 16,
          children: [
            Icon(LucideIcons.key, size: 22, color: context.colorScheme.primary),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text('ApiKey', style: context.textTheme.titleMedium),
                  Text(AppUtil.maskApiKey(value), style: context.textTheme.labelMedium),
                ],
              ),
            ),
            IconButton(
              onPressed: () => showApiKeyDialog(context, value, (key) async {
                await ref.read(settingsProvider.notifier).setApiKey(key);
                await ref.read(weatherControllerProvider.notifier).refresh();
                await ref.read(aqiControllerProvider.notifier).refresh();
                await ref.read(aqiForecastControllerProvider.notifier).refresh();
              }),
              icon: Icon(LucideIcons.pencil),
              iconSize: 18,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showApiKeyDialog(BuildContext context, String current, ValueChanged<String> onSave) {
    final controller = TextEditingController(text: current);

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: .symmetric(horizontal: 16),
        title: const Text('API Key'),
        content: SizedBox(
          width: double.maxFinite,
          child: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(border: OutlineInputBorder(borderRadius: .all(.circular(16)))),
          ),
        ),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              final key = controller.text.trim();
              if (key.isNotEmpty) onSave(key);
              context.pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
