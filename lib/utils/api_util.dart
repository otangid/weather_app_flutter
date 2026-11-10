class ApiUtil {
  static var BASE_URL = 'https://api.openweathermap.org';
  static var ONECALL = '/data/3.0/onecall?';
  static var AQI = '/data/2.5/air_pollution?';
  static var AQI_FORECAST = '/data/2.5/air_pollution/forecast?';

  static String getUrl({required double lat, required double lon, required String apiKey}) {
    return '$BASE_URL${ONECALL}lat=$lat&lon=$lon&appid=$apiKey&units=metric';
  }

  static String getAqiUrl({required double lat, required double lon, required String apiKey}) {
    return '$BASE_URL${AQI}lat=$lat&lon=$lon&appid=$apiKey';
  }

  static String getAqiForeUrl({required double lat, required double lon, required String apiKey}) {
    return '$BASE_URL${AQI_FORECAST}lat=$lat&lon=$lon&appid=$apiKey';
  }
}
