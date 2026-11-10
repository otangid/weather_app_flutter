import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:material_ui/material_ui.dart';

import 'alert.dart';
import 'current.dart';
import 'daily.dart';
import 'hourly.dart';
import 'minutely.dart';

@immutable
class OneCallResponse {
  final double? lat;
  final double? lon;
  final String? timezone;
  final int? timezoneOffset;
  final Current? current;
  final List<Minutely>? minutely;
  final List<Hourly>? hourly;
  final List<Daily>? daily;
  final List<Alert>? alerts;

  const OneCallResponse({
    this.lat,
    this.lon,
    this.timezone,
    this.timezoneOffset,
    this.current,
    this.minutely,
    this.hourly,
    this.daily,
    this.alerts,
  });

  @override
  String toString() {
    return 'OneCallResponse(lat: $lat, lon: $lon, timezone: $timezone, timezoneOffset: $timezoneOffset, current: $current, minutely: $minutely, hourly: $hourly, daily: $daily, alerts: $alerts)';
  }

  factory OneCallResponse.fromMap(Map<String, dynamic> data) {
    return OneCallResponse(
      lat: (data['lat'] as num?)?.toDouble(),
      lon: (data['lon'] as num?)?.toDouble(),
      timezone: data['timezone'] as String?,
      timezoneOffset: data['timezone_offset'] as int?,
      current: data['current'] == null ? null : Current.fromMap(data['current'] as Map<String, dynamic>),
      minutely: (data['minutely'] as List<dynamic>?)?.map((e) => Minutely.fromMap(e as Map<String, dynamic>)).toList(),
      hourly: (data['hourly'] as List<dynamic>?)?.map((e) => Hourly.fromMap(e as Map<String, dynamic>)).toList(),
      daily: (data['daily'] as List<dynamic>?)?.map((e) => Daily.fromMap(e as Map<String, dynamic>)).toList(),
      alerts: (data['alerts'] as List<dynamic>?)?.map((e) => Alert.fromMap(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toMap() => {
    'lat': lat,
    'lon': lon,
    'timezone': timezone,
    'timezone_offset': timezoneOffset,
    'current': current?.toMap(),
    'minutely': minutely?.map((e) => e.toMap()).toList(),
    'hourly': hourly?.map((e) => e.toMap()).toList(),
    'daily': daily?.map((e) => e.toMap()).toList(),
    'alerts': alerts?.map((e) => e.toMap()).toList(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OneCallResponse].
  factory OneCallResponse.fromJson(String data) {
    return OneCallResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OneCallResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  OneCallResponse copyWith({
    double? lat,
    double? lon,
    String? timezone,
    int? timezoneOffset,
    Current? current,
    List<Minutely>? minutely,
    List<Hourly>? hourly,
    List<Daily>? daily,
    List<Alert>? alerts,
  }) {
    return OneCallResponse(
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      timezone: timezone ?? this.timezone,
      timezoneOffset: timezoneOffset ?? this.timezoneOffset,
      current: current ?? this.current,
      minutely: minutely ?? this.minutely,
      hourly: hourly ?? this.hourly,
      daily: daily ?? this.daily,
      alerts: alerts ?? this.alerts,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! OneCallResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      lat.hashCode ^
      lon.hashCode ^
      timezone.hashCode ^
      timezoneOffset.hashCode ^
      current.hashCode ^
      minutely.hashCode ^
      hourly.hashCode ^
      daily.hashCode ^
      alerts.hashCode;
}
