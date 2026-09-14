import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class WeatherInfo {
  final String temp;
  final String humidity;
  final String wind;
  final String condition;
  final String visibility;
  final String pressure;
  final String station;
  final List<Map<String, String>> warnings;
  final List<Map<String, String>> hourly;
  final List<MapEntry<String, Map<String, dynamic>>> multiDayGrouped;

  WeatherInfo({
    required this.temp,
    required this.humidity,
    required this.wind,
    required this.condition,
    required this.visibility,
    required this.pressure,
    required this.station,
    required this.warnings,
    required this.hourly,
    required this.multiDayGrouped,
  });

  // Getter expected by discover_calgary_page.dart
  String get temperature => temp;

  factory WeatherInfo.fromMap(Map<String, dynamic> map) {
    return WeatherInfo(
      temp: map['temp'] ?? 'N/A',
      humidity: map['humidity'] ?? 'N/A',
      wind: map['wind'] ?? 'N/A',
      condition: map['condition'] ?? 'Cloudy',
      visibility: map['visibility'] ?? 'N/A',
      pressure: map['pressure'] ?? 'N/A',
      station: map['station'] ?? 'Calgary Int\'l Airport',
      warnings: List<Map<String, String>>.from(map['warnings'] ?? []),
      hourly: List<Map<String, String>>.from(map['hourly'] ?? []),
      multiDayGrouped: List<MapEntry<String, Map<String, dynamic>>>.from(map['multiDayGrouped'] ?? []),
    );
  }
}

class WeatherService {
  // Maps text weather descriptions to Material Icons
  static IconData getWeatherIcon(String conditionText) {
    final text = conditionText.toLowerCase();
    if (text.contains('thunder') || text.contains('storm')) {
      return Icons.thunderstorm;
    } else if (text.contains('snow') || text.contains('flurry') || text.contains('blizzard')) {
      return Icons.ac_unit;
    } else if (text.contains('rain') || text.contains('shower') || text.contains('drizzle')) {
      return Icons.water_drop;
    } else if (text.contains('fog') || text.contains('mist') || text.contains('haze')) {
      return Icons.cloud_queue;
    } else if (text.contains('sunny') || text.contains('clear')) {
      return Icons.wb_sunny;
    } else if (text.contains('mix') || text.contains('partly') || text.contains('variable')) {
      return Icons.wb_cloudy;
    } else if (text.contains('cloud') || text.contains('overcast')) {
      return Icons.cloud;
    }
    return Icons.wb_cloudy;
  }

  // Instance method expected by discover_calgary_page.dart
  Future<WeatherInfo> fetchCurrentWeather() async {
    final rawData = await fetchEnvironmentCanadaRSS();
    return WeatherInfo.fromMap(rawData);
  }

  // Restored static method expected by category_forum_page.dart
  static Future<Map<String, dynamic>> fetchEnvironmentCanadaRSS() async {
    final url = Uri.parse(
      'https://dd.weather.gc.ca/today/citypage_weather/AB/02/20260914T025503.085Z_MSC_CitypageWeather_s0000047_en.xml',
    );

    final response = await http.get(url).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final document = xml.XmlDocument.parse(response.body);

      // 0. Warnings & Watches Parse
      final List<Map<String, String>> warningsList = [];
      final warningsNode = document.findAllElements('warnings').firstOrNull;
      if (warningsNode != null) {
        for (var event in warningsNode.findAllElements('event')) {
          final title = event.getAttribute('description') ?? event.findElements('title').firstOrNull?.innerText.trim() ?? 'Weather Alert';
          final urlStr = event.getAttribute('url') ?? '';
          if (title.isNotEmpty && !title.toLowerCase().contains('no watches or warnings')) {
            warningsList.add({
              'title': title,
              'url': urlStr,
            });
          }
        }
      }

      // 1. Current Conditions
      final current = document.findAllElements('currentConditions').firstOrNull;
      final temp = current?.findElements('temperature').firstOrNull?.innerText.trim() ?? 'N/A';
      final humidity = current?.findElements('relativeHumidity').firstOrNull?.innerText.trim() ?? 'N/A';
      final condition = current?.findElements('condition').firstOrNull?.innerText.trim() ?? 'Cloudy';
      final visibility = current?.findElements('visibility').firstOrNull?.innerText.trim() ?? 'N/A';

      final pressureNode = current?.findElements('pressure').firstOrNull;
      final pressureVal = pressureNode?.innerText.trim() ?? 'N/A';
      final pressureTendency = pressureNode?.getAttribute('tendency') ?? '';
      final pressureFormatted = pressureVal != 'N/A'
          ? '$pressureVal kPa${pressureTendency.isNotEmpty ? " ($pressureTendency)" : ""}'
          : 'N/A';

      final windNode = current?.findElements('wind').firstOrNull;
      final windSpeed = windNode?.findElements('speed').firstOrNull?.innerText.trim() ?? 'N/A';
      final windDir = windNode?.findElements('direction').firstOrNull?.innerText.trim() ?? '';
      final windFormatted = windSpeed != 'N/A'
          ? (windDir.isNotEmpty ? '$windDir $windSpeed km/h' : '$windSpeed km/h')
          : 'N/A';

      // 2. Hourly Forecast (24 Hours)
      final List<Map<String, String>> hourlyList = [];
      final hourlyGroup = document.findAllElements('hourlyForecastGroup').firstOrNull;
      if (hourlyGroup != null) {
        for (var h in hourlyGroup.findElements('hourlyForecast')) {
          final time = h.getAttribute('dateTimeUTC') ?? '';
          final conditionText = h.findElements('condition').firstOrNull?.innerText.trim() ?? '';
          final tempVal = h.findElements('temperature').firstOrNull?.innerText.trim() ?? '';
          final popVal = h.findElements('lop').firstOrNull?.innerText.trim() ?? '';

          String formattedTime = time;
          if (time.length >= 12) {
            formattedTime = '${time.substring(8, 10)}:00';
          }

          hourlyList.add({
            'time': formattedTime,
            'condition': conditionText,
            'temp': tempVal.isNotEmpty ? '$tempVal°C' : '',
            'pop': popVal.isNotEmpty && popVal != '0' ? '$popVal%' : '',
          });
        }
      }

      // 3. Multi-Day Forecast Parsing & Grouping by Day
      final forecastGroup = document.findAllElements('forecastGroup').firstOrNull;
      final Map<String, Map<String, dynamic>> groupedDays = {};

      if (forecastGroup != null) {
        final forecasts = forecastGroup.findElements('forecast');
        for (var f in forecasts) {
          final period = f.findElements('period').firstOrNull?.getAttribute('textForecastName') ?? '';
          final summary = f.findElements('textSummary').firstOrNull?.innerText.trim() ?? '';
          final tempNode = f.findElements('temperatures').firstOrNull?.findElements('temperature').firstOrNull;
          final targetTemp = tempNode?.innerText.trim() ?? '';
          final tempClass = tempNode?.getAttribute('class') ?? '';
          final cloudSummary = f.findElements('cloudSummary').firstOrNull?.innerText.trim() ?? summary;

          if (period.isNotEmpty) {
            final isNight = period.toLowerCase().contains('night');
            final dayKey = period.replaceAll(RegExp(r'night', caseSensitive: false), '').trim();

            groupedDays.putIfAbsent(dayKey, () => {'day': null, 'night': null});

            final periodData = {
              'summary': summary,
              'condition': cloudSummary,
              'temp': targetTemp.isNotEmpty ? '$targetTemp°C' : '',
              'tempClass': tempClass,
            };

            if (isNight) {
              groupedDays[dayKey]!['night'] = periodData;
            } else {
              groupedDays[dayKey]!['day'] = periodData;
            }
          }
        }
      }

      return {
        'temp': temp,
        'humidity': humidity,
        'wind': windFormatted,
        'condition': condition,
        'visibility': visibility != 'N/A' ? '$visibility km' : 'N/A',
        'pressure': pressureFormatted,
        'station': 'Calgary Int\'l Airport',
        'warnings': warningsList,
        'hourly': hourlyList,
        'multiDayGrouped': groupedDays.entries.toList(),
      };
    }

    throw Exception('Environment Canada feed returned status ${response.statusCode}');
  }
}