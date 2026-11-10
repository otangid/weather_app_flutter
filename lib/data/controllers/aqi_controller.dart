import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app_flutter/data/models/aqi/aqi_response.dart';
import 'package:weather_app_flutter/data/repositories/weather_repository.dart';

part 'aqi_controller.g.dart';

@Riverpod(keepAlive: true)
class AqiController extends _$AqiController {
  @override
  FutureOr<AqiResponse> build() {
    return ref.read(weatherRepositoryProvider).getAQI();
  }

  Future<void> refresh() async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(weatherRepositoryProvider).getAQI(force: true));
  }
}

@Riverpod(keepAlive: true)
class AqiForecastController extends _$AqiForecastController {
  @override
  FutureOr<AqiResponse> build() {
    return ref.read(weatherRepositoryProvider).getAQIForecast();
  }

  Future<void> refresh() async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(weatherRepositoryProvider).getAQIForecast(force: true));
  }
}
