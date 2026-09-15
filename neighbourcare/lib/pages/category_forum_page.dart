import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:xml/xml.dart' as xml;
import '../l10n/app_localizations.dart';

import '../services/auth_service.dart';
import '../services/locale_provider.dart';
import '../services/font_size_provider.dart';
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
    final localeProvider = Provider.of<LocaleProvider>(context);
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);

    return Scaffold(
      appBar: TopBannerWidget(
        title: title,
        fontScale: fontSizeProvider.scaleFactor,
        onLanguageChanged: (locale) {
          localeProvider.setLocale(locale);
        },
        onFontScaleChanged: (scale) {
          fontSizeProvider.setScaleFactor(scale);
        },
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

        final fetchedPosts = snapshot.data!;
        final bool isWeatherCategory = category == 'weather';

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: fetchedPosts.length + (isWeatherCategory ? 1 : 0),
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            // Place the real-time weather widget at top of weather category feed
            if (isWeatherCategory) {
              if (index == 0) {
                return const EnvironmentCanadaWeatherBanner();
              }
              final postIndex = index - 1;
              
              if (fetchedPosts.isEmpty) {
                return Center(
                  child: Text(AppLocalizations.of(context)!.noPostsShareFirst),
                );
              }

              return _PostCard(
                key: ValueKey(fetchedPosts[postIndex]['id']),
                post: fetchedPosts[postIndex],
                showCategoryChip: category == null,
              );
            }

            if (fetchedPosts.isEmpty) {
              return Center(
                child: Text(AppLocalizations.of(context)!.noPostsShareFirst),
              );
            }

            return _PostCard(
              key: ValueKey(fetchedPosts[index]['id']),
              post: fetchedPosts[index],
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
  bool _repliesExpanded = false;
  final _replyController = TextEditingController();
  bool _sendingReply = false;
  late final Stream<List<Map<String, dynamic>>> _repliesStream;

  @override
  void initState() {
    super.initState();
    _repliesStream = Supabase.instance.client
        .from('forum_replies')
        .stream(primaryKey: ['id'])
        .eq('post_id', widget.post['id'])
        .order('created_at', ascending: true);
  }

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  String _label(String value) {
    return value
        .split(' ')
        .where((word) => word.isNotEmpty)
        .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }

  void _requestHelp() {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.signInToRequestHelp)),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ServicesBookingPage(
          forumPostId: widget.post['id']?.toString(),
          forumPostTitle: widget.post['title']?.toString() ?? AppLocalizations.of(context)!.communityPost,
          forumCategory: widget.post['category']?.toString() ?? 'other',
        ),
      ),
    );
  }

  Future<void> _sendReply() async {
    final content = _replyController.text.trim();
    if (content.isEmpty) return;

    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.signInToReply)),
      );
      return;
    }

    setState(() => _sendingReply = true);

    final authService = context.read<AuthService>();
    final authorLoginName = authService.loginName ?? authService.email ?? AppLocalizations.of(context)!.memberFallback;

    try {
      await Supabase.instance.client.from('forum_replies').insert({
        'post_id': widget.post['id'],
        'author_id': user.id,
        'author_login_name': authorLoginName,
        'content': content,
      });
      _replyController.clear();
    } on PostgrestException catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.couldNotSendReply(error.message))),
      );
    } finally {
      if (mounted) setState(() => _sendingReply = false);
    }
  }

  Widget _buildReplies(AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
    final items = snapshot.data ?? const [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 24),
        if (snapshot.hasError)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              AppLocalizations.of(context)!.couldNotLoadReplies(snapshot.error.toString()),
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          )
        else if (snapshot.connectionState == ConnectionState.waiting && items.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Center(child: CircularProgressIndicator()),
          )
        else if (items.isEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(AppLocalizations.of(context)!.noRepliesYet),
          )
        else
          Column(
            children: items.map((reply) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (reply['author_login_name'] ?? AppLocalizations.of(context)!.memberFallback).toString(),
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      reply['content'] ?? '',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${reply['created_at'] ?? ''}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _replyController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.writeAReplyHint,
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
                minLines: 1,
                maxLines: 3,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: _sendingReply ? null : _sendReply,
              icon: _sendingReply
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final categoryName = (post['category'] ?? 'community').toString().replaceAll('_', ' ');
    final alertName = (post['alert_type'] ?? categoryName).toString().replaceAll('_', ' ');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${_label(alertName)} • ${post['neighbourhood'] ?? 'Calgary'}',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                if (widget.showCategoryChip)
                  Chip(
                    label: Text(_label(categoryName)),
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              post['title'] ?? '',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(post['content'] ?? ''),
            const SizedBox(height: 12),
            Text(
              AppLocalizations.of(context)!.postedOn((post['created_at'] ?? '').toString()),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: _repliesStream,
              builder: (context, repliesSnapshot) {
                final replyCount = repliesSnapshot.data?.length ?? 0;
                final replyLabel = _repliesExpanded
                    ? AppLocalizations.of(context)!.hideReplies
                    : AppLocalizations.of(context)!.replyAction;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            setState(() => _repliesExpanded = !_repliesExpanded);
                          },
                          icon: Icon(
                            _repliesExpanded ? Icons.expand_less : Icons.chat_bubble_outline,
                          ),
                          label: Text(
                            replyCount > 0 ? '$replyLabel ($replyCount)' : replyLabel,
                          ),
                        ),
                        const Spacer(),
                        OutlinedButton.icon(
                          onPressed: _requestHelp,
                          icon: const Icon(Icons.volunteer_activism_outlined),
                          label: Text(AppLocalizations.of(context)!.requestHelp),
                        ),
                      ],
                    ),
                    if (_repliesExpanded) _buildReplies(repliesSnapshot),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}