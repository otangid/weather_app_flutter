import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_flutter/features/settings/model/settings.dart';
import 'package:weather_app_flutter/providers/shared_preferences_provider.dart';

part 'settings_provider.g.dart';

class SettingsKey {
  static const latKey = 'pref_lat';
  static const lonKey = 'pref_lon';
  static const cityKey = 'pref_city';
  static const apiKey = 'pref_apikey';
  static const oneCallKey = 'pref_one_call';
  static const aqiKey = 'pref_aqi';
  static const aqiForecastKey = 'pref_aqi_forecast';
  static const tempKey = 'pref_temp';
  static const speedKey = 'pref_speed';
  static const pressKey = 'pref_press';
  static const distKey = 'pref_dist';
  static const themeModeKey = 'pref_theme_mode';
  static const cacheIntKey = 'pref_cache_int';
}

@riverpod
class Settings extends _$Settings {
  late final SharedPreferences preferences;
  @override
  Setting build() {
    preferences = ref.watch(sharedPreferencesProvider);
    return Setting(
      lat: preferences.getDouble(SettingsKey.latKey) ?? 0.0,
      lon: preferences.getDouble(SettingsKey.lonKey) ?? 0.0,
      city: preferences.getString(SettingsKey.cityKey) ?? '-, -',
      apiKey: preferences.getString(SettingsKey.apiKey) ?? '',
      tempUnit: preferences.getInt(SettingsKey.tempKey) ?? 0,
      speedUnit: preferences.getInt(SettingsKey.tempKey) ?? 0,
      distUnit: preferences.getInt(SettingsKey.tempKey) ?? 0,
      pressUnit: preferences.getInt(SettingsKey.tempKey) ?? 0,
      themeMode: preferences.getInt(SettingsKey.themeModeKey) ?? 0,
      cacheInterval: preferences.getInt(SettingsKey.cacheIntKey) ?? 15,
    );
  }

  Future<void> setLat(double value) async {
    await preferences.setDouble(SettingsKey.latKey, value);
    state = state.copyWith(lat: value);
  }

  Future<void> setLon(double value) async {
    await preferences.setDouble(SettingsKey.lonKey, value);
    state = state.copyWith(lon: value);
  }

  Future<void> setCity(String value) async {
    await preferences.setString(SettingsKey.cityKey, value);
    state = state.copyWith(city: value);
  }

  Future<void> setApiKey(String value) async {
    await preferences.setString(SettingsKey.apiKey, value);
    state = state.copyWith(apiKey: value);
  }

  Future<void> setTempUnit(int value) async {
    await preferences.setInt(SettingsKey.tempKey, value);
    state = state.copyWith(tempUnit: value);
  }

  Future<void> setSpeedUnit(int value) async {
    await preferences.setInt(SettingsKey.speedKey, value);
    state = state.copyWith(speedUnit: value);
  }

  Future<void> setPressUnit(int value) async {
    await preferences.setInt(SettingsKey.pressKey, value);
    state = state.copyWith(pressUnit: value);
  }

  Future<void> setDistUnit(int value) async {
    await preferences.setInt(SettingsKey.distKey, value);
    state = state.copyWith(distUnit: value);
  }

  Future<void> setThemeMode(int value) async {
    await preferences.setInt(SettingsKey.themeModeKey, value);
    state = state.copyWith(themeMode: value);
  }

  Future<void> setCacheInterval(int value) async {
    await preferences.setInt(SettingsKey.cacheIntKey, value);
    state = state.copyWith(cacheInterval: value);
  }

  Future<void> clearCache() async {
    await preferences.remove(SettingsKey.aqiKey);
    await preferences.remove(SettingsKey.aqiForecastKey);
    await preferences.remove(SettingsKey.oneCallKey);
  }
}
