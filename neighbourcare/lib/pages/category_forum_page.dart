import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:xml/xml.dart' as xml;
import '../l10n/app_localizations.dart';

import '../services/auth_service.dart';
import '../services/weather_service.dart';
import '../widgets/top_banner_widget.dart';
import 'login_page.dart';
import 'report_local_conditions_page.dart';
import 'services_booking_page.dart';

class EnvironmentCanadaWeatherBanner extends StatefulWidget {
  const EnvironmentCanadaWeatherBanner({super.key});

  @override
  State<EnvironmentCanadaWeatherBanner> createState() =>
      _EnvironmentCanadaWeatherBannerState();
}

class _EnvironmentCanadaWeatherBannerState
    extends State<EnvironmentCanadaWeatherBanner> {
  late Future<Map<String, dynamic>> _weatherData;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
   // _weatherData = _fetchEnvironmentCanadaRSS();
   _weatherData = WeatherService.fetchEnvironmentCanadaRSS();
  }

  // Maps text weather descriptions to Material Icons
  IconData _getWeatherIcon(String conditionText) {
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

  Future<Map<String, dynamic>> _fetchEnvironmentCanadaRSS() async {
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
            // Clean weekday name by stripping out "night" and extra spaces
            String dayKey;
            final lowerPeriod = period.toLowerCase();
            if (lowerPeriod == 'today' || lowerPeriod == 'tonight') {
              dayKey = lowerPeriod;
            } else if (lowerPeriod.endsWith(' night')) {
              dayKey = period.substring(0, period.length - 6).trim();
            } else {
              dayKey = period.trim();
            }

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _weatherData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    const SizedBox(width: 12),
                    Text(AppLocalizations.of(context)!.updatingWeather),
                  ],
                ),
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return Card(
            color: Theme.of(context).colorScheme.errorContainer,
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Icon(
                    Icons.cloud_off,
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.weatherUpdateUnavailable(snapshot.error.toString()),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final data = snapshot.data ?? {};
        final temp = data['temp'] ?? 'N/A';
        final humidity = data['humidity'] ?? 'N/A';
        final wind = data['wind'] ?? 'N/A';
        final condition = data['condition'] ?? 'N/A';
        final visibility = data['visibility'] ?? 'N/A';
        final pressure = data['pressure'] ?? 'N/A';
        final station = data['station'] ?? AppLocalizations.of(context)!.calgaryIntlAirport;
        final List<Map<String, dynamic>> warnings =
            (data['warnings'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [];
        final List<Map<String, dynamic>> hourly =
            (data['hourly'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [];
        final List<MapEntry<String, Map<String, dynamic>>> multiDayGrouped =
            (data['multiDayGrouped'] as List<dynamic>?)?.cast<MapEntry<String, Map<String, dynamic>>>() ?? [];

        return Card(
          elevation: 2,
          color: Theme.of(context).colorScheme.primaryContainer,
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Active Weather Warnings Banner (if any)
                if (warnings.isNotEmpty) ...[
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade800,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: warnings.map((warning) {
                        return Row(
                          children: [
                            const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                warning['title'] ?? AppLocalizations.of(context)!.weatherAlertIssued,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],

                // Header Line: Location & Condition
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        station,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          _getWeatherIcon(condition),
                          size: 18,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          condition,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Compact Main Metrics
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _getWeatherIcon(condition),
                          size: 40,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          temp != 'N/A' ? '$temp°C' : 'N/A',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(AppLocalizations.of(context)!.weatherHumidity(humidity),
                            style: Theme.of(context).textTheme.bodySmall),
                        Text(AppLocalizations.of(context)!.weatherWind(wind),
                            style: Theme.of(context).textTheme.bodySmall),
                        Text(AppLocalizations.of(context)!.weatherVisPres(visibility, pressure),
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Toggle Expand / Collapse Button
                InkWell(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _isExpanded ? AppLocalizations.of(context)!.hideForecast : AppLocalizations.of(context)!.showFullForecast,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Icon(
                          _isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ),

                // Expanded Section
                if (_isExpanded) ...[
                  const Divider(height: 16),

                  // 1. 24-Hour Hourly Forecast Horizontal Scroll
                  if (hourly.isNotEmpty) ...[
                    Text(
                      AppLocalizations.of(context)!.hourlyForecastTitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 90,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: hourly.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final h = hourly[index];
                          return Container(
                            width: 65,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  h['time'] ?? '',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                Icon(
                                  _getWeatherIcon(h['condition'] ?? ''),
                                  size: 20,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                Text(
                                  h['temp'] ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                if ((h['pop'] ?? '').isNotEmpty)
                                  Text(
                                    h['pop']!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: Colors.blueAccent,
                                          fontSize: 10,
                                        ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // 2. Multi-Day Outlook (Grouped Day Card Blocks)
                  if (multiDayGrouped.isNotEmpty) ...[
                    Text(
                      AppLocalizations.of(context)!.multiDayOutlookTitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: multiDayGrouped.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final entry = multiDayGrouped[index];
                        final weekday = entry.key;
                        final dayData = entry.value['day'] as Map<String, dynamic>?;
                        final nightData = entry.value['night'] as Map<String, dynamic>?;

                        return Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.4),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Weekday Header Title
                              Text(
                                weekday,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                              const Divider(height: 10, thickness: 0.5),

                              // Day Forecast Row
                              if (dayData != null) ...[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.wb_sunny, size: 16, color: Colors.orangeAccent),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        dayData['summary'] ?? '',
                                        style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                    ),
                                    if ((dayData['temp'] ?? '').isNotEmpty) ...[
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.orange.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context)!.weatherHigh(dayData['temp']),
                                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.deepOrange,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],

                              if (dayData != null && nightData != null) const SizedBox(height: 8),

                              // Night Forecast Row
                              if (nightData != null) ...[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.nights_stay, size: 16, color: Colors.indigoAccent),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        nightData['summary'] ?? '',
                                        style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                    ),
                                    if ((nightData['temp'] ?? '').isNotEmpty) ...[
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context)!.weatherLow(nightData['temp']),
                                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blueAccent,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

/// A single top-level page for one forum category ('weather', 'dining',
/// or 'diy'), or, when [category] is null, a combined feed of every category.
class CategoryForumPage extends StatelessWidget {
  final String? category;
  final String title;

  const CategoryForumPage({
    super.key,
    required this.category,
    required this.title,
  });

  static const _postableCategories = ['weather', 'dining', 'diy'];

  static IconData iconFor(String value) {
    switch (value) {
      case 'weather':
        return Icons.cloud_outlined;
      case 'dining':
        return Icons.restaurant_outlined;
      case 'diy':
        return Icons.home_repair_service_outlined;
      default:
        return Icons.forum_outlined;
    }
  }

  static String labelFor(BuildContext context, String value) {
    switch (value) {
      case 'weather':
        return AppLocalizations.of(context)!.weatherUpdate;
      case 'dining':
        return AppLocalizations.of(context)!.diningPost;
      case 'diy':
        return AppLocalizations.of(context)!.diyHomePost;
      default:
        return AppLocalizations.of(context)!.postFallback;
    }
  }

  void _openPostPage(BuildContext context, String targetCategory) {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.signInRequired),
            content: Text(AppLocalizations.of(context)!.signInToCreatePost),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(AppLocalizations.of(context)!.cancel),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                  );
                },
                child: Text(AppLocalizations.of(context)!.signIn),
              ),
            ],
          );
        },
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReportLocalConditionsPage(initialCategory: targetCategory),
      ),
    );
  }

  void _onCreatePost(BuildContext context) {
    if (category != null) {
      _openPostPage(context, category!);
      return;
    }

    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _postableCategories.map((value) {
              return ListTile(
                leading: Icon(iconFor(value)),
                title: Text(labelFor(sheetContext, value)),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _openPostPage(context, value);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBannerWidget(
        title: title,
        onSignInPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _onCreatePost(context),
        icon: const Icon(Icons.add),
        label: Text(category == null ? AppLocalizations.of(context)!.chooseTopicToPost : AppLocalizations.of(context)!.createPost),
      ),
      body: CategoryFeed(category: category),
    );
  }
}

/// Live feed of posts for a single category, or every category when
/// [category] is null.
class CategoryFeed extends StatelessWidget {
  final String? category;

  const CategoryFeed({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    var query = Supabase.instance.client
        .from('forumposts')
        .stream(primaryKey: ['id'])
        .eq('status', 'visible');

    if (category != null) {
      query = query.eq('category', category!);
    }

    final posts = query.order('created_at', ascending: false);

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: posts,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(AppLocalizations.of(context)!.couldNotLoadPostsError(snapshot.error.toString())),
          );
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final posts = snapshot.data!;

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: posts.length + (category == 'weather' ? 1 : 0),
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            // Place the real-time weather widget at top of weather category feed
            if (category == 'weather') {
              if (index == 0) {
                return const EnvironmentCanadaWeatherBanner();
              }
              final postIndex = index - 1;
              return _PostCard(
                key: ValueKey(posts[postIndex]['id']),
                post: posts[postIndex],
                showCategoryChip: category == null,
              );
            }

            if (posts.isEmpty) {
              return Center(
                child: Text(AppLocalizations.of(context)!.noPostsShareFirst),
              );
            }

            return _PostCard(
              key: ValueKey(posts[index]['id']),
              post: posts[index],
              showCategoryChip: category == null,
            );
          },
        );
      },
    );
  }
}

class _PostCard extends StatefulWidget {
  final Map<String, dynamic> post;
  final bool showCategoryChip;

  const _PostCard({
    super.key,
    required this.post,
    required this.showCategoryChip,
  });

  @override
  State<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<_PostCard> {
  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final title = post['title'] ?? '';
    final content = post['content'] ?? '';
    final category = post['category'] ?? '';
    final createdAt = post['created_at'] != null
        ? DateTime.tryParse(post['created_at'].toString())
            ?.toLocal()
            .toString()
            .split('.')
            .first
        : '';

    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.showCategoryChip && category.isNotEmpty) ...[
              Chip(
                label: Text(category.toUpperCase()),
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              const SizedBox(height: 8),
            ],
            if (title.isNotEmpty) ...[
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 6),
            ],
            Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  createdAt ?? '',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
