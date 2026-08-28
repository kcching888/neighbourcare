import 'package:flutter/material.dart';

import 'login_page.dart';
import '../services/traffic_service.dart';
import 'traffic_page.dart';

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

  String _formatTime(DateTime? value) {
    if (value == null) return 'Update time unavailable';

    final local = value.toLocal();
    final hour = local.hour % 12 == 0 ? 12 : local.hour % 12;
    final minute = local.minute.toString().padLeft(2, '0');
    final period = local.hour >= 12 ? 'PM' : 'AM';

    return '${local.month}/${local.day} $hour:$minute $period';
  }

void _openTrafficPage() {
   Navigator.of(context).push(
     MaterialPageRoute(
       builder: (context) => const TrafficPage(),
     ),
   );
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Calgary'),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const LoginPage(),
                ),
              );
            },
            icon: const Icon(Icons.person_outline),
            label: const Text('Sign in'),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: _refresh,
          ),
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
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Calgary, Alberta',
                  style: TextStyle(
                    color: Color(0xFF0C7A6C),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Your local Calgary hub',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Traffic updates, neighbourhood news, local savings, and helpful community information.',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                const SizedBox(height: 24),

                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.35,
                  children: [
                    _DiscoverCategoryCard(
                      icon: Icons.traffic_outlined,
                      title: 'Traffic & roads',
                      subtitle: 'Live incident updates',
                      count: incidents.length,
                      color: const Color(0xFFE7F4F1),
                      onTap: _openTrafficPage,
                    ),
                    _DiscoverCategoryCard(
                      icon: Icons.campaign_outlined,
                      title: 'Community news',
                      subtitle: 'Coming soon',
                      color: const Color(0xFFEFF4FF),
                      onTap: () {},
                    ),
                    _DiscoverCategoryCard(
                      icon: Icons.sell_outlined,
                      title: 'Local savings',
                      subtitle: 'Coming soon',
                      color: const Color(0xFFFFF4E5),
                      onTap: () {},
                    ),
                    _DiscoverCategoryCard(
                      icon: Icons.home_work_outlined,
                      title: 'Housing insights',
                      subtitle: 'Coming soon',
                      color: const Color(0xFFF4EEFF),
                      onTap: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                _SectionHeader(
                  title: 'Traffic & road conditions',
                  actionLabel: 'View all',
                  onAction: _openTrafficPage,
                ),

                const SizedBox(height: 10),

                if (snapshot.connectionState == ConnectionState.waiting)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(28),
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (snapshot.hasError)
                  _FeedStatusCard(
                    icon: Icons.cloud_off_outlined,
                    message: 'Traffic updates are temporarily unavailable.',
                    actionLabel: 'Try again',
                    onAction: _refresh,
                  )
                else if (incidents.isEmpty)
                  const _FeedStatusCard(
                    icon: Icons.check_circle_outline,
                    message: 'No current traffic incidents are listed.',
                  )
                else
                  ...incidents.take(3).map(
                        (incident) => _TrafficPreviewCard(
                          incident: incident,
                          formattedTime:
                              _formatTime(incident.modifiedDateTime),
                          onTap: _openTrafficPage,
                        ),
                      ),

                const SizedBox(height: 12),

                Text(
                  'Source: City of Calgary Open Data. Traffic details can change quickly; confirm conditions before travelling.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
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

class _DiscoverCategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final int? count;
  final Color color;
  final VoidCallback onTap;

  const _DiscoverCategoryCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: const Color(0xFF0C7A6C)),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
              if (count != null) ...[
                const SizedBox(height: 5),
                Text(
                  '$count active',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
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
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        TextButton(
          onPressed: onAction,
          child: Text(actionLabel),
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
      child: ListTile(
        onTap: onTap,
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
          style: const TextStyle(fontWeight: FontWeight.w600),
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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(icon, size: 34, color: const Color(0xFF0C7A6C)),
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