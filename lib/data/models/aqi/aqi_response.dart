import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:material_ui/material_ui.dart';

import 'coord.dart';
import 'data.dart';

@immutable
class AqiResponse {
  final Coord? coord;
  final List<Data>? list;

  const AqiResponse({this.coord, this.list});

  @override
  String toString() => 'AqiResponse(coord: $coord, list: $list)';

  factory AqiResponse.fromMap(Map<String, dynamic> data) => AqiResponse(
    coord: data['coord'] == null ? null : Coord.fromMap(data['coord'] as Map<String, dynamic>),
    list: (data['list'] as List<dynamic>?)?.map((e) => Data.fromMap(e as Map<String, dynamic>)).toList(),
  );

  Map<String, dynamic> toMap() => {'coord': coord?.toMap(), 'list': list?.map((e) => e.toMap()).toList()};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AqiResponse].
  factory AqiResponse.fromJson(String data) {
    return AqiResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AqiResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  AqiResponse copyWith({Coord? coord, List<Data>? list}) {
    return AqiResponse(coord: coord ?? this.coord, list: list ?? this.list);
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AqiResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => coord.hashCode ^ list.hashCode;
}
