import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:material_ui/material_ui.dart';

import 'components.dart';
import 'main.dart';

@immutable
class Data {
  final Main? main;
  final Components? components;
  final int? dt;

  const Data({this.main, this.components, this.dt});

  @override
  String toString() => 'List(main: $main, components: $components, dt: $dt)';

  factory Data.fromMap(Map<String, dynamic> data) => Data(
    main: data['main'] == null ? null : Main.fromMap(data['main'] as Map<String, dynamic>),
    components: data['components'] == null ? null : Components.fromMap(data['components'] as Map<String, dynamic>),
    dt: data['dt'] as int?,
  );

  Map<String, dynamic> toMap() => {'main': main?.toMap(), 'components': components?.toMap(), 'dt': dt};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [List].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [List] to a JSON string.
  String toJson() => json.encode(toMap());

  Data copyWith({Main? main, Components? components, int? dt}) {
    return Data(main: main ?? this.main, components: components ?? this.components, dt: dt ?? this.dt);
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => main.hashCode ^ components.hashCode ^ dt.hashCode;
}
