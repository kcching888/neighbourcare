import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class JobItem {
  final String id;
  final String title;
  final String company;
  final String location;
  final String salary;
  final String type;
  final String snippet;
  final String link;

  JobItem({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.type,
    required this.snippet,
    required this.link,
  });

  factory JobItem.fromJson(Map<String, dynamic> json) {
    return JobItem(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      company: json['company']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      salary: json['salary']?.toString() ?? '',
      type: json['type']?.toString() ?? 'Full-time',
      snippet: json['snippet']?.toString() ?? '',
      link: json['link']?.toString() ?? '',
    );
  }
}

class JobListService {
  static const String _webAppUrl =
      'https://script.google.com/macros/s/AKfycbxv1SqmOjiATjXrXCbWWuhKJ8UMfilrkgo7pWOwEGRVpSI01OTHATcnGAhBFCstog-d/exec';

  Future<List<JobItem>> fetchCachedJobs({bool forceRefresh = false}) async {
    final String requestUrl = forceRefresh ? '$_webAppUrl?action=refresh' : _webAppUrl;

    try {
      // Use Client to handle redirects properly
      final client = http.Client();
      final request = http.Request('GET', Uri.parse(requestUrl))
        ..followRedirects = true
        ..maxRedirects = 5;

      final streamedResponse = await client.send(request);
      final response = await http.Response.fromStream(streamedResponse);
/*
      if (kDebugMode) {
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
*/
      if (response.statusCode == 200) {
        if (response.body.isEmpty || response.body.trim() == '[]') {
          return [];
        }

        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((item) => JobItem.fromJson(item)).toList();
      } else {
        throw Exception('Server returned status code: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching jobs: $e');
      }
      rethrow;
    }
  }
}