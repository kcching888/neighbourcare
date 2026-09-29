import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/app_localizations.dart';
import '../services/font_size_provider.dart';
import '../services/job_list_service.dart';
import '../services/locale_provider.dart';
import '../widgets/top_banner_widget.dart';
import 'login_page.dart';

class JobListPage extends StatefulWidget {
  const JobListPage({super.key});

  @override
  State<JobListPage> createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  final JobListService _jobService = JobListService();
  late Future<List<JobItem>> _jobsFuture;

  static const List<String> _cjkFontFallback = [
    'AppFallbackFont',
    'Noto Sans SC',
    'Noto Sans TC',
    'Roboto',
    'sans-serif',
  ];

  @override
  void initState() {
    super.initState();
    _jobsFuture = _jobService.fetchCachedJobs();
  }

Future<void> _refreshJobs() async {
  setState(() {
    // Triggers Jooble API fetch -> updates Google Sheet -> returns new JSON list
    _jobsFuture = _jobService.fetchCachedJobs(forceRefresh: true);
  });
  await _jobsFuture;
}

  Future<void> _openJobLink(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }


  /// Helper to clean raw HTML tags and entities frequently found in API snippets
  String _cleanHtmlText(String text) {
    if (text.isEmpty) return '';
    
    var cleaned = text.replaceAll(RegExp(r'<[^>]*>'), '');
    cleaned = cleaned
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>');

    return cleaned.trim();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final fontSizeProvider = Provider.of<FontSizeProvider>(context, listen: false);

    return Scaffold(
      appBar: TopBannerWidget(
        title: t.jobListings,
        fontScale: fontSizeProvider.scaleFactor,
        onLanguageChanged: (locale) => localeProvider.setLocale(locale),
        onFontScaleChanged: (scale) => fontSizeProvider.setScaleFactor(scale),
        onRefresh: _refreshJobs,
        onSignInPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
          );
        },
      ),
      body: RefreshIndicator(
        onRefresh: _refreshJobs,
        child: FutureBuilder<List<JobItem>>(
          future: _jobsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${t.couldNotLoadPosts}: ${snapshot.error}'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _refreshJobs,
                      child: Text(t.retry ?? 'Retry'),
                    ),
                  ],
                ),
              );
            }

            final jobs = snapshot.data ?? [];

            if (jobs.isEmpty) {
              return Center(
                child: Text(t.noCommunityPosts),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: jobs.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final job = jobs[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.company.isNotEmpty ? job.company : job.location,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          job.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        if (job.salary.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            job.salary,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.green[700],
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                        const SizedBox(height: 8),
                        Text(
                          job.snippet,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: OutlinedButton.icon(
                            onPressed: () => _openJobLink(job.link),
                            icon: const Icon(Icons.open_in_new),
                            label: Text(t.applyNow ?? 'Apply'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}