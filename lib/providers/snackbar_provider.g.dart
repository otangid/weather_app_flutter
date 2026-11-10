// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snackbar_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UiSnackbarNotifier)
final uiSnackbarProvider = UiSnackbarNotifierProvider._();

final class UiSnackbarNotifierProvider
    extends $NotifierProvider<UiSnackbarNotifier, UiSnackbar?> {
  UiSnackbarNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uiSnackbarProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uiSnackbarNotifierHash();

  @$internal
  @override
  UiSnackbarNotifier create() => UiSnackbarNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UiSnackbar? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UiSnackbar?>(value),
    );
  }
}

String _$uiSnackbarNotifierHash() =>
    r'85341b315254e2393cd7aad73917c4d7d8abdc09';

abstract class _$UiSnackbarNotifier extends $Notifier<UiSnackbar?> {
  UiSnackbar? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<UiSnackbar?, UiSnackbar?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UiSnackbar?, UiSnackbar?>,
              UiSnackbar?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
