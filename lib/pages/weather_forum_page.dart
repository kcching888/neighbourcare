import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'login_page.dart';
import 'report_local_conditions_page.dart';
import 'services_booking_page.dart';
import 'provider_portal_page.dart';

class WeatherForumPage extends StatelessWidget {
  const WeatherForumPage({super.key});

  void _openPostPage(BuildContext context, String category) {
    final user = Supabase.instance.client.auth.currentUser;

if (user == null) {
  showDialog<void>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Sign in required'),
        content: const Text(
          'Sign in as a client or provider before creating a community post.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: const Text('Cancel'),
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
            child: const Text('Sign in'),
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
        builder: (_) => ReportLocalConditionsPage(initialCategory: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    return DefaultTabController(
      length: 4,
      child: Builder(
        builder: (context) {
          return Scaffold(
           appBar: AppBar(
  title: const Text('NeighbourCare Community'),
  actions: [
  if (user == null) ...[
    IconButton(
      tooltip: 'Client sign in',
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
      tooltip: 'Provider portal',
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
      tooltip: 'Account',
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

          if (!context.mounted) return;

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
            user.email ?? 'Signed-in member',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<String>(
          value: 'services',
          child: ListTile(
            leading: Icon(Icons.home_repair_service_outlined),
            title: Text('Book services'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const PopupMenuItem<String>(
          value: 'provider',
          child: ListTile(
            leading: Icon(Icons.handyman_outlined),
            title: Text('Provider portal'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<String>(
          value: 'signout',
          child: ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sign out'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
    ),
],
  bottom: const TabBar(
    isScrollable: true,
    tabs: [
      Tab(icon: Icon(Icons.cloud_outlined), text: 'Weather'),
      Tab(icon: Icon(Icons.restaurant_outlined), text: 'Dining'),
      Tab(
        icon: Icon(Icons.home_repair_service_outlined),
        text: 'DIY & Home',
      ),
      Tab(icon: Icon(Icons.forum_outlined), text: 'Community Feeds'),
    ],
  ),
),
            floatingActionButton: AnimatedBuilder(
  animation: DefaultTabController.of(context),
  builder: (context, _) {
    const categories = ['weather', 'dining', 'diy', 'all'];
    final category = categories[DefaultTabController.of(context).index];

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
                      title: const Text('Weather update'),
                      onTap: () {
                        Navigator.pop(sheetContext);
                        _openPostPage(context, 'weather');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.restaurant_outlined),
                      title: const Text('Dining post'),
                      onTap: () {
                        Navigator.pop(sheetContext);
                        _openPostPage(context, 'dining');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.home_repair_service_outlined),
                      title: const Text('DIY & Home post'),
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
        category == 'all' ? 'Choose a topic to post' : 'Create post',
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

  const ForumFeed({super.key, this.category});

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
            child: Text('Could not load posts: ${snapshot.error}'),
          );
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final posts = snapshot.data!;

        if (posts.isEmpty) {
          return const Center(
            child: Text('No community posts yet.'),
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
                      '${post['neighbourhood'] ?? 'Calgary'}',
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
                      'Posted ${post['created_at'] ?? ''}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          final user = Supabase.instance.client.auth.currentUser;

                          if (user == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Sign in to request help from a community post.'),
                              ),
                            );
                            return;
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ServicesBookingPage(
                                forumPostId: post['id']?.toString(),
                                forumPostTitle: post['title']?.toString() ?? 'Community post',
                                forumCategory: post['category']?.toString() ?? 'other',
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.volunteer_activism_outlined),
                        label: const Text('Request help'),
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
        .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }
}