import 'dart:convert';
import 'package:http/http.dart' as http;

class JoobleJob {
  final String title;
  final String location;
  final String snippet;
  final String type;
  final String link;
  final String company;
  final String updated;

  JoobleJob({
    required this.title,
    required this.location,
    required this.snippet,
    required this.type,
    required this.link,
    required this.company,
    required this.updated,
  });

  factory JoobleJob.fromJson(Map<String, dynamic> json) {
    return JoobleJob(
      title: json['title'] ?? 'No Title',
      location: json['location'] ?? 'Calgary, AB',
      snippet: (json['snippet'] ?? '').replaceAll(RegExp(r'<[^>]*>'), ''), // Strips HTML tags
      type: json['type'] ?? 'Full-time',
      link: json['link'] ?? '',
      company: json['company'] ?? 'Unknown Company',
      updated: json['updated'] ?? '',
    );
  }
}

class JoobleService {
  static const String _apiKey = 'ef29e073-a5b7-45bb-aadd-ccb8e19c41db'; // Replace with your Jooble API key
  static const String _baseUrl = 'https://jooble.org/api/';

  static Future<List<JoobleJob>> fetchCalgaryJobs({String keywords = ''}) async {
    final url = Uri.parse('$_baseUrl$_apiKey');
    
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'keywords': keywords,
        'location': 'Calgary, AB',
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> jobsJson = data['jobs'] ?? [];
      return jobsJson.map((json) => JoobleJob.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load job listings from Jooble');
    }
  }
}