// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aqi_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AqiController)
final aqiControllerProvider = AqiControllerProvider._();

final class AqiControllerProvider
    extends $AsyncNotifierProvider<AqiController, AqiResponse> {
  AqiControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aqiControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aqiControllerHash();

  @$internal
  @override
  AqiController create() => AqiController();
}

String _$aqiControllerHash() => r'52a71f32dd8b0dcd6e166973eacc9faeb58934a1';

abstract class _$AqiController extends $AsyncNotifier<AqiResponse> {
  FutureOr<AqiResponse> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AqiResponse>, AqiResponse>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AqiResponse>, AqiResponse>,
              AsyncValue<AqiResponse>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(AqiForecastController)
final aqiForecastControllerProvider = AqiForecastControllerProvider._();

final class AqiForecastControllerProvider
    extends $AsyncNotifierProvider<AqiForecastController, AqiResponse> {
  AqiForecastControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aqiForecastControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aqiForecastControllerHash();

  @$internal
  @override
  AqiForecastController create() => AqiForecastController();
}

String _$aqiForecastControllerHash() =>
    r'c66443f14920d8076f130ed50fdf857e214b77a6';

abstract class _$AqiForecastController extends $AsyncNotifier<AqiResponse> {
  FutureOr<AqiResponse> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AqiResponse>, AqiResponse>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AqiResponse>, AqiResponse>,
              AsyncValue<AqiResponse>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
