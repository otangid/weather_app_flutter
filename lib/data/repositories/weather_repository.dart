import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app_flutter/data/api/weather_api.dart';
import 'package:weather_app_flutter/data/cache/weather_cache.dart';
import 'package:weather_app_flutter/data/models/aqi/aqi_response.dart';
import 'package:weather_app_flutter/data/models/one_call/one_call_response.dart';
import 'package:weather_app_flutter/features/settings/provider/settings_provider.dart';
import 'package:weather_app_flutter/providers/dio_provider.dart';
import 'package:weather_app_flutter/providers/shared_preferences_provider.dart';
import 'package:weather_app_flutter/providers/snackbar_provider.dart';

part 'weather_repository.g.dart';

class WeatherRepository {
  final Ref ref;
  final WeatherApi _api;
  final WeatherCache _cache;
  WeatherRepository({required this.ref, required this._api, required this._cache});

  Duration get _ttl => Duration(minutes: ref.read(settingsProvider).cacheInterval);

  Future<AqiResponse> getAQI({bool force = false}) async {
    final cached = _cache.readAQI();
    final fresh = cached != null && DateTime.now().difference(cached.savedAt) < _ttl;

    if (!force && fresh) return cached.aqi;

    try {
      final data = await _api.fetchAQI();
      await _cache.writeAQI(data);
      return data;
    } on AppException catch (e) {
      ref.read(uiSnackbarProvider.notifier).show(e.message);
      rethrow;
    } catch (e) {
      // Gagal (offline, dll): pakai cache lama kalau ada
      if (cached != null) return cached.aqi;
      ref.read(uiSnackbarProvider.notifier).show('Failed to fetch weather.');
      rethrow;
    }
  }

  Future<AqiResponse> getAQIForecast({bool force = false}) async {
    final cached = _cache.readAQIForecast();
    final fresh = cached != null && DateTime.now().difference(cached.savedAt) < _ttl;

    if (!force && fresh) return cached.aqi;

    try {
      final data = await _api.fetchAQIForecast();
      await _cache.writeAQIForecast(data);
      return data;
    } on AppException catch (e) {
      ref.read(uiSnackbarProvider.notifier).show(e.message);
      rethrow;
    } catch (e) {
      // Gagal (offline, dll): pakai cache lama kalau ada
      if (cached != null) return cached.aqi;
      ref.read(uiSnackbarProvider.notifier).show('Failed to fetch weather.');
      rethrow;
    }
  }

  Future<OneCallResponse> getWeather({bool force = false}) async {
    final cached = _cache.readWeather();
    final fresh = cached != null && DateTime.now().difference(cached.savedAt) < _ttl;

    if (!force && fresh) return cached.weather;

    try {
      final data = await _api.fetchWeather();
      await _cache.writeWeather(data);
      return data;
    } on AppException catch (e) {
      ref.read(uiSnackbarProvider.notifier).show(e.message);
      rethrow;
    } catch (e) {
      // Gagal (offline, dll): pakai cache lama kalau ada
      if (cached != null) return cached.weather;
      ref.read(uiSnackbarProvider.notifier).show('Failed to fetch weather.');
      rethrow;
    }
  }
}

@Riverpod(keepAlive: true)
WeatherRepository weatherRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  final preferences = ref.watch(sharedPreferencesProvider);
  return WeatherRepository(
    ref: ref,
    api: WeatherApi(dio: dio, preferences: preferences),
    cache: WeatherCache(preferences: preferences),
  );
}
