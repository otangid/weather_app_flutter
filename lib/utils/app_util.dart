import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:unixtime/unixtime.dart';
import 'package:weather_app_flutter/utils/app_const.dart';
import 'package:weather_app_flutter/utils/ext.dart';

class AppUtil {
  static Future<bool> isNetworkAvailable() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    final hasNoConnection = connectivityResult.contains(ConnectivityResult.none);
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    return !hasNoConnection && isOnline;
  }

  static String maskApiKey(String key) {
    if (key.isEmpty) return 'Not set';
    if (key.length <= 8) return '•' * key.length;
    return '${key.substring(0, 4)}${'•' * 8}${key.substring(key.length - 4)}';
  }

  static String formatTemp(int type, dynamic temp) {
    if (temp == null) {
      return '0';
    }
    if (type == 0) {
      return (temp * 1.0).round().toString();
    } else if (type == 1) {
      return ((temp * 9 / 5) + 32).round().toString();
    } else {
      return ((temp * 1.0).round() + 273).toString();
    }
  }

  static String formatTempText(int type, dynamic temp) {
    if (temp == null) {
      return '0';
    }
    var tmp = formatTemp(type, temp);
    return '$tmp ${tempUnitL[type]}';
  }

  static String formatSpeed(int type, dynamic speed) {
    if (speed == null) {
      return '0';
    }
    if (type == 0) {
      return speed.round().toString();
    } else if (type == 1) {
      var v = speed * 3.6 as num;
      return v.toStringAsFixed(1);
    } else {
      var v = speed * 2.237 as num;
      return v.toStringAsFixed(1);
    }
  }

  static String unitSpeed(int type) {
    if (type == 0) {
      return 'm/s';
    } else if (type == 1) {
      return 'km/h';
    } else {
      return 'mph';
    }
  }

  static String formatDist(int type, dynamic dist) {
    if (dist == null) {
      return '0.0';
    }
    if (type == 0) {
      var v = dist / 1000 as num;
      return v.toStringAsFixed(1);
    } else {
      var v = dist / 1609 as num;
      return v.toStringAsFixed(1);
    }
  }

  static String unitDist(int type) {
    if (type == 0) {
      return 'km';
    } else {
      return 'mi';
    }
  }

  static String formatPress(int type, dynamic press) {
    if (press == null) {
      return '0';
    }
    if (type == 0) {
      return press.toString();
    } else if (type == 1) {
      var v = (press * 0.02952998057228486) as num;
      return v.toStringAsFixed(2);
    } else {
      var v = (press * 0.75006157584566) as num;
      return v.toStringAsFixed(2);
    }
  }

  static String unitPress(int type) {
    if (type == 0) {
      return 'hPa';
    } else if (type == 1) {
      return 'inHg';
    } else {
      return 'mmHg';
    }
  }

  static Color hexColor(String hex) {
    hex = hex.toUpperCase().replaceAll('#', '');
    int color = int.parse((hex.length == 6 ? 'FF$hex' : hex), radix: 16);
    return Color(color);
  }

  static Color getAqiColor(BuildContext context, int index) => switch (index) {
    1 => aqiColor1,
    2 => aqiColor2,
    3 => aqiColor3,
    4 => aqiColor4,
    5 => aqiColor5,
    _ => context.colorScheme.primary,
  };

  static String getAqiTitle(int aqi) => switch (aqi) {
    1 => aqiLv1Title,
    2 => aqiLv2Title,
    3 => aqiLv3Title,
    4 => aqiLv4Title,
    5 => aqiLv5Title,
    _ => 'N/A',
  };

  static String getAqiInfo(int index) => switch (index) {
    1 => aqiLv1Desc,
    2 => aqiLv2Desc,
    3 => aqiLv3Desc,
    4 => aqiLv4Desc,
    5 => aqiLv5Desc,
    _ => 'Na',
  };

  static Color getSo2Color(BuildContext context, int value) {
    if (value >= 0 && value <= 20) {
      return aqiColor1;
    } else if (value >= 21 && value <= 80) {
      return aqiColor2;
    } else if (value >= 81 && value <= 250) {
      return aqiColor3;
    } else if (value >= 251 && value <= 350) {
      return aqiColor4;
    } else if (value > 350) {
      return aqiColor5;
    } else {
      return context.primary;
    }
  }

  static Color getNo2Color(BuildContext context, int value) {
    if (value >= 0 && value <= 40) {
      return aqiColor1;
    } else if (value >= 41 && value <= 70) {
      return aqiColor2;
    } else if (value >= 71 && value <= 150) {
      return aqiColor3;
    } else if (value >= 151 && value <= 200) {
      return aqiColor4;
    } else if (value > 200) {
      return aqiColor5;
    } else {
      return context.primary;
    }
  }

  static Color getPm10Color(BuildContext context, int value) {
    if (value >= 0 && value <= 20) {
      return aqiColor1;
    } else if (value >= 21 && value <= 50) {
      return aqiColor2;
    } else if (value >= 51 && value <= 100) {
      return aqiColor3;
    } else if (value >= 101 && value <= 200) {
      return aqiColor4;
    } else if (value > 200) {
      return aqiColor5;
    } else {
      return context.primary;
    }
  }

  static Color getPm25Color(BuildContext context, int value) {
    if (value >= 0 && value <= 10) {
      return aqiColor1;
    } else if (value >= 11 && value <= 25) {
      return aqiColor2;
    } else if (value >= 26 && value <= 50) {
      return aqiColor3;
    } else if (value >= 51 && value <= 75) {
      return aqiColor4;
    } else if (value > 75) {
      return aqiColor5;
    } else {
      return context.primary;
    }
  }

  static Color geto3Color(BuildContext context, int value) {
    if (value >= 0 && value <= 60) {
      return aqiColor1;
    } else if (value >= 61 && value <= 100) {
      return aqiColor2;
    } else if (value >= 101 && value <= 140) {
      return aqiColor3;
    } else if (value >= 141 && value <= 180) {
      return aqiColor4;
    } else if (value > 180) {
      return aqiColor5;
    } else {
      return context.primary;
    }
  }

  static Color getCoColor(BuildContext context, int value) {
    if (value >= 0 && value <= 4400) {
      return aqiColor1;
    } else if (value >= 4401 && value <= 9400) {
      return aqiColor2;
    } else if (value >= 9401 && value <= 12400) {
      return aqiColor3;
    } else if (value >= 12401 && value <= 15400) {
      return aqiColor4;
    } else if (value > 15400) {
      return aqiColor5;
    } else {
      return context.primary;
    }
  }

  static String getWeatherIcon(String? id) => switch (id) {
    '01d' ||
    '02d' ||
    '03d' ||
    '04d' ||
    '09d' ||
    '10d' ||
    '11d' ||
    '13d' ||
    '50d' ||
    '01n' ||
    '02n' ||
    '03n' ||
    '04n' ||
    '09n' ||
    '10n' ||
    '11n' ||
    '13n' ||
    '50n' => 'assets/icons/$id.svg',
    _ => 'assets/icons/null.svg',
  };

  static String getWeatherCondition(int id) {
    if (id >= 200 && id <= 232) {
      return 'Thunderstorm';
    } else if (id >= 300 && id <= 321) {
      return 'Drizzle';
    } else if (id >= 500 && id <= 531) {
      return 'Rain';
    } else if (id >= 600 && id <= 622) {
      return 'Snow';
    } else if (id == 701 || id == 721 || id == 741) {
      return 'Foggy';
    } else if (id == 711) {
      return 'Smoky';
    } else if (id == 731 || id == 761) {
      return 'Dusty';
    } else if (id == 751) {
      return 'Sandstorm';
    } else if (id == 762) {
      return 'Volcanic Ash';
    } else if (id == 771) {
      return 'Squall';
    } else if (id == 781) {
      return 'Tornado';
    } else if (id == 800) {
      return 'Clear';
    } else if (id == 801 || id == 802) {
      return 'Partly Cloudy';
    } else if (id == 803 || id == 804) {
      return 'Overcast';
    } else {
      return 'N/A';
    }
  }

  static String getWeatherDescription(int id) => switch (id) {
    200 => 'Thunderstorm with light rain',
    201 => 'Thunderstorm with rain',
    202 => 'Thunderstorm with heavy rain',
    210 => 'Light thunderstorm',
    211 => 'Thunderstorm',
    212 => 'Heavy thunderstorm',
    221 => 'Ragged thunderstorm',
    230 => 'Thunderstorm with light drizzle',
    231 => 'Thunderstorm with drizzle',
    232 => 'Thunderstorm with heavy drizzle',
    300 => 'Light intensity drizzle',
    301 => 'Drizzle',
    302 => 'Heavy intensity drizzle',
    310 => 'Light intensity drizzle rain',
    311 => 'Drizzle rain',
    312 => 'Heavy intensity drizzle rain',
    313 => 'Shower rain and drizzle',
    314 => 'Heavy shower rain and drizzle',
    321 => 'Shower drizzle',
    500 => 'Light rain',
    501 => 'Moderate rain',
    502 => 'Heavy intensity rain',
    503 => 'Very heavy rain',
    504 => 'Extreme rain',
    511 => 'Freezing rain',
    520 => 'Light intensity shower rain',
    521 => 'Shower rain',
    522 => 'Heavy intensity shower rain',
    531 => 'Ragged shower rain',
    600 => 'Light snow',
    601 => 'Snow',
    602 => 'Heavy snow',
    611 => 'Sleet',
    612 => 'Light shower sleet',
    613 => 'Shower sleet',
    615 => 'Light rain and snow',
    616 => 'Rain and snow',
    620 => 'Light shower snow',
    621 => 'Shower snow',
    622 => 'Heavy shower snow',
    701 => 'Mist',
    711 => 'Smoke',
    721 => 'Haze',
    731 => 'Sand/dust whirls',
    741 => 'Fog',
    751 => 'Sand',
    761 => 'Dust',
    762 => 'Volcanic ash',
    771 => 'Squall',
    781 => 'Tornado',
    800 => 'Clear sky',
    801 => 'Few clouds: 11-25%',
    802 => 'Scattered clouds: 25-50%',
    803 => 'Broken clouds: 51-84%',
    804 => 'Overcast clouds: 85-100%',
    _ => 'N/A',
  };

  static String getFormattedTime(DateTime? dateTime, String format) {
    return DateFormat(format).format(dateTime ?? DateTime.now().toLocal());
  }

  static String getFormatDT(dynamic dt, String format) {
    if (dt != null) {
      int dt0 = dt;
      return getFormattedTime(dt0.toUnixTime(isUtc: true).toLocal(), format);
    } else {
      return format.replaceAll(RegExp(r'[a-zA-Z]'), '-');
    }
  }

  static String getTimesLong(int dt, int dt2) {
    var from = dt.toUnixTime(isUtc: true).toLocal();
    var to = dt2.toUnixTime(isUtc: true).toLocal();
    var duration = to.difference(from);
    return '${duration.inHours} Hours\n${duration.inMinutes % 60} Minutes';
  }

  static ThemeMode getThemeMode(int value) => switch (value) {
    1 => ThemeMode.light,
    2 => ThemeMode.dark,
    _ => ThemeMode.system,
  };
}
