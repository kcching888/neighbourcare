import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import '../services/locale_provider.dart';
import '../services/font_size_provider.dart';
import '../widgets/top_banner_widget.dart';

import 'login_page.dart';
import 'provider_portal_page.dart';
import 'report_local_conditions_page.dart';
import 'services_booking_page.dart';

class WeatherForumPage extends StatelessWidget {
  const WeatherForumPage({super.key});

  void _openPostPage(BuildContext context, String category) {
    final t = AppLocalizations.of(context)!;
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(t.signInRequired),
            content: Text(t.signInToCreatePost),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: Text(t.cancel),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.pop(dialogContext);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginPage(),
                    ),
                  );
                },
                child: Text(t.signIn),
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
        builder: (_) => ReportLocalConditionsPage(
          initialCategory: category,
        ),
      ),
    );
  }

 @override
Widget build(BuildContext context) {
  final t = AppLocalizations.of(context)!;
  final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
  final fontSizeProvider = Provider.of<FontSizeProvider>(context, listen: false);

  return DefaultTabController(
    length: 4,
    child: Builder(
      builder: (context) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight + const TabBar(tabs: []).preferredSize.height + 26.0),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TopBannerWidget(
                  title: t.neighbourCareCommunity,
                  fontScale: fontSizeProvider.scaleFactor,
                  onLanguageChanged: (locale) => localeProvider.setLocale(locale),
                  onFontScaleChanged: (scale) => fontSizeProvider.setScaleFactor(scale),
                  onRefresh: () {

  },
                  onSignInPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                    );
                  },
                ),
                TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(
                      icon: const Icon(Icons.cloud_outlined),
                      text: t.weather,
                    ),
                    Tab(
                      icon: const Icon(Icons.restaurant_outlined),
                      text: t.dining,
                    ),
                    Tab(
                      icon: const Icon(Icons.home_repair_service_outlined),
                      text: t.diyHome,
                    ),
                    Tab(
                      icon: const Icon(Icons.forum_outlined),
                      text: t.communityFeeds,
                    ),
                  ],
                ),
              ],
            ),
          ),
            floatingActionButton: AnimatedBuilder(
              animation: DefaultTabController.of(context),
              builder: (context, _) {
                const categories = ['weather', 'dining', 'diy', 'all'];
                final category =
                    categories[DefaultTabController.of(context).index];

                return FloatingActionButton.extended(
                  onPressed: () {
                    if (category == 'all') {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (sheetContext) {
                          return SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.cloud_outlined),
                                  title: Text(t.weatherUpdate),
                                  onTap: () {
                                    Navigator.pop(sheetContext);
                                    _openPostPage(context, 'weather');
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(
                                    Icons.restaurant_outlined,
                                  ),
                                  title: Text(t.diningPost),
                                  onTap: () {
                                    Navigator.pop(sheetContext);
                                    _openPostPage(context, 'dining');
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(
                                    Icons.home_repair_service_outlined,
                                  ),
                                  title: Text(t.diyHomePost),
                                  onTap: () {
                                    Navigator.pop(sheetContext);
                                    _openPostPage(context, 'diy');
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                      return;
                    }

                    _openPostPage(context, category);
                  },
                  icon: const Icon(Icons.add),
                  label: Text(
                    category == 'all'
                        ? t.chooseTopicToPost
                        : t.createPost,
                  ),
                );
              },
            ),
            body: const TabBarView(
              children: [
                ForumFeed(category: 'weather'),
                ForumFeed(category: 'dining'),
                ForumFeed(category: 'diy'),
                ForumFeed(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ForumFeed extends StatelessWidget {
  final String? category;

  const ForumFeed({
    super.key,
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

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
            child: Text('${t.couldNotLoadPosts}: ${snapshot.error}'),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final posts = snapshot.data!;

        if (posts.isEmpty) {
          return Center(
            child: Text(t.noCommunityPosts),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: posts.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final post = posts[index];

            final categoryName = (post['category'] ?? 'community')
                .toString()
                .replaceAll('_', ' ');

            final alertName = (post['alert_type'] ?? categoryName)
                .toString()
                .replaceAll('_', ' ');

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_label(alertName)} • '
                      '${post['neighbourhood'] ?? t.calgary}',
                      style: Theme.of(context).textTheme.labelLarge,
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
                      '${t.posted} ${post['created_at'] ?? ''}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          final user =
                              Supabase.instance.client.auth.currentUser;

                          if (user == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  t.signInToRequestHelp,
                                ),
                              ),
                            );
                            return;
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ServicesBookingPage(
                                forumPostId: post['id']?.toString(),
                                forumPostTitle:
                                    post['title']?.toString() ??
                                        t.communityPost,
                                forumCategory:
                                    post['category']?.toString() ?? 'other',
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.volunteer_activism_outlined,
                        ),
                        label: Text(t.requestHelp),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _label(String value) {
    return value
        .split(' ')
        .where((word) => word.isNotEmpty)
        .map(
          (word) => '${word[0].toUpperCase()}${word.substring(1)}',
        )
        .join(' ');
  }
}