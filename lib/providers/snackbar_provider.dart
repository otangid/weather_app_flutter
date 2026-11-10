import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'snackbar_provider.g.dart';

class UiSnackbar {
  final String text;
  UiSnackbar(this.text); // sengaja tanpa ==, supaya pesan sama tetap memicu listener
}

@riverpod
class UiSnackbarNotifier extends _$UiSnackbarNotifier {
  @override
  UiSnackbar? build() => null;

  void show(String text) => state = UiSnackbar(text);
}
