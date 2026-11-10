import 'package:material_ui/material_ui.dart';

extension SystemPadding on BuildContext {
  double get paddingTop => MediaQuery.of(this).padding.top;
  double get paddingBottom => MediaQuery.of(this).padding.bottom;
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}

extension Themes on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;

  Color get surface => colorScheme.surface;
  Color get onSurface => colorScheme.onSurface;
  Color get surfaceContainer => colorScheme.surfaceContainer;
  Color get primary => colorScheme.primary;
  Color get onPrimary => colorScheme.onPrimary;
  Color get secondary => colorScheme.secondary;
  Color get onSecondary => colorScheme.onSecondary;
  Color get tertiary => colorScheme.tertiary;
  Color get onTertiary => colorScheme.onTertiary;
}

extension TextStyles on TextStyle {
  // Bold & Weight
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);

  // Style
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  // Color Quick-helper
  TextStyle clr(Color color) => copyWith(color: color);

  // Size Quick-helper
  TextStyle size(double size) => copyWith(fontSize: size);

  TextStyle custom({Color? color, double? size, String? family, double? height}) {
    return copyWith(color: color, fontSize: size?.toDouble(), fontFamily: family, height: height);
  }
}

extension Let<T> on T {
  R let<R>(R Function(T it) block) => block(this);
}
