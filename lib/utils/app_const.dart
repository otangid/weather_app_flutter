import 'package:material_ui/material_ui.dart';
import 'package:weather_app_flutter/utils/app_util.dart';

const bgLight = 'assets/images/bg_light.png';
const bgDark = 'assets/images/bg_dark.png';
const owmLogo = 'assets/icons/openweather.svg';
const owm = 'assets/images/owm.png';

const themeModeL = ['System', 'Light', 'Dark'];
const themeModeValueL = [0, 1, 2];
const cacheIntL = ['5 Minute', '15 Minute', '30 Minute', '60 Minute'];
const cacheIntValueL = [5, 15, 30, 60];

const degChar = '\u00b0';
const degCelcius = '\u2103';
const degFahrenheit = '\u2109';
const degKelvin = '\u212a';
const dotChar = '\u2022';

const tempUnitL = [degCelcius, degFahrenheit, degKelvin];
const tempUnitValueL = [0, 1, 2];
const distUnitL = ['km', 'mi'];
const distUnitValueL = [0, 1];
const speedUnitL = ['m/s', 'km/h', 'mph'];
const speedUnitValueL = [0, 1, 2];
const pressUnitL = ['hPa', 'inHg', 'mmHg'];
const pressUnitValueL = [0, 1, 2];

Color aqiColor1 = AppUtil.hexColor('#63BB94');
Color aqiColor2 = AppUtil.hexColor('#A7CE6B');
Color aqiColor3 = AppUtil.hexColor('#FBC55F');
Color aqiColor4 = AppUtil.hexColor('#FE863E');
Color aqiColor5 = AppUtil.hexColor('#FE3F3E');

const limits = <String, List<double>>{
  'so2': [20, 80, 250, 350],
  'no2': [40, 70, 150, 200],
  'pm10': [20, 50, 100, 200],
  'pm2.5': [10, 25, 50, 75],
  'o3': [60, 100, 140, 180],
  'co': [4400, 9400, 12400, 15400],
};

final aqiColors = [aqiColor1, aqiColor2, aqiColor3, aqiColor4, aqiColor5];
const aqiLabels = ['Good', 'Fair', 'Moderate', 'Poor', 'Very Poor'];
const refMax = {'nh3': 200.0, 'no': 100.0};

const aqiLv1Title = 'Good';
const aqiLv2Title = 'Fair';
const aqiLv3Title = 'Moderate';
const aqiLv4Title = 'Poor';
const aqiLv5Title = 'Very Poor';

const aqiLv1Desc = 'Air quality is ideal for most people. Enjoy outdoor activities comfortably.';
const aqiLv2Desc =
    'Air quality is acceptable for most people. However, sensitive groups may experience mild to moderate symptoms from long-term exposure.';
const aqiLv3Desc =
    'Air quality is unhealthy for sensitive groups. Reduce outdoor activities if you have difficulty breathing or throat irritation.';
const aqiLv4Desc =
    'Sensitive groups may feel health effects immediately, and healthy people may have breathing difficulty or throat irritation with prolonged exposure. Limit outdoor activities.';
const aqiLv5Desc =
    'Sensitive groups will feel health effects immediately and should avoid outdoor activities. Healthy people may also have breathing difficulty or throat irritation. Stay indoors if possible.';

const PM25 =
    'Fine particulate matter (PM2.5) is made of inhalable particles smaller than 2.5 micrometers. They can reach deep into the lungs and bloodstream, mainly affecting the lungs and heart. Exposure can cause coughing, difficulty breathing, severe asthma, and chronic respiratory disease.';
const PM10 =
    'Particulate matter (PM10) is made of inhalable particles smaller than 10 micrometers. Particles larger than 2.5 micrometers tend to settle in the airways. Exposure can cause eye and throat irritation, coughing, difficulty breathing, and severe asthma. Frequent or prolonged exposure can lead to more serious health effects.';
const SO2 = 'Sulfur dioxide can irritate the throat and eyes and worsen asthma and chronic bronchitis.';
const NO2 =
    'Breathing in large amounts of nitrogen dioxide increases the risk of respiratory problems. Coughing and difficulty breathing are common, and longer exposure can lead to more serious issues such as respiratory infections.';
const O3 =
    'Ground-level ozone can worsen existing respiratory conditions and cause throat irritation, headaches, and chest pain.';
const CO =
    'Carbon monoxide is a colorless, odorless gas. Breathing in large amounts can cause headaches, nausea, dizziness, and vomiting. Repeated long-term exposure can contribute to heart disease.';
const NH3 =
    'At low concentrations, ammonia can irritate the airways and cause coughing. At high concentrations, it can burn the nose, throat, and respiratory tract, leading to airway damage, severe shortness of breath, and even respiratory failure.';
const NO =
    'Nitric oxide converts into harmful gases such as nitrogen dioxide, which can irritate the respiratory system. Breathing in large amounts can be dangerous and may affect the nervous system.';
