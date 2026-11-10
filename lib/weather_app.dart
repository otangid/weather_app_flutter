import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:weather_app_flutter/features/settings/provider/settings_provider.dart';
import 'package:weather_app_flutter/providers/snackbar_provider.dart';
import 'package:weather_app_flutter/routes/app_router.dart';
import 'package:weather_app_flutter/theme/app_theme.dart';
import 'package:weather_app_flutter/utils/app_const.dart';
import 'package:weather_app_flutter/utils/app_util.dart';
import 'package:weather_app_flutter/utils/ext.dart';

class WeatherApp extends ConsumerWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messengerKey = GlobalKey<ScaffoldMessengerState>();
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(settingsProvider.select((s) => s.themeMode));
    ref.listen(uiSnackbarProvider, (_, msg) {
      if (msg == null) return;
      messengerKey.currentState
        ?..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(msg.text)));
    });
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: buildTheme(lightColorScheme),
      darkTheme: buildTheme(darkColorScheme),
      themeMode: AppUtil.getThemeMode(themeMode),
      routerConfig: router,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      scaffoldMessengerKey: messengerKey,
      builder: (context, child) => Stack(
        fit: .expand,
        children: [
          Image.asset(context.colorScheme.brightness == .dark ? bgDark : bgLight, fit: .cover),
          ?child,
        ],
      ),
    );
  }
}
