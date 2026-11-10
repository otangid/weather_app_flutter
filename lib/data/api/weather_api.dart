import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_flutter/data/models/aqi/aqi_response.dart';
import 'package:weather_app_flutter/data/models/one_call/one_call_response.dart';
import 'package:weather_app_flutter/features/settings/provider/settings_provider.dart';
import 'package:weather_app_flutter/utils/api_util.dart';

class AppException implements Exception {
  final String message;
  AppException(this.message);
}

class WeatherApi {
  final Dio _dio;
  final SharedPreferences _preferences;
  WeatherApi({required this._dio, required this._preferences});

  ({double lat, double lon, String apiKey}) _readConfig() {
    final lat = _preferences.getDouble(SettingsKey.latKey) ?? 0.0;
    final lon = _preferences.getDouble(SettingsKey.lonKey) ?? 0.0;
    final apiKey = _preferences.getString(SettingsKey.apiKey) ?? '';

    if (apiKey.isEmpty) throw AppException('ApiKey not set.');
    if (lat == 0.0 || lon == 0.0) throw AppException('Location not set.');
    return (lat: lat, lon: lon, apiKey: apiKey);
  }

  Future<AqiResponse> fetchAQI() async {
    final config = _readConfig();

    final url = ApiUtil.getAqiUrl(lat: config.lat, lon: config.lon, apiKey: config.apiKey);
    final response = await _dio.get(url);
    if (response.statusCode != 200) {
      throw AppException('Weather API error ${response.statusCode}');
    }
    return AqiResponse.fromMap(response.data);
  }

  Future<AqiResponse> fetchAQIForecast() async {
    final config = _readConfig();

    final url = ApiUtil.getAqiForeUrl(lat: config.lat, lon: config.lon, apiKey: config.apiKey);
    final response = await _dio.get(url);
    if (response.statusCode != 200) {
      throw AppException('Weather API error ${response.statusCode}');
    }
    return AqiResponse.fromMap(response.data);
  }

  Future<OneCallResponse> fetchWeather() async {
    final config = _readConfig();

    final url = ApiUtil.getUrl(lat: config.lat, lon: config.lon, apiKey: config.apiKey);
    final response = await _dio.get(url);
    if (response.statusCode != 200) {
      throw AppException('Weather API error ${response.statusCode}');
    }
    return OneCallResponse.fromMap(response.data);
  }
}
