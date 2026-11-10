import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class Temp {
  final double? day;
  final double? min;
  final double? max;
  final double? night;
  final double? eve;
  final double? morn;

  const Temp({this.day, this.min, this.max, this.night, this.eve, this.morn});

  @override
  String toString() {
    return 'Temp(day: $day, min: $min, max: $max, night: $night, eve: $eve, morn: $morn)';
  }

  factory Temp.fromMap(Map<String, dynamic> data) => Temp(
    day: (data['day'] as num?)?.toDouble(),
    min: (data['min'] as num?)?.toDouble(),
    max: (data['max'] as num?)?.toDouble(),
    night: (data['night'] as num?)?.toDouble(),
    eve: (data['eve'] as num?)?.toDouble(),
    morn: (data['morn'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toMap() => {'day': day, 'min': min, 'max': max, 'night': night, 'eve': eve, 'morn': morn};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Temp].
  factory Temp.fromJson(String data) {
    return Temp.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Temp] to a JSON string.
  String toJson() => json.encode(toMap());

  Temp copyWith({double? day, double? min, double? max, double? night, double? eve, double? morn}) {
    return Temp(
      day: day ?? this.day,
      min: min ?? this.min,
      max: max ?? this.max,
      night: night ?? this.night,
      eve: eve ?? this.eve,
      morn: morn ?? this.morn,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Temp) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => day.hashCode ^ min.hashCode ^ max.hashCode ^ night.hashCode ^ eve.hashCode ^ morn.hashCode;
}
