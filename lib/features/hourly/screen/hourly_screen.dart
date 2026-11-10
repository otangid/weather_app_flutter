import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';
import 'package:weather_app_flutter/data/controllers/weather_controller.dart';
import 'package:weather_app_flutter/features/hourly/widgets/hourly_item.dart';
import 'package:weather_app_flutter/routes/app_router.dart';
import 'package:weather_app_flutter/utils/ext.dart';

class HourlyScreen extends ConsumerWidget {
  const HourlyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherRefreshState = ref.watch(weatherControllerProvider);
    final weatherState = ref.watch(weatherControllerProvider).value;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(onPressed: () => context.pop(), icon: Icon(LucideIcons.arrowLeft)),
        titleSpacing: 0,
        title: Text('Hourly'),
        actionsPadding: .only(right: 8),
        actions: [
          IconButton(
            onPressed: () => ref.read(weatherControllerProvider.notifier).refresh(),
            icon: Icon(LucideIcons.refreshCw),
          ),
          IconButton(onPressed: () => context.push(AppRoutes.SETTINGS), icon: Icon(LucideIcons.slidersHorizontal)),
        ],
      ),
      body: Column(
        children: [
          Visibility(
            visible: weatherRefreshState.when(data: (_) => false, error: (_, _) => false, loading: () => true),
            child: LinearProgressIndicator(),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: weatherState?.hourly?.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) => HourlyItem(index: index, hourly: weatherState?.hourly?[index]),
              padding: .fromLTRB(16, 10, 16, context.paddingBottom + 16),
              physics: const BouncingScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}
