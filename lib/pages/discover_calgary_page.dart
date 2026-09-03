import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import '../services/locale_provider.dart';

import '../services/traffic_service.dart';
import 'login_page.dart';
import 'traffic_page.dart';
import 'local_savings_page.dart';
import 'weather_forum_page.dart';
import 'housing_page.dart';

class DiscoverCalgaryPage extends StatefulWidget {
  const DiscoverCalgaryPage({super.key});

  @override
  State<DiscoverCalgaryPage> createState() => _DiscoverCalgaryPageState();
}

class _DiscoverCalgaryPageState extends State<DiscoverCalgaryPage> {
  final _trafficService = TrafficService();

  late Future<List<TrafficIncident>> _trafficFuture;

  @override
  void initState() {
    super.initState();
    _trafficFuture = _trafficService.fetchCurrentIncidents();
  }

  Future<void> _refresh() async {
    setState(() {
      _trafficFuture = _trafficService.fetchCurrentIncidents();
    });

    await _trafficFuture;
  }

  void _openTrafficPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const TrafficPage(),
      ),
    );
  }

void _openLocalSavingsPage() {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const LocalSavingsPage(),
    ),
  );
}

void _openCommunityPage() {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const WeatherForumPage(),
    ),
  );
}

void _openHousingPage() {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const HousingPage(),
    ),
  );
}

  void _showComingSoon(String featureName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$featureName is coming soon.'),
      ),
    );
  }

  String _formatTime(DateTime? value) {
    if (value == null) {
      return 'Update time unavailable';
    }

    final local = value.toLocal();
    final hour = local.hour % 12 == 0 ? 12 : local.hour % 12;
    final minute = local.minute.toString().padLeft(2, '0');
    final period = local.hour >= 12 ? 'PM' : 'AM';

    return '${local.month}/${local.day} $hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F4),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF092C4C),
        foregroundColor: Colors.white,
        title: Text(
          AppLocalizations.of(context)!.calgaryCommunityHub,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          // Active language indicator text
    Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(
          () {
            final locale = Localizations.localeOf(context);
            if (locale.languageCode == 'zh') {
              return locale.scriptCode == 'Hant' ? '繁' : '简';
            }
            return locale.languageCode.toUpperCase();
          }(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ),
    ),
          PopupMenuButton<Locale>(
  icon: const Icon(Icons.language),
  tooltip: 'Change Language',
  onSelected: (Locale newLocale) {
    context.read<LocaleProvider>().setLocale(newLocale);
  },
  itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
    const PopupMenuItem<Locale>(
      value: Locale('en'),
      child: Text('English'),
    ),
    const PopupMenuItem<Locale>(
      value: Locale('zh'),
      child: Text('简体中文'),
    ),
    const PopupMenuItem<Locale>(
      value: Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
      child: Text('繁體中文'),
    ),
  ],
),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: AppLocalizations.of(context)!.refreshTraffic,
            onPressed: _refresh,
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const LoginPage(),
                ),
              );
            },
            icon: const Icon(Icons.person_outline, color: Colors.white),
            label: Text(
              AppLocalizations.of(context)!.signIn,
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<TrafficIncident>>(
          future: _trafficFuture,
          builder: (context, snapshot) {
            final incidents = snapshot.data ?? [];

            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
children: [
  Container(
    color: const Color(0xFFFFFFFF),
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1050),
        child: Wrap(
          spacing: 18,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Text(
              'Your Calgary community hub',
              style: TextStyle(
                color: Color(0xFF092C4C),
                fontWeight: FontWeight.w700,
              ),
            ),
            _QuickLink(
              label: AppLocalizations.of(context)!.traffic,
              onTap: _openTrafficPage,
            ),
            _QuickLink(
              label: AppLocalizations.of(context)!.savings,
              onTap: _openLocalSavingsPage,
            ),
            _QuickLink(
              label: AppLocalizations.of(context)!.community,
              onTap: _openCommunityPage,
            ),
            _QuickLink(
              label: AppLocalizations.of(context)!.housing,
              onTap: () => _showComingSoon(AppLocalizations.of(context)!.housing),
            ),
          ],
        ),
      ),
    ),
  ),
  _HomeHero(
    onTrafficTap: _openTrafficPage,
  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 28, 16, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Explore NeighbourCare',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: const Color(0xFF092C4C),
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Helpful Calgary information, local connections, and everyday resources in one place.',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 18),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final width = constraints.maxWidth;

                          final crossAxisCount = width >= 1100
                              ? 3
                              : width >= 650
                                  ? 3
                                  : 2;

                          return GridView.count(
                            crossAxisCount: crossAxisCount,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 14,
                            childAspectRatio: width >= 650 ? 1.45 : 1.05,
                            children: [
                              _TrafficHubCard(
                                incidents: incidents,
                                isLoading: snapshot.connectionState == ConnectionState.waiting,
                                onTap: _openTrafficPage,
                              ),
                              _LocalSavingsHubCard(
                                onTap: _openLocalSavingsPage,
                              ),
                              _CommunityHubCard(
                                onTap: _openCommunityPage,
                              ),
                              _HousingHubCard(
                                onTap: _openHousingPage,
                              ),
                              _HubCard(
                                icon: Icons.work_outline,
                                title: 'Jobs & services',
                                subtitle: 'Local opportunities',
                                accentColor: const Color(0xFF176B87),
                                backgroundColor: const Color(0xFFE8F7FA),
                                onTap: () {
                                  _showComingSoon('Jobs & services');
                                },
                              ),
                              _HubCard(
                                icon: Icons.storefront_outlined,
                                title: 'Marketplace',
                                subtitle: 'Buy, sell, and share',
                                accentColor: const Color(0xFF8A5A00),
                                backgroundColor: const Color(0xFFFFF8D9),
                                onTap: () {
                                  _showComingSoon('Marketplace');
                                },
                              ),
                            ],
                          );
                        },
                      ),
 
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFE1E5EA),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.favorite_outline,
                              color: Color(0xFFB54708),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'NeighbourCare brings Calgary neighbours closer '
                                'to useful local information and community resources.',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        'Traffic source: City of Calgary Open Data. '
                        'Confirm conditions before travelling.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _HomeHero extends StatelessWidget {
  final VoidCallback onTrafficTap;

  const _HomeHero({
    required this.onTrafficTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 42, 24, 36),
      decoration: BoxDecoration(
    image: DecorationImage(
      image: const AssetImage('assets/images/calgary_night.jpg'),
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
            Colors.white.withValues(alpha: 0.45), 
            BlendMode.lighten,
    ),
  ),
      
   //   decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF092C4C).withValues(alpha: 0.3),
            Color(0xFF164B75).withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1050),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CALGARY, ALBERTA',
              style: TextStyle(
                color: Color(0xFFA8D9D2),
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.4,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Your local Calgary hub',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    shadows: [
          const Shadow(
            offset: Offset(0, 2),
            blurRadius: 6.0,
            color: Color(0xAA000000), // Semi-transparent black drop shadow
          ),
        ],
                  ),
            ),
            const SizedBox(height: 10),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: Text(
                'Find practical local updates, discover neighbourhood resources, '
                'and stay connected with your community.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.88),
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.w500, // Makes the thinner font weights sharper
      shadows: [
        const Shadow(
          offset: Offset(0, 1),
          blurRadius: 4.0,
          color: Color(0xAA000000), // Clean dark drop shadow for contrast
        ),
      ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            FilledButton.icon(
              onPressed: onTrafficTap,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFA8D9D2),
                foregroundColor: const Color(0xFF092C4C),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
              ),
              icon: const Icon(Icons.map_outlined),
              label: const Text('View traffic map'),
            ),
          ],
        ),
      ),
    );
  }
}

class _HubCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accentColor;
  final Color backgroundColor;
  final bool isLive;
  final VoidCallback onTap;

  const _HubCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.backgroundColor,
    required this.onTap,
    this.isLive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.72),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: accentColor),
                  ),
                  const Spacer(),
                  if (isLive)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'LIVE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                        ),
                      ),
                    )
                  else
                    Icon(
                      Icons.arrow_forward,
                      color: accentColor,
                      size: 19,
                    ),
                ],
              ),
              const Spacer(),
              Text(
                title,
                style: TextStyle(
                  color: const Color(0xFF172033),
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String actionLabel;
  final VoidCallback onAction;

  const _SectionHeader({
    required this.title,
    required this.actionLabel,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: const Color(0xFF092C4C),
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
        TextButton.icon(
          onPressed: onAction,
          icon: const Icon(Icons.map_outlined),
          label: Text(actionLabel),
        ),
      ],
    );
  }
}

class _TrafficPreviewCard extends StatelessWidget {
  final TrafficIncident incident;
  final String formattedTime;
  final VoidCallback onTap;

  const _TrafficPreviewCard({
    required this.incident,
    required this.formattedTime,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final location = incident.incidentInfo.isEmpty
        ? 'Location unavailable'
        : incident.incidentInfo;

    final description = incident.description.isEmpty
        ? 'Traffic incident reported.'
        : incident.description;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(14),
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFFFF0E5),
          child: Icon(
            Icons.warning_amber_rounded,
            color: Color(0xFFB54708),
          ),
        ),
        title: Text(
          location,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            '$description\n'
            '${incident.quadrant.isEmpty ? 'Calgary' : '${incident.quadrant} Calgary'} · Updated $formattedTime',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class _FeedStatusCard extends StatelessWidget {
  final IconData icon;
  final String message;
  final String? actionLabel;
  final Future<void> Function()? onAction;

  const _FeedStatusCard({
    required this.icon,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(
              icon,
              size: 34,
              color: const Color(0xFF0C7A6C),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 10),
              TextButton(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _QuickLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _QuickLink({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 4,
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF265AA6),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _TrafficHubCard extends StatelessWidget {
  final List<TrafficIncident> rawIncidents;
  final bool isLoading;
  final VoidCallback onTap;

  const _TrafficHubCard({
    required List<TrafficIncident> incidents,
    //required this.incidents,
    required this.isLoading,
    required this.onTap,
  }) : rawIncidents = incidents;

  @override
  Widget build(BuildContext context) {
    final validIncidents = rawIncidents.where((item) {
      final text = item.incidentInfo.trim().toLowerCase();
      return text.isNotEmpty &&
             text != 'no traffic incidents' &&
             text != 'no active incidents' &&
             text != 'no incidents' &&
             text != 'none';
    }).toList();

    final previews = validIncidents.take(2).toList();

    return Material(
      color: const Color(0xFFE7F4F1),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.72),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.traffic_outlined,
                      color: Color(0xFF0C7A6C),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0C7A6C),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'LIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Traffic & roads',
                style: TextStyle(
                  color: Color(0xFF172033),
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              if (isLoading)
                const Text(
                  'Loading live updates...',
                  style: TextStyle(fontSize: 12),
                )
              else if (previews.isEmpty)
                const Text(
                  'No active incidents listed.',
                  style: TextStyle(fontSize: 12),
                )
              else
                ...previews.map(
                  (incident) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      '• ${incident.incidentInfo.isEmpty ? 'Traffic incident' : incident.incidentInfo}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF344054),
                      ),
                    ),
                  ),
                ),
              const Spacer(),
              Text(
                isLoading
                    ? 'View details'
                    : validIncidents.isEmpty
                        ? 'No active incidents'
                        : '${validIncidents.length} active incident${validIncidents.length == 1 ? '' : 's'}',
                    
                style: const TextStyle(
                  color: Color(0xFF0C7A6C),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LocalSavingsHubCard extends StatelessWidget {
  final VoidCallback onTap;

  const _LocalSavingsHubCard({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const deals = [
      (
        store: 'Giant Tiger',
        item: 'Gold Label Smoke House Bacon',
        price: '\$3.97',
        savings: '50% off',
        logoPath: 'assets/images/stores/giant_tiger.png',
      ),
      (
        store: 'Walmart',
        item: 'Dairyland Chocolate Milk',
        price: '\$0.98',
        savings: '63% off',
        logoPath: 'assets/images/stores/walmart.png',
      ),
    ];

    const accentColor = Color(0xFFB54708);

    return Material(
      color: const Color(0xFFFFF1E8),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.72),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.sell_outlined,
                      color: accentColor,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward,
                    color: accentColor,
                    size: 19,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Local savings',
                style: TextStyle(
                  color: Color(0xFF172033),
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              ...deals.map(
                (deal) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Container(
  width: 30,
  height: 30,
  padding: const EdgeInsets.all(3),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(7),
    border: Border.all(
      color: const Color(0xFFE8D5C8),
    ),
  ),
  child: Image.asset(
    deal.logoPath,
    fit: BoxFit.contain,
    errorBuilder: (context, error, stackTrace) {
      return const Icon(
        Icons.storefront_outlined,
        color: accentColor,
        size: 16,
      );
    },
  ),
),
const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${deal.item} — ${deal.savings}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF344054),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              const Text(
                'View all grocery deals',
                style: TextStyle(
                  color: accentColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommunityHubCard extends StatelessWidget {
  final VoidCallback onTap;

  const _CommunityHubCard({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final posts = Supabase.instance.client
        .from('forumposts')
        .stream(primaryKey: ['id'])
        .eq('status', 'visible')
        .order('created_at', ascending: false);

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: posts,
      builder: (context, snapshot) {
        final previews = (snapshot.data ?? []).take(2).toList();

        return Material(
          color: const Color(0xFFEFF4FF),
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(18),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.72),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.forum_outlined,
                          color: Color(0xFF265AA6),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF265AA6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'LIVE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Community',
                    style: TextStyle(
                      color: Color(0xFF172033),
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (snapshot.hasError)
                    const Text(
                      'Community updates are unavailable.',
                      style: TextStyle(fontSize: 12),
                    )
                  else if (!snapshot.hasData)
                    const Text(
                      'Loading community updates...',
                      style: TextStyle(fontSize: 12),
                    )
                  else if (previews.isEmpty)
                    const Text(
                      'No community updates yet.',
                      style: TextStyle(fontSize: 12),
                    )
                  else
                    ...previews.map(
                      (post) {
                        final title =
                            post['title']?.toString().trim().isNotEmpty == true
                                ? post['title'].toString()
                                : 'Community update';

                        final neighbourhood =
                            post['neighbourhood']?.toString().trim().isNotEmpty ==
                                    true
                                ? post['neighbourhood'].toString()
                                : 'Calgary';

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            '• $title · $neighbourhood',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF344054),
                            ),
                          ),
                        );
                      },
                    ),
                  const Spacer(),
                  Text(
                    snapshot.hasData
                        ? '${snapshot.data!.length} community update'
                            '${snapshot.data!.length == 1 ? '' : 's'}'
                        : 'View community updates',
                    style: const TextStyle(
                      color: Color(0xFF265AA6),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HousingHubCard extends StatelessWidget {
  final VoidCallback onTap;

  const _HousingHubCard({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xFF6A3EA1);

    return Material(
      color: const Color(0xFFF4EEFF),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.72),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.home_work_outlined,
                      color: accentColor,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward,
                    color: accentColor,
                    size: 19,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Housing & development',
                style: TextStyle(
                  color: Color(0xFF172033),
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Calgary rental vacancy: 5.1%',
                style: TextStyle(
                  color: Color(0xFF344054),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Up from 4.6% in 2024',
                style: TextStyle(
                  color: Color(0xFF344054),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Assessment lookup and permits',
                style: TextStyle(
                  color: Color(0xFF344054),
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              const Text(
                'Explore Calgary housing',
                style: TextStyle(
                  color: accentColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}