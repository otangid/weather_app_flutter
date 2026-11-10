import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app_flutter/data/models/one_call/one_call_response.dart';
import 'package:weather_app_flutter/data/repositories/weather_repository.dart';

part 'weather_controller.g.dart';

@Riverpod(keepAlive: true)
class WeatherController extends _$WeatherController {
  @override
  FutureOr<OneCallResponse> build() {
    return ref.read(weatherRepositoryProvider).getWeather();
  }

  Future<void> refresh() async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(weatherRepositoryProvider).getWeather(force: true));
  }
}
