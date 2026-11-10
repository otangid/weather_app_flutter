// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Settings)
final settingsProvider = SettingsProvider._();

final class SettingsProvider extends $NotifierProvider<Settings, Setting> {
  SettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsHash();

  @$internal
  @override
  Settings create() => Settings();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Setting value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Setting>(value),
    );
  }
}

String _$settingsHash() => r'aa24d28700d40d643d852df5b43bc78a31dc7032';

abstract class _$Settings extends $Notifier<Setting> {
  Setting build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Setting, Setting>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Setting, Setting>,
              Setting,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
