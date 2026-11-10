import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:material_ui/material_ui.dart';

import 'rain.dart';
import 'snow.dart';
import 'weather.dart';

@immutable
class Current {
  final int? dt;
  final int? sunrise;
  final int? sunset;
  final double? temp;
  final double? feelsLike;
  final int? pressure;
  final int? humidity;
  final double? dewPoint;
  final double? uvi;
  final int? clouds;
  final int? visibility;
  final double? windSpeed;
  final int? windDeg;
  final double? windGust;
  final List<Weather>? weather;
  final Rain? rain;
  final Snow? snow;

  const Current({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
    this.rain,
    this.snow,
  });

  @override
  String toString() {
    return 'Current(dt: $dt, sunrise: $sunrise, sunset: $sunset, temp: $temp, feelsLike: $feelsLike, pressure: $pressure, humidity: $humidity, dewPoint: $dewPoint, uvi: $uvi, clouds: $clouds, visibility: $visibility, windSpeed: $windSpeed, windDeg: $windDeg, windGust: $windGust, weather: $weather, rain: $rain, snow: $snow)';
  }

  factory Current.fromMap(Map<String, dynamic> data) => Current(
    dt: data['dt'] as int?,
    sunrise: data['sunrise'] as int?,
    sunset: data['sunset'] as int?,
    temp: (data['temp'] as num?)?.toDouble(),
    feelsLike: (data['feels_like'] as num?)?.toDouble(),
    pressure: data['pressure'] as int?,
    humidity: data['humidity'] as int?,
    dewPoint: (data['dew_point'] as num?)?.toDouble(),
    uvi: (data['uvi'] as num?)?.toDouble(),
    clouds: data['clouds'] as int?,
    visibility: data['visibility'] as int?,
    windSpeed: (data['wind_speed'] as num?)?.toDouble(),
    windDeg: data['wind_deg'] as int?,
    windGust: (data['wind_gust'] as num?)?.toDouble(),
    weather: (data['weather'] as List<dynamic>?)?.map((e) => Weather.fromMap(e as Map<String, dynamic>)).toList(),
    rain: data['rain'] == null ? null : Rain.fromMap(data['rain'] as Map<String, dynamic>),
    snow: data['snow'] == null ? null : Snow.fromMap(data['snow'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {
    'dt': dt,
    'sunrise': sunrise,
    'sunset': sunset,
    'temp': temp,
    'feels_like': feelsLike,
    'pressure': pressure,
    'humidity': humidity,
    'dew_point': dewPoint,
    'uvi': uvi,
    'clouds': clouds,
    'visibility': visibility,
    'wind_speed': windSpeed,
    'wind_deg': windDeg,
    'wind_gust': windGust,
    'weather': weather?.map((e) => e.toMap()).toList(),
    'rain': rain?.toMap(),
    'snow': snow?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Current].
  factory Current.fromJson(String data) {
    return Current.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Current] to a JSON string.
  String toJson() => json.encode(toMap());

  Current copyWith({
    int? dt,
    int? sunrise,
    int? sunset,
    double? temp,
    double? feelsLike,
    int? pressure,
    int? humidity,
    double? dewPoint,
    double? uvi,
    int? clouds,
    int? visibility,
    double? windSpeed,
    int? windDeg,
    double? windGust,
    List<Weather>? weather,
    Rain? rain,
    Snow? snow,
  }) {
    return Current(
      dt: dt ?? this.dt,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      temp: temp ?? this.temp,
      feelsLike: feelsLike ?? this.feelsLike,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      dewPoint: dewPoint ?? this.dewPoint,
      uvi: uvi ?? this.uvi,
      clouds: clouds ?? this.clouds,
      visibility: visibility ?? this.visibility,
      windSpeed: windSpeed ?? this.windSpeed,
      windDeg: windDeg ?? this.windDeg,
      windGust: windGust ?? this.windGust,
      weather: weather ?? this.weather,
      rain: rain ?? this.rain,
      snow: snow ?? this.snow,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Current) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      dt.hashCode ^
      sunrise.hashCode ^
      sunset.hashCode ^
      temp.hashCode ^
      feelsLike.hashCode ^
      pressure.hashCode ^
      humidity.hashCode ^
      dewPoint.hashCode ^
      uvi.hashCode ^
      clouds.hashCode ^
      visibility.hashCode ^
      windSpeed.hashCode ^
      windDeg.hashCode ^
      windGust.hashCode ^
      weather.hashCode ^
      rain.hashCode ^
      snow.hashCode;
}
