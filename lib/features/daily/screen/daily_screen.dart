import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';
import 'package:weather_app_flutter/data/controllers/weather_controller.dart';
import 'package:weather_app_flutter/features/daily/widgets/daily_detail.dart';
import 'package:weather_app_flutter/routes/app_router.dart';
import 'package:weather_app_flutter/utils/app_util.dart';
import 'package:weather_app_flutter/utils/ext.dart';

class DailyScreen extends StatefulHookConsumerWidget {
  const DailyScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DailyScreenState();
}

class _DailyScreenState extends ConsumerState<DailyScreen> with SingleTickerProviderStateMixin {
  late final TabController tabController;
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 8, vsync: this);
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    final weatherRefreshState = ref.watch(weatherControllerProvider);
    final weatherState = ref.watch(weatherControllerProvider).value;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(onPressed: () => context.pop(), icon: Icon(LucideIcons.arrowLeft)),
        titleSpacing: 0,
        title: Text('Daily'),
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
          TabBar(
            controller: tabController,
            tabs: List.generate(
              weatherState?.daily?.length ?? 0,
              (index) => Tab(text: AppUtil.getFormatDT(weatherState?.daily?[index].dt, 'EEE, dd')),
            ),
            onTap: (value) =>
                pageController.animateToPage(value, duration: Duration(milliseconds: 300), curve: Curves.easeInOut),
            isScrollable: true,
            tabAlignment: TabAlignment.center,
            labelStyle: context.textTheme.titleMedium?.bold.clr(context.primary),
            unselectedLabelStyle: context.textTheme.bodyMedium,
            labelPadding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const BouncingScrollPhysics(),
          ),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              physics: const BouncingScrollPhysics(),
              itemCount: weatherState?.daily?.length ?? 0,
              itemBuilder: (context, index) => DailyDetail(daily: weatherState?.daily?[index]),
              onPageChanged: (value) => tabController.animateTo(value),
            ),
          ),
        ],
      ),
    );
  }
}
