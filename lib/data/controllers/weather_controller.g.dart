// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WeatherController)
final weatherControllerProvider = WeatherControllerProvider._();

final class WeatherControllerProvider
    extends $AsyncNotifierProvider<WeatherController, OneCallResponse> {
  WeatherControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weatherControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weatherControllerHash();

  @$internal
  @override
  WeatherController create() => WeatherController();
}

String _$weatherControllerHash() => r'87130beeabcba276a42514529b8ab630001388f4';

abstract class _$WeatherController extends $AsyncNotifier<OneCallResponse> {
  FutureOr<OneCallResponse> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<OneCallResponse>, OneCallResponse>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<OneCallResponse>, OneCallResponse>,
              AsyncValue<OneCallResponse>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
