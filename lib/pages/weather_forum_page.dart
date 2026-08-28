import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../l10n/app_localizations.dart';
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
    final user = Supabase.instance.client.auth.currentUser;

    return DefaultTabController(
      length: 4,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(t.neighbourCareCommunity),
              actions: [
                if (user == null) ...[
                  IconButton(
                    tooltip: t.clientSignIn,
                    icon: const Icon(Icons.person_outline),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    tooltip: t.providerPortal,
                    icon: const Icon(Icons.handyman_outlined),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(
                            openProviderPortal: true,
                          ),
                        ),
                      );
                    },
                  ),
                ] else
                  PopupMenuButton<String>(
                    tooltip: t.account,
                    icon: const Icon(Icons.person_outline),
                    onSelected: (value) async {
                      if (value == 'services') {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ServicesBookingPage(),
                          ),
                          (route) => false,
                        );
                        return;
                      }

                      if (value == 'provider') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProviderPortalPage(),
                          ),
                        );
                        return;
                      }

                      if (value == 'signout') {
                        await Supabase.instance.client.auth.signOut();

                        if (!context.mounted) {
                          return;
                        }

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const WeatherForumPage(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem<String>(
                        enabled: false,
                        child: Text(
                          user.email ?? t.signedInMember,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const PopupMenuDivider(),
                      PopupMenuItem<String>(
                        value: 'services',
                        child: ListTile(
                          leading: const Icon(
                            Icons.home_repair_service_outlined,
                          ),
                          title: Text(t.bookServices),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'provider',
                        child: ListTile(
                          leading: const Icon(Icons.handyman_outlined),
                          title: Text(t.providerPortal),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      const PopupMenuDivider(),
                      PopupMenuItem<String>(
                        value: 'signout',
                        child: ListTile(
                          leading: const Icon(Icons.logout),
                          title: Text(t.signOut),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
              ],
              bottom: TabBar(
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