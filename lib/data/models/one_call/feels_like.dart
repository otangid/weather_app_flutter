import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class FeelsLike {
  final double? day;
  final double? night;
  final double? eve;
  final double? morn;

  const FeelsLike({this.day, this.night, this.eve, this.morn});

  @override
  String toString() {
    return 'FeelsLike(day: $day, night: $night, eve: $eve, morn: $morn)';
  }

  factory FeelsLike.fromMap(Map<String, dynamic> data) => FeelsLike(
    day: (data['day'] as num?)?.toDouble(),
    night: (data['night'] as num?)?.toDouble(),
    eve: (data['eve'] as num?)?.toDouble(),
    morn: (data['morn'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toMap() => {'day': day, 'night': night, 'eve': eve, 'morn': morn};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [FeelsLike].
  factory FeelsLike.fromJson(String data) {
    return FeelsLike.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [FeelsLike] to a JSON string.
  String toJson() => json.encode(toMap());

  FeelsLike copyWith({double? day, double? night, double? eve, double? morn}) {
    return FeelsLike(day: day ?? this.day, night: night ?? this.night, eve: eve ?? this.eve, morn: morn ?? this.morn);
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! FeelsLike) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => day.hashCode ^ night.hashCode ^ eve.hashCode ^ morn.hashCode;
}
