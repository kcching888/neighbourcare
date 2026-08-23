import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/traffic_service.dart';

enum TrafficViewMode {
  list,
  map,
}

class TrafficPage extends StatefulWidget {
  const TrafficPage({super.key});

  @override
  State<TrafficPage> createState() => _TrafficPageState();
}

class _TrafficPageState extends State<TrafficPage> {
  final _trafficService = TrafficService();

  late Future<List<TrafficIncident>> _trafficFuture;
  TrafficViewMode _viewMode = TrafficViewMode.list;
  String _selectedFilter = 'All';
  DateTime? _lastRefreshedAt;

  @override
  void initState() {
    super.initState();
    _trafficFuture = _trafficService.fetchCurrentIncidents();
    _lastRefreshedAt = DateTime.now();
  }

  Future<void> _refresh() async {
    setState(() {
      _trafficFuture = _trafficService.fetchCurrentIncidents();
      _lastRefreshedAt = DateTime.now();
    });

    await _trafficFuture;
  }

  Future<void> _openOfficialReport() async {
    final url = Uri.parse(
      'https://www.calgary.ca/roads/conditions/traffic.html',
    );

    final opened = await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
      webOnlyWindowName: '_blank',
    );

    if (!opened && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open the official Calgary traffic report.'),
        ),
      );
    }
  }

  String _formatDateTime(DateTime? value) {
    if (value == null) {
      return 'Update time unavailable';
    }

    final local = value.toLocal();
    final hour = local.hour % 12 == 0 ? 12 : local.hour % 12;
    final minute = local.minute.toString().padLeft(2, '0');
    final period = local.hour >= 12 ? 'PM' : 'AM';

    return '${local.month}/${local.day}/${local.year} '
        '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Traffic & Road Conditions'),
        actions: [
          IconButton(
            tooltip: _viewMode == TrafficViewMode.list
                ? 'Show map'
                : 'Show list',
            icon: Icon(
              _viewMode == TrafficViewMode.list
                  ? Icons.map_outlined
                  : Icons.list_alt_outlined,
            ),
            onPressed: () {
              setState(() {
                _viewMode = _viewMode == TrafficViewMode.list
                    ? TrafficViewMode.map
                    : TrafficViewMode.list;
              });
            },
          ),
          IconButton(
            tooltip: 'Refresh traffic',
            icon: const Icon(Icons.refresh),
            onPressed: _refresh,
          ),
        ],
      ),
      body: FutureBuilder<List<TrafficIncident>>(
        future: _trafficFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return _TrafficErrorState(onRetry: _refresh);
          }

          final incidents = snapshot.data ?? [];

          final incidentTypes = incidents
              .map((incident) => incident.incidentInfo.trim())
              .where((type) => type.isNotEmpty)
              .toSet()
              .toList()
            ..sort();

          final filterOptions = [
            'All',
            ...incidentTypes,
          ];

          final filteredIncidents = _selectedFilter == 'All'
              ? incidents
              : incidents
                  .where(
                    (incident) => incident.incidentInfo == _selectedFilter,
                  )
                  .toList();

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Current Calgary traffic incidents',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${filteredIncidents.length} current incident'
                  '${filteredIncidents.length == 1 ? '' : 's'} shown.',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                const SizedBox(height: 8),
                Text(
                  _lastRefreshedAt == null
                      ? 'Loading traffic updates...'
                      : 'Last refreshed: '
                          '${_formatDateTime(_lastRefreshedAt)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: filterOptions.map((filter) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(filter),
                          selected: _selectedFilter == filter,
                          onSelected: (_) {
                            setState(() {
                              _selectedFilter = filter;
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                if (filteredIncidents.isEmpty)
                  const _TrafficEmptyState()
                else if (_viewMode == TrafficViewMode.map)
                  _TrafficMap(
                    incidents: filteredIncidents,
                    formatDateTime: _formatDateTime,
                  )
                else
                  ...filteredIncidents.map(
                    (incident) => _TrafficIncidentCard(
                      incident: incident,
                      formatDateTime: _formatDateTime,
                    ),
                  ),
                const SizedBox(height: 8),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Official source',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Traffic details can change quickly. Check the City '
                          'of Calgary report for closures, detours, cameras, '
                          'and route updates before travelling.',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: _openOfficialReport,
                          icon: const Icon(Icons.open_in_new),
                          label: const Text('Open City traffic report'),
                        ),
                        Text(
                          'Source: City of Calgary Open Data.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TrafficIncidentCard extends StatelessWidget {
  final TrafficIncident incident;
  final String Function(DateTime?) formatDateTime;

  const _TrafficIncidentCard({
    required this.incident,
    required this.formatDateTime,
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
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFFFF0E5),
          child: Icon(
            Icons.warning_amber_rounded,
            color: Color(0xFFB54708),
          ),
        ),
        title: Text(
          location,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(description),
              const SizedBox(height: 8),
              Text(
                '${incident.quadrant.isEmpty ? 'Calgary' : '${incident.quadrant} Calgary'}'
                ' · Updated ${formatDateTime(incident.modifiedDateTime)}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrafficEmptyState extends StatelessWidget {
  const _TrafficEmptyState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 52,
            color: Color(0xFF0C7A6C),
          ),
          SizedBox(height: 12),
          Text(
            'No current traffic incidents are listed.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _TrafficErrorState extends StatelessWidget {
  final Future<void> Function() onRetry;

  const _TrafficErrorState({
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.cloud_off_outlined,
              size: 52,
              color: Color(0xFF0C7A6C),
            ),
            const SizedBox(height: 16),
            const Text(
              'Traffic updates are unavailable.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: onRetry,
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrafficMap extends StatelessWidget {
  final List<TrafficIncident> incidents;
  final String Function(DateTime?) formatDateTime;

  const _TrafficMap({
    required this.incidents,
    required this.formatDateTime,
  });

  Future<void> _openDirections(
    BuildContext context,
    TrafficIncident incident,
  ) async {
    final latitude = incident.latitude!;
    final longitude = incident.longitude!;

    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1'
      '&destination=$latitude,$longitude'
      '&travelmode=driving',
    );

    final opened = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
      webOnlyWindowName: '_blank',
    );

    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open directions.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mappableIncidents = incidents
        .where(
          (incident) =>
              incident.latitude != null &&
              incident.longitude != null,
        )
        .toList();

    if (mappableIncidents.isEmpty) {
      return const _TrafficEmptyState();
    }

    final calgaryCentre = LatLng(51.0447, -114.0719);

    return SizedBox(
      height: 460,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: calgaryCentre,
            initialZoom: 10.5,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'ca.neighbourcare.app',
            ),
            MarkerLayer(
              markers: mappableIncidents.map((incident) {
                return Marker(
                  point: LatLng(
                    incident.latitude!,
                    incident.longitude!,
                  ),
                  width: 44,
                  height: 44,
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        showDragHandle: true,
                        builder: (sheetContext) {
                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: Wrap(
                              runSpacing: 12,
                              children: [
                                Text(
                                  incident.incidentInfo.isEmpty
                                      ? 'Traffic incident'
                                      : incident.incidentInfo,
                                  style:
                                      Theme.of(sheetContext).textTheme.titleLarge,
                                ),
                                Text(
                                  incident.description.isEmpty
                                      ? 'Traffic incident reported.'
                                      : incident.description,
                                ),
                                Text(
                                  'Updated: '
                                  '${formatDateTime(incident.modifiedDateTime)}',
                                ),
                                FilledButton.icon(
                                  onPressed: () {
                                    _openDirections(context, incident);
                                  },
                                  icon: const Icon(Icons.directions),
                                  label: const Text('Get directions'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: const Icon(
                      Icons.location_on,
                      size: 40,
                      color: Color(0xFFB54708),
                    ),
                  ),
                );
              }).toList(),
            ),
            SimpleAttributionWidget(
              source: const Text('© OpenStreetMap contributors'),
            ),
          ],
        ),
      ),
    );
  }
}