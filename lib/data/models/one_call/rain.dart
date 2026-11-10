import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class Rain {
  final double? oneh;

  const Rain({this.oneh});

  @override
  String toString() => 'Rain(1h: $oneh)';

  factory Rain.fromMap(Map<String, dynamic> data) => Rain(oneh: (data['1h'] as num?)?.toDouble());

  Map<String, dynamic> toMap() => {'1h': oneh};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Rain].
  factory Rain.fromJson(String data) {
    return Rain.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Rain] to a JSON string.
  String toJson() => json.encode(toMap());

  Rain copyWith({double? oneh}) {
    return Rain(oneh: oneh ?? this.oneh);
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Rain) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => oneh.hashCode;
}
