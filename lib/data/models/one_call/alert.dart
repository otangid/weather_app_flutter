import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class Alert {
  final String? senderName;
  final String? event;
  final int? start;
  final int? end;
  final String? description;
  final List<dynamic>? tags;

  const Alert({this.senderName, this.event, this.start, this.end, this.description, this.tags});

  @override
  String toString() {
    return 'Alert(senderName: $senderName, event: $event, start: $start, end: $end, description: $description, tags: $tags)';
  }

  factory Alert.fromMap(Map<String, dynamic> data) => Alert(
    senderName: data['sender_name'] as String?,
    event: data['event'] as String?,
    start: data['start'] as int?,
    end: data['end'] as int?,
    description: data['description'] as String?,
    tags: data['tags'] as List<dynamic>?,
  );

  Map<String, dynamic> toMap() => {
    'sender_name': senderName,
    'event': event,
    'start': start,
    'end': end,
    'description': description,
    'tags': tags,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Alert].
  factory Alert.fromJson(String data) {
    return Alert.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Alert] to a JSON string.
  String toJson() => json.encode(toMap());

  Alert copyWith({String? senderName, String? event, int? start, int? end, String? description, List<dynamic>? tags}) {
    return Alert(
      senderName: senderName ?? this.senderName,
      event: event ?? this.event,
      start: start ?? this.start,
      end: end ?? this.end,
      description: description ?? this.description,
      tags: tags ?? this.tags,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Alert) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      senderName.hashCode ^ event.hashCode ^ start.hashCode ^ end.hashCode ^ description.hashCode ^ tags.hashCode;
}
