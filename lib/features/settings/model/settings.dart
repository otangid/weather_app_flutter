import 'dart:convert';

class Setting {
  final double lat;
  final double lon;
  final String city;
  final String apiKey;
  final int tempUnit;
  final int pressUnit;
  final int speedUnit;
  final int distUnit;
  final int themeMode;
  final int cacheInterval;
  Setting({
    required this.lat,
    required this.lon,
    required this.city,
    required this.apiKey,
    required this.tempUnit,
    required this.pressUnit,
    required this.speedUnit,
    required this.distUnit,
    required this.themeMode,
    required this.cacheInterval,
  });

  Setting copyWith({
    double? lat,
    double? lon,
    String? city,
    String? apiKey,
    int? tempUnit,
    int? pressUnit,
    int? speedUnit,
    int? distUnit,
    int? themeMode,
    int? cacheInterval,
  }) {
    return Setting(
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      city: city ?? this.city,
      apiKey: apiKey ?? this.apiKey,
      tempUnit: tempUnit ?? this.tempUnit,
      pressUnit: pressUnit ?? this.pressUnit,
      speedUnit: speedUnit ?? this.speedUnit,
      distUnit: distUnit ?? this.distUnit,
      themeMode: themeMode ?? this.themeMode,
      cacheInterval: cacheInterval ?? this.cacheInterval,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lon': lon,
      'city': city,
      'apiKey': apiKey,
      'tempUnit': tempUnit,
      'pressUnit': pressUnit,
      'speedUnit': speedUnit,
      'distUnit': distUnit,
      'themeMode': themeMode,
      'cacheInterval': cacheInterval,
    };
  }

  factory Setting.fromMap(Map<String, dynamic> map) {
    return Setting(
      lat: map['lat'] as double,
      lon: map['lon'] as double,
      city: map['city'] as String,
      apiKey: map['apiKey'] as String,
      tempUnit: map['tempUnit'] as int,
      pressUnit: map['pressUnit'] as int,
      speedUnit: map['speedUnit'] as int,
      distUnit: map['distUnit'] as int,
      themeMode: map['themeMode'] as int,
      cacheInterval: map['cacheInterval'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Setting.fromJson(String source) => Setting.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Setting(lat: $lat, lon: $lon, city: $city, apiKey: $apiKey, tempUnit: $tempUnit, pressUnit: $pressUnit, speedUnit: $speedUnit, distUnit: $distUnit, themeMode: $themeMode, cacheInterval: $cacheInterval)';
  }

  @override
  bool operator ==(covariant Setting other) {
    if (identical(this, other)) return true;

    return other.lat == lat &&
        other.lon == lon &&
        other.city == city &&
        other.apiKey == apiKey &&
        other.tempUnit == tempUnit &&
        other.pressUnit == pressUnit &&
        other.speedUnit == speedUnit &&
        other.distUnit == distUnit &&
        other.themeMode == themeMode &&
        other.cacheInterval == cacheInterval;
  }

  @override
  int get hashCode {
    return lat.hashCode ^
        lon.hashCode ^
        city.hashCode ^
        apiKey.hashCode ^
        tempUnit.hashCode ^
        pressUnit.hashCode ^
        speedUnit.hashCode ^
        distUnit.hashCode ^
        themeMode.hashCode ^
        cacheInterval.hashCode;
  }
}
