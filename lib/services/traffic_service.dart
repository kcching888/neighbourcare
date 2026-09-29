import 'dart:convert';

import 'package:http/http.dart' as http;

class TrafficIncident {
  final String incidentInfo;
  final String description;
  final String quadrant;
  final DateTime? startDateTime;
  final DateTime? modifiedDateTime;
  final double? latitude;
  final double? longitude;

  const TrafficIncident({
    required this.incidentInfo,
    required this.description,
    required this.quadrant,
    required this.startDateTime,
    required this.modifiedDateTime,
    required this.latitude,
    required this.longitude,
  });

  factory TrafficIncident.fromJson(Map<String, dynamic> json) {
    return TrafficIncident(
      incidentInfo: (json['incident_info'] as String? ?? '').trim(),
      description: (json['description'] as String? ?? '').trim(),
      quadrant: (json['quadrant'] as String? ?? '').trim(),
      startDateTime: DateTime.tryParse(json['start_dt'] as String? ?? ''),
      modifiedDateTime:
          DateTime.tryParse(json['modified_dt'] as String? ?? ''),
      latitude: double.tryParse(json['latitude']?.toString() ?? ''),
      longitude: double.tryParse(json['longitude']?.toString() ?? ''),
    );
  }
}

class TrafficService {
  static final _endpoint = Uri.parse(
    'https://data.calgary.ca/resource/4jah-h97u.json'
    '?\$limit=50'
    '&\$order=modified_dt%20DESC',
  );

  Future<List<TrafficIncident>> fetchCurrentIncidents() async {
    final response = await http.get(_endpoint);

    if (response.statusCode != 200) {
      throw Exception(
        'Could not load Calgary traffic incidents '
        '(HTTP ${response.statusCode}).',
      );
    }

    final decoded = jsonDecode(response.body);

    if (decoded is! List) {
      throw const FormatException(
        'Unexpected traffic data format.',
      );
    }

    return decoded
        .whereType<Map<String, dynamic>>()
        .map(TrafficIncident.fromJson)
        .toList();
  }
}