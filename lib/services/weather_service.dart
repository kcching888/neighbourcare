import 'dart:convert';
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
      warnings: List<Map<String, String>>.from(
        (map['warnings'] as List<dynamic>? ?? []).map(
          (e) => Map<String, String>.from(e as Map),
        ),
      ),
      hourly: List<Map<String, String>>.from(
        (map['hourly'] as List<dynamic>? ?? []).map(
          (e) => Map<String, String>.from(e as Map),
        ),
      ),
      multiDayGrouped: map['multiDayGrouped'] is List
          ? List<MapEntry<String, Map<String, dynamic>>>.from(
              (map['multiDayGrouped'] as List).map((e) {
                if (e is MapEntry<String, Map<String, dynamic>>) return e;
                if (e is MapEntry) {
                  return MapEntry(
                    e.key.toString(),
                    Map<String, dynamic>.from(e.value as Map),
                  );
                }
                throw ArgumentError('Invalid multiDayGrouped element');
              }),
            )
          : [],
    );
  }
}

class WeatherService {
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

  // Accepts language parameter to request correct feed version
  Future<WeatherInfo> fetchCurrentWeather({String lang = 'en'}) async {
    final rawData = await fetchEnvironmentCanadaRSS(lang: lang);
    return WeatherInfo.fromMap(rawData);
  }

  static Future<Map<String, dynamic>> fetchEnvironmentCanadaRSS({String lang = 'en'}) async {
    // Pass language parameter to your worker proxy if supported (e.g. ?lang=fr)
    final url = Uri.parse(
      'https://nbcare-weather-proxy.kcching888.workers.dev/?lang=$lang',
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
          if (title.isNotEmpty && !title.toLowerCase().contains('no watches') && !title.toLowerCase().contains('aucun avertissement')) {
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
          final summary = f.findElements('textSummary').firstOrNull?.innerText.trim() ?? f.findElements('textSummary').firstOrNull?.innerText.trim() ?? '';
          final tempNode = f.findElements('temperatures').firstOrNull?.findElements('temperature').firstOrNull;
          final targetTemp = tempNode?.innerText.trim() ?? '';
          final tempClass = tempNode?.getAttribute('class') ?? '';
          final cloudSummary = f.findElements('cloudSummary').firstOrNull?.innerText.trim() ?? summary;

          if (period.isNotEmpty) {
            final lowerPeriod = period.toLowerCase();
            final isNight = lowerPeriod.contains('night') || lowerPeriod.contains('nuit');

            // "Tonight" is the night counterpart of "Today" - group it under
            // the same key, the same way "Monday night" groups with "Monday".
            final normalizedPeriod = lowerPeriod == 'tonight' ? 'Today' : period;

            // Clean common day/night suffixes across English and French.
            // Word boundaries (\b) are required here: without them, this
            // regex would also match the "night" inside the word "Tonight"
            // itself, turning it into "To".
            final dayKey = normalizedPeriod
                .replaceAll(RegExp(r'\b(night|nuit)\b', caseSensitive: false), '')
                .trim();

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