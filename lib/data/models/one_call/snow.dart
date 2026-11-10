import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class Snow {
  final double? oneh;

  const Snow({this.oneh});

  @override
  String toString() => 'Snow(1h: $oneh)';

  factory Snow.fromMap(Map<String, dynamic> data) => Snow(oneh: (data['1h'] as num?)?.toDouble());

  Map<String, dynamic> toMap() => {'1h': oneh};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Snow].
  factory Snow.fromJson(String data) {
    return Snow.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Snow] to a JSON string.
  String toJson() => json.encode(toMap());

  Snow copyWith({double? oneh}) {
    return Snow(oneh: oneh ?? this.oneh);
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Snow) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => oneh.hashCode;
}
