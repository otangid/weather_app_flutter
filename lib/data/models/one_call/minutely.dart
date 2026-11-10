import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class Minutely {
  final int? dt;
  final int? precipitation;

  const Minutely({this.dt, this.precipitation});

  @override
  String toString() => 'Minutely(dt: $dt, precipitation: $precipitation)';

  factory Minutely.fromMap(Map<String, dynamic> data) =>
      Minutely(dt: data['dt'] as int?, precipitation: data['precipitation'] as int?);

  Map<String, dynamic> toMap() => {'dt': dt, 'precipitation': precipitation};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Minutely].
  factory Minutely.fromJson(String data) {
    return Minutely.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Minutely] to a JSON string.
  String toJson() => json.encode(toMap());

  Minutely copyWith({int? dt, int? precipitation}) {
    return Minutely(dt: dt ?? this.dt, precipitation: precipitation ?? this.precipitation);
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Minutely) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => dt.hashCode ^ precipitation.hashCode;
}
