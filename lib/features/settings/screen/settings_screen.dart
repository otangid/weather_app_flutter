import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';
import 'package:weather_app_flutter/data/controllers/aqi_controller.dart';
import 'package:weather_app_flutter/data/controllers/weather_controller.dart';
import 'package:weather_app_flutter/features/settings/provider/settings_provider.dart';
import 'package:weather_app_flutter/features/settings/widgets/location.dart';
import 'package:weather_app_flutter/features/settings/widgets/pref.dart';
import 'package:weather_app_flutter/features/settings/widgets/pref_apikey.dart';
import 'package:weather_app_flutter/features/settings/widgets/pref_category.dart';
import 'package:weather_app_flutter/features/settings/widgets/pref_list.dart';
import 'package:weather_app_flutter/providers/snackbar_provider.dart';
import 'package:weather_app_flutter/utils/app_const.dart';
import 'package:weather_app_flutter/utils/ext.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiKey = ref.watch(settingsProvider.select((s) => s.apiKey));
    final city = ref.watch(settingsProvider.select((s) => s.city));
    final lat = ref.watch(settingsProvider.select((s) => s.lat));
    final lon = ref.watch(settingsProvider.select((s) => s.lon));
    final tempUnit = ref.watch(settingsProvider.select((s) => s.tempUnit));
    final distUnit = ref.watch(settingsProvider.select((s) => s.distUnit));
    final speedUnit = ref.watch(settingsProvider.select((s) => s.speedUnit));
    final pressUnit = ref.watch(settingsProvider.select((s) => s.pressUnit));
    final themeMode = ref.watch(settingsProvider.select((s) => s.themeMode));
    final cacheInterval = ref.watch(settingsProvider.select((s) => s.cacheInterval));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(onPressed: () => context.pop(), icon: Icon(LucideIcons.arrowLeft)),
        titleSpacing: 0,
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .center,
          children: [
            PrefCategory(
              title: 'Theme',
              children: [
                PrefList(
                  title: 'Theme Mode',
                  icon: LucideIcons.palette,
                  value: themeMode,
                  entries: themeModeL,
                  entryValues: themeModeValueL,
                  onSelected: (value) async {
                    await ref.read(settingsProvider.notifier).setThemeMode(value);
                  },
                ),
              ],
            ),
            PrefCategory(
              title: 'Location',
              children: [
                Pref(
                  title: 'Update Location',
                  subTitle: city,
                  icon: LucideIcons.mapPin,
                  onTap: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    showDragHandle: true,
                    builder: (context) => Padding(
                      padding: .only(left: 16, right: 16, bottom: context.paddingBottom + 16),
                      child: Location(
                        defCity: city,
                        defLat: lat,
                        devLon: lon,
                        onSaved: (city, lat, lon) async {
                          await ref.read(settingsProvider.notifier).setCity(city);
                          await ref.read(settingsProvider.notifier).setLat(lat);
                          await ref.read(settingsProvider.notifier).setLon(lon);
                          ref.read(uiSnackbarProvider.notifier).show('Location updated.');
                          await ref.read(weatherControllerProvider.notifier).refresh();
                          await ref.read(aqiControllerProvider.notifier).refresh();
                          await ref.read(aqiForecastControllerProvider.notifier).refresh();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            PrefCategory(
              title: 'Weather',
              children: [
                PrefApikey(value: apiKey),
                Divider(height: 1, indent: 46),
                PrefList(
                  title: 'Cache Interval',
                  icon: LucideIcons.hourglass,
                  value: cacheInterval,
                  entries: cacheIntL,
                  entryValues: cacheIntValueL,
                  onSelected: (value) async {
                    ref.read(settingsProvider.notifier).setCacheInterval(value);
                  },
                ),
                Divider(height: 1, indent: 46),
                Pref(
                  title: 'Cache',
                  subTitle: 'Clear cache',
                  icon: LucideIcons.databaseX,
                  onTap: () async {
                    await ref.read(settingsProvider.notifier).clearCache();
                    ref.read(uiSnackbarProvider.notifier).show('Cache cleared.');
                  },
                ),
              ],
            ),
            PrefCategory(
              title: 'Units',
              children: [
                PrefList(
                  title: 'Temperature',
                  icon: LucideIcons.thermometer,
                  value: tempUnit,
                  entries: tempUnitL,
                  entryValues: tempUnitValueL,
                  onSelected: (value) {
                    ref.read(settingsProvider.notifier).setTempUnit(value);
                  },
                ),
                Divider(height: 1, indent: 46),
                PrefList(
                  title: 'Distance',
                  icon: LucideIcons.ruler,
                  value: distUnit,
                  entries: distUnitL,
                  entryValues: distUnitValueL,
                  onSelected: (value) {
                    ref.read(settingsProvider.notifier).setDistUnit(value);
                  },
                ),
                Divider(height: 1, indent: 46),
                PrefList(
                  title: 'Speed',
                  icon: LucideIcons.gaugeCircle,
                  value: speedUnit,
                  entries: speedUnitL,
                  entryValues: speedUnitValueL,
                  onSelected: (value) {
                    ref.read(settingsProvider.notifier).setSpeedUnit(value);
                  },
                ),
                Divider(height: 1, indent: 46),
                PrefList(
                  title: 'Pressure',
                  icon: LucideIcons.gauge,
                  value: pressUnit,
                  entries: pressUnitL,
                  entryValues: pressUnitValueL,
                  onSelected: (value) {
                    ref.read(settingsProvider.notifier).setPressUnit(value);
                  },
                ),
              ],
            ),
            PrefCategory(
              title: 'App',
              children: [
                Pref(title: 'Version', subTitle: '1.0', icon: LucideIcons.code, onTap: () {}),
                Divider(height: 1, indent: 46),
                Pref(title: 'About', subTitle: 'Application info', icon: LucideIcons.badgeInfo, onTap: () {}),
                Divider(height: 1, indent: 46),
                Pref(title: 'Open Weather', subTitle: 'Visit openweathermap.org', icon: LucideIcons.link, onTap: () {}),
              ],
            ),
            Padding(
              padding: .symmetric(vertical: 120),
              child: SvgPicture.asset(
                owmLogo,
                height: 36,
                colorFilter: .mode(context.colorScheme.onSurface.withValues(alpha: .25), .srcIn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
