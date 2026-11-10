import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class Main {
  final int? aqi;

  const Main({this.aqi});

  @override
  String toString() => 'Main(aqi: $aqi)';

  factory Main.fromMap(Map<String, dynamic> data) => Main(aqi: data['aqi'] as int?);

  Map<String, dynamic> toMap() => {'aqi': aqi};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Main].
  factory Main.fromJson(String data) {
    return Main.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Main] to a JSON string.
  String toJson() => json.encode(toMap());

  Main copyWith({int? aqi}) {
    return Main(aqi: aqi ?? this.aqi);
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Main) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => aqi.hashCode;
}
