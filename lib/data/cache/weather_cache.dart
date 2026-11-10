import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_flutter/data/models/aqi/aqi_response.dart';
import 'package:weather_app_flutter/data/models/one_call/one_call_response.dart';
import 'package:weather_app_flutter/features/settings/provider/settings_provider.dart';

class WeatherCache {
  final SharedPreferences _preferences;
  WeatherCache({required this._preferences});

  ({AqiResponse aqi, DateTime savedAt})? readAQI() {
    final raw = _preferences.getString(SettingsKey.aqiKey);
    if (raw == null) return null;
    final data = jsonDecode(raw);
    return (aqi: AqiResponse.fromJson(data['data']), savedAt: DateTime.fromMillisecondsSinceEpoch(data['savedAt']));
  }

  Future<void> writeAQI(AqiResponse aqi) => _preferences.setString(
    SettingsKey.aqiKey,
    jsonEncode({'savedAt': DateTime.now().millisecondsSinceEpoch, 'data': aqi.toJson()}),
  );

  ({AqiResponse aqi, DateTime savedAt})? readAQIForecast() {
    final raw = _preferences.getString(SettingsKey.aqiForecastKey);
    if (raw == null) return null;
    final data = jsonDecode(raw);
    return (aqi: AqiResponse.fromJson(data['data']), savedAt: DateTime.fromMillisecondsSinceEpoch(data['savedAt']));
  }

  Future<void> writeAQIForecast(AqiResponse aqi) => _preferences.setString(
    SettingsKey.aqiForecastKey,
    jsonEncode({'savedAt': DateTime.now().millisecondsSinceEpoch, 'data': aqi.toJson()}),
  );

  ({OneCallResponse weather, DateTime savedAt})? readWeather() {
    final raw = _preferences.getString(SettingsKey.oneCallKey);
    if (raw == null) return null;
    final data = jsonDecode(raw);
    return (
      weather: OneCallResponse.fromJson(data['data']),
      savedAt: DateTime.fromMillisecondsSinceEpoch(data['savedAt']),
    );
  }

  Future<void> writeWeather(OneCallResponse weather) => _preferences.setString(
    SettingsKey.oneCallKey,
    jsonEncode({'savedAt': DateTime.now().millisecondsSinceEpoch, 'data': weather.toJson()}),
  );
}
