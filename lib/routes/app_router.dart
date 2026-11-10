import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app_flutter/features/aqi/screen/aqi_screen.dart';
import 'package:weather_app_flutter/features/daily/screen/daily_screen.dart';
import 'package:weather_app_flutter/features/home/screen/home_screen.dart';
import 'package:weather_app_flutter/features/hourly/screen/hourly_screen.dart';
import 'package:weather_app_flutter/features/settings/screen/settings_screen.dart';

part 'app_router.g.dart';

class AppRoutes {
  static const HOME = '/';
  static const SETTINGS = 'settings';
  static const HOURLY = 'hourly';
  static const DAILY = 'daily';
  static const AQI = 'aqi';
}

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.HOME,
    routes: [
      GoRoute(
        path: AppRoutes.HOME,
        builder: (context, state) => HomeScreen(),
        routes: [
          GoRoute(path: AppRoutes.AQI, name: AppRoutes.AQI, builder: (context, state) => AqiScreen()),
          GoRoute(path: AppRoutes.DAILY, name: AppRoutes.DAILY, builder: (context, state) => DailyScreen()),
          GoRoute(path: AppRoutes.HOURLY, name: AppRoutes.HOURLY, builder: (context, state) => HourlyScreen()),
          GoRoute(path: AppRoutes.SETTINGS, name: AppRoutes.SETTINGS, builder: (context, state) => SettingsScreen()),
        ],
      ),
    ],
  );
}
