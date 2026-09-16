import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import '../services/locale_provider.dart';
import '../services/font_size_provider.dart';
import '../services/traffic_service.dart';
import '../services/local_savings_service.dart';
import '../services/job_list_service.dart';
import '../services/weather_service.dart';


import '../widgets/top_banner_widget.dart';

import 'login_page.dart';
import 'traffic_page.dart';
import 'local_savings_page.dart';
import 'category_forum_page.dart';
import 'housing_page.dart';
import 'job_list_page.dart';

class DiscoverCalgaryPage extends StatefulWidget {
  const DiscoverCalgaryPage({super.key});

  @override
  State<DiscoverCalgaryPage> createState() => _DiscoverCalgaryPageState();
}

class _DiscoverCalgaryPageState extends State<DiscoverCalgaryPage> {
  final _trafficService = TrafficService();
  final _localSavingsService = LocalSavingsService();
  final _weatherService = WeatherService();

  late Future<List<TrafficIncident>> _trafficFuture;
  late Future<List<LocalDeal>> _dealsFuture;
  late Future<WeatherInfo> _weatherFuture;

  @override
  void initState() {
    super.initState();
    _trafficFuture = _trafficService.fetchCurrentIncidents();
    _dealsFuture = _localSavingsService.fetchDeals();
    _weatherFuture = _weatherService.fetchCurrentWeather();
  }

  Future<void> _refresh() async {
    setState(() {
      _trafficFuture = _trafficService.fetchCurrentIncidents();
      _dealsFuture = _localSavingsService.fetchDeals();
      _weatherFuture = _weatherService.fetchCurrentWeather();
    });

    await Future.wait([_trafficFuture, _dealsFuture, _weatherFuture]);
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

  void _openWeatherPosts() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CategoryForumPage(
          category: 'weather',
          title: AppLocalizations.of(context)!.weatherUpdatesTitle,
        ),
      ),
    );
  }

  void _openDiningPosts() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CategoryForumPage(
          category: 'dining',
          title: AppLocalizations.of(context)!.diningPostsTitle,
        ),
      ),
    );
  }

  void _openDiyPosts() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CategoryForumPage(
          category: 'diy',
          title: AppLocalizations.of(context)!.diyHomeTitle,
        ),
      ),
    );
  }

  void _openCommunityPosts() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CategoryForumPage(
          category: null,
          title: AppLocalizations.of(context)!.community,
        ),
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

  void _openJobsPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => JobListPage(),
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

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F4),
      appBar: TopBannerWidget(
        title: AppLocalizations.of(context)?.calgaryCommunityHub ?? 'NeighbourCare',
        fontScale: fontSizeProvider.scaleFactor,
        onLanguageChanged: (locale) {
          localeProvider.setLocale(locale);
        },
        onFontScaleChanged: (scale) {
          fontSizeProvider.setScaleFactor(scale);
        },
        onRefresh: () {
          _refresh();
        },
        onSignInPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const LoginPage()),
          );
        },
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder(
          future: Future.wait([_trafficFuture, _dealsFuture, _weatherFuture]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            final incidents = snapshot.hasData ? (snapshot.data![0] as List<TrafficIncident>) : <TrafficIncident>[];
            final deals = snapshot.hasData ? (snapshot.data![1] as List<LocalDeal>) : <LocalDeal>[];
            final weather = snapshot.hasData ? (snapshot.data![2] as WeatherInfo) : null;

            return LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = constraints.maxWidth;
                final horizontalPadding = screenWidth >= 1200
                    ? 48.0
                    : screenWidth >= 650
                        ? 24.0
                        : 16.0;

                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      color: const Color(0xFFFFFFFF),
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: 12,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: Wrap(
                            spacing: 24,
                            runSpacing: 8,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.calgaryCommunityHub,
                                style: const TextStyle(
                                  color: Color(0xFF092C4C),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
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
                                onTap: _openCommunityPosts,
                              ),
                              _QuickLink(
                                label: AppLocalizations.of(context)!.housing,
                                onTap: _openHousingPage,
                              ),
                              _QuickLink(
                                label: AppLocalizations.of(context)!.jobs,
                                onTap: _openJobsPage,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    _HomeHero(
                      onTrafficTap: _openTrafficPage,
                    ),
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            horizontalPadding,
                            28,
                            horizontalPadding,
                            32,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.exploreNeighbourCare,
                                style: const TextStyle(
                                  color: Color(0xFF092C4C),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 26,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                AppLocalizations.of(context)!.exploreSubtitle,
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  height: 1.4,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 18),
                              LayoutBuilder(
                                builder: (context, gridConstraints) {
                                  final width = gridConstraints.maxWidth;

                                  final crossAxisCount = width >= 1100
                                      ? 3
                                      : width >= 650
                                          ? 2
                                          : 1;

                                  final childAspectRatio = width >= 1100
                                      ? 1.35
                                      : width >= 650
                                          ? 1.3
                                          : 1.6;

                                  return GridView.count(
                                    crossAxisCount: crossAxisCount,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                    childAspectRatio: childAspectRatio,
                                    children: [
                                      _TrafficHubCard(
                                        incidents: incidents,
                                        isLoading: snapshot.connectionState == ConnectionState.waiting,
                                        onTap: _openTrafficPage,
                                      ),
                                      _LocalSavingsHubCard(
                                        deals: deals,
                                        isLoading: snapshot.connectionState == ConnectionState.waiting,
                                        onTap: _openLocalSavingsPage,
                                      ),
                                      _WeatherHubCard(
                                        weather: weather,
                                        isLoading: snapshot.connectionState == ConnectionState.waiting,
                                        onTap: _openWeatherPosts,
                                      ),
                                      _CategoryPreviewHubCard(
                                        category: 'dining',
                                        title: AppLocalizations.of(context)!.diningPostsTitle,
                                        icon: Icons.restaurant_outlined,
                                        accentColor: const Color(0xFF9C4221),
                                        backgroundColor: const Color(0xFFFBEAE3),
                                        onTap: _openDiningPosts,
                                      ),
                                      _CategoryPreviewHubCard(
                                        category: 'diy',
                                        title: AppLocalizations.of(context)!.diyHomeTitle,
                                        icon: Icons.home_repair_service_outlined,
                                        accentColor: const Color(0xFF4D7C0F),
                                        backgroundColor: const Color(0xFFEEF6E2),
                                        onTap: _openDiyPosts,
                                      ),
                                      _CommunityHubCard(
                                        onTap: _openCommunityPosts,
                                      ),
                                      _HousingHubCard(
                                        onTap: _openHousingPage,
                                      ),
                                      _JobHubCard(
                                        onTap: _openJobsPage,
                                      ),
                                      _HubCard(
                                        icon: Icons.storefront_outlined,
                                        title: AppLocalizations.of(context)!.marketplace,
                                        subtitle: AppLocalizations.of(context)!.marketplaceSubtitle,
                                        accentColor: const Color(0xFF8A5A00),
                                        backgroundColor: const Color(0xFFFFF8D9),
                                        onTap: () {
                                          _showComingSoon(AppLocalizations.of(context)!.marketplace);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(height: 24),
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
                                        AppLocalizations.of(context)!.aboutNeighbourCare,
                                        style: TextStyle(
                                          color: Colors.grey.shade700,
                                          height: 1.4,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 18),
                              Text(
                                AppLocalizations.of(context)!.trafficSourceNote,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
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
      padding: const EdgeInsets.fromLTRB(24, 64, 24, 64),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/images/calgary_night.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.white.withValues(alpha: 0.45),
            BlendMode.lighten,
          ),
        ),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF092C4C).withValues(alpha: 0.3),
            const Color(0xFF164B75).withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
AppLocalizations.of(context)!.calgaryAlberta,
                style: TextStyle(
                  color: Color(0xFFA8D9D2),
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.heroTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                      color: Color(0xAA000000),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 620),
                child: Text(
                  AppLocalizations.of(context)!.heroSubtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 1),
                        blurRadius: 4.0,
                        color: Color(0xAA000000),
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
                label: Text(AppLocalizations.of(context)!.getDirections),
              ),
            ],
          ),
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
                      child: Text(
AppLocalizations.of(context)!.live,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
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
                style: const TextStyle(
                  color: Color(0xFF172033),
                  fontWeight: FontWeight.w800,
                  fontSize: 19,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
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
            fontSize: 17,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
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
                        child: Text(
AppLocalizations.of(context)!.live,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.traffic,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF172033),
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (isLoading)
                    Text(
AppLocalizations.of(context)!.loadingLiveUpdates,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14),
                    )
                  else if (previews.isEmpty)
                    Text(
AppLocalizations.of(context)!.noActiveIncidentsListed,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14),
                    )
                  else
                    ...previews.map(
                      (incident) => Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(
                          '• ${incident.incidentInfo.isEmpty ? AppLocalizations.of(context)!.trafficIncidentFallback : incident.incidentInfo}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF344054),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Text(
                isLoading
                    ? AppLocalizations.of(context)!.viewDetails
                    : validIncidents.isEmpty
                        ? AppLocalizations.of(context)!.noActiveIncidents
                        : AppLocalizations.of(context)!.activeIncidentsCount(validIncidents.length),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF0C7A6C),
                  fontSize: 14,
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
  final List<LocalDeal> deals;
  final bool isLoading;
  final VoidCallback onTap;

  const _LocalSavingsHubCard({
    required this.deals,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xFFB54708);
    final previews = deals.take(2).toList(); // Reduced preview count to 2 for large text scaling

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
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
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.deals,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF172033),
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (isLoading && deals.isEmpty)
                    Text(
AppLocalizations.of(context)!.loadingDeals,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14),
                    )
                  else if (deals.isEmpty)
                    Text(
AppLocalizations.of(context)!.noDealsAvailable,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14),
                    )
                  else
                    ...previews.map((deal) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(
                          '• ${deal.store}: ${deal.item} — ${deal.priceLabel}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF344054),
                          ),
                        ),
                      );
                    }),
                ],
              ),
              Text(
                isLoading
                    ? AppLocalizations.of(context)!.viewAllGroceryDeals
                    : deals.isEmpty
                        ? AppLocalizations.of(context)!.noCurrentDeals
                        : AppLocalizations.of(context)!.groceryDealsCount(deals.length),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: accentColor,
                  fontSize: 14,
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

class _HousingHubCard extends StatelessWidget {
  final VoidCallback onTap;

  const _HousingHubCard({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xFF265AA6);

    return Material(
      color: const Color(0xFFEBF3FF),
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
                      Icons.home_outlined,
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
              const Spacer(),
              Text(
                AppLocalizations.of(context)!.housing,
                style: const TextStyle(
                  color: Color(0xFF172033),
                  fontWeight: FontWeight.w800,
                  fontSize: 19,
                ),
              ),
              const SizedBox(height: 5),
              Text(
AppLocalizations.of(context)!.viewLatestStatistics,
                style: TextStyle(
                  color: accentColor,
                  fontSize: 16,
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
        final communityPosts = snapshot.data ?? [];
        final previews = communityPosts.take(2).toList();
        const accentColor = Color(0xFF4A3B8C);

        return Material(
          color: const Color(0xFFF1EFFF),
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
                  Text(
                    AppLocalizations.of(context)!.community,
                    style: const TextStyle(
                      color: Color(0xFF172033),
                      fontWeight: FontWeight.w800,
                      fontSize: 19,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (snapshot.connectionState == ConnectionState.waiting && previews.isEmpty)
                    Text(
AppLocalizations.of(context)!.loadingDiscussions,
                      style: TextStyle(fontSize: 16),
                    )
                  else if (previews.isEmpty)
                    Text(
AppLocalizations.of(context)!.noRecentDiscussions,
                      style: TextStyle(fontSize: 16),
                    )
                  else
                    ...previews.map(
                      (post) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          '• ${post['title'] ?? post['content'] ?? AppLocalizations.of(context)!.discussionFallback}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF344054),
                          ),
                        ),
                      ),
                    ),
                  const Spacer(),
                  Text(
                    communityPosts.isEmpty
                        ? AppLocalizations.of(context)!.joinConversation
                        : AppLocalizations.of(context)!.discussionsCount(communityPosts.length),
                    style: const TextStyle(
                      color: accentColor,
                      fontSize: 16,
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

class _JobHubCard extends StatefulWidget {
  final VoidCallback onTap;

  const _JobHubCard({
    required this.onTap,
  });

  @override
  State<_JobHubCard> createState() => _JobHubCardState();
}

class _JobHubCardState extends State<_JobHubCard> {
  final _jobListService = JobListService();
  late Future<List<JobItem>> _jobsFuture;

  @override
  void initState() {
    super.initState();
    _jobsFuture = _jobListService.fetchCachedJobs();
  }

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xFF176B87);

    return Material(
      color: const Color(0xFFE8F7FA),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<List<JobItem>>(
            future: _jobsFuture,
            builder: (context, snapshot) {
              final jobs = snapshot.data ?? [];
              final previews = jobs.take(2).toList();

              return Column(
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
                          Icons.work_outline,
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
                  Text(
                    AppLocalizations.of(context)!.jobs,
                    style: const TextStyle(
                      color: Color(0xFF172033),
                      fontWeight: FontWeight.w800,
                      fontSize: 19,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (snapshot.connectionState == ConnectionState.waiting && previews.isEmpty)
                    Text(
AppLocalizations.of(context)!.loadingJobs,
                      style: TextStyle(fontSize: 16),
                    )
                  else if (snapshot.hasError)
                    Text(
AppLocalizations.of(context)!.couldNotLoadJobs,
                      style: TextStyle(fontSize: 16),
                    )
                  else if (previews.isEmpty)
                    Text(
AppLocalizations.of(context)!.noJobsFound,
                      style: TextStyle(fontSize: 16),
                    )
                  else
                    ...previews.map(
                      (job) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          '• ${job.title}${job.company.isEmpty ? '' : ' — ${job.company}'}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF344054),
                          ),
                        ),
                      ),
                    ),
                  const Spacer(),
                  Text(
                    jobs.isEmpty ? AppLocalizations.of(context)!.browseOpenings : AppLocalizations.of(context)!.jobOpeningsCount(jobs.length),
                    style: const TextStyle(
                      color: accentColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Live preview tile for a single forum category (weather, dining, diy):
/// shows the category icon/title plus the first two post titles, same
/// pattern as _CommunityHubCard but scoped to one category.
class _CategoryPreviewHubCard extends StatelessWidget {
  final String category;
  final String title;
  final IconData icon;
  final Color accentColor;
  final Color backgroundColor;
  final VoidCallback onTap;

  const _CategoryPreviewHubCard({
    required this.category,
    required this.title,
    required this.icon,
    required this.accentColor,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final posts = Supabase.instance.client
        .from('forumposts')
        .stream(primaryKey: ['id'])
        .eq('status', 'visible')
        .eq('category', category)
        .order('created_at', ascending: false);

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: posts,
      builder: (context, snapshot) {
        final categoryPosts = snapshot.data ?? [];
        final previews = categoryPosts.take(2).toList();

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
                      Icon(
                        Icons.arrow_forward,
                        color: accentColor,
                        size: 19,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF172033),
                      fontWeight: FontWeight.w800,
                      fontSize: 19,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (snapshot.connectionState == ConnectionState.waiting && previews.isEmpty)
                    Text(
AppLocalizations.of(context)!.loadingPosts,
                      style: TextStyle(fontSize: 16),
                    )
                  else if (previews.isEmpty)
                    Text(
AppLocalizations.of(context)!.noRecentPosts,
                      style: TextStyle(fontSize: 16),
                    )
                  else
                    ...previews.map(
                      (post) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          '• ${post['title'] ?? post['content'] ?? AppLocalizations.of(context)!.postFallback}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF344054),
                          ),
                        ),
                      ),
                    ),
                  const Spacer(),
                  Text(
                    categoryPosts.isEmpty
                        ? AppLocalizations.of(context)!.shareAnUpdate
                        : AppLocalizations.of(context)!.categoryPostsCount(categoryPosts.length),
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 16,
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

class _WeatherHubCard extends StatelessWidget {
  final WeatherInfo? weather;
  final bool isLoading;
  final VoidCallback onTap;

  const _WeatherHubCard({
    required this.weather,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xFF186F8A);

    return Material(
      color: const Color(0xFFE6F3F7),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.72),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.cloud_outlined,
                          color: accentColor,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: accentColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.live,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.weatherUpdatesTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF172033),
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (isLoading && weather == null)
                    const Text(
                      'Loading weather...',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14),
                    )
                  else if (weather == null)
                    const Text(
                      'Weather unavailable',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14),
                    )
                  else ...[
                    Text(
                      '• Temp: ${weather!.temperature}°C',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF344054),
                      ),
                    ),
                    Text(
                      '• Condition: ${weather!.condition}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF344054),
                      ),
                    ),
                  ],
                ],
              ),
              Text(
                AppLocalizations.of(context)!.viewDetails,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: accentColor,
                  fontSize: 14,
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