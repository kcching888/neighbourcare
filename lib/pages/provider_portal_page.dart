import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class ProviderPortalPage extends StatefulWidget {
  const ProviderPortalPage({super.key});

  @override
  State<ProviderPortalPage> createState() => _ProviderPortalPageState();
}

class _ProviderPortalPageState extends State<ProviderPortalPage> {
  String? _providerId;
  bool _loading = true;
  bool _isClaiming = false;
  String? _message;

  List<Map<String, dynamic>> _openJobs = [];
  List<Map<String, dynamic>> _myJobs = [];

  @override
  void initState() {
    super.initState();
    _loadPortal();
  }

  Future<void> _loadPortal() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      setState(() {
        _loading = false;
        _message = 'Please sign in as a provider.';
      });
      return;
    }

    setState(() {
      _loading = true;
      _message = null;
    });

    try {
      final provider = await supabase
          .from('providers')
          .select('id, pvsc_verified')
          .eq('user_id', user.id)
          .maybeSingle();

      if (provider == null) {
        throw Exception(
          'No provider profile is linked to this account. '
          'Create a providers row using this user’s Auth UUID.',
        );
      }

      if (provider['pvsc_verified'] != true) {
        throw Exception(
          'Your provider profile is not verified yet. '
          'Ask an administrator to set pvsc_verified to true.',
        );
      }

      _providerId = provider['id'].toString();

      final openJobs = await supabase
          .from('bookings')
          .select()
          .eq('status', 'pending')
          .isFilter('provider_id', null)
          .order('created_at', ascending: false);

      final myJobs = await supabase
          .from('bookings')
          .select()
          .eq('provider_id', _providerId!)
          .order('created_at', ascending: false);

      if (!mounted) return;

      setState(() {
        _openJobs = List<Map<String, dynamic>>.from(openJobs);
        _myJobs = List<Map<String, dynamic>>.from(myJobs);
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _message = 'Could not load Provider Portal:\n$error';
      });
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _claimJob(String bookingId) async {
    if (_providerId == null || _isClaiming) return;

    setState(() {
      _isClaiming = true;
      _message = null;
    });

    try {
      final claimed = await supabase
          .from('bookings')
          .update({
            'provider_id': _providerId,
            'status': 'assigned',
          })
          .eq('id', bookingId)
          .isFilter('provider_id', null)
          .eq('status', 'pending')
          .select('id')
          .maybeSingle();

      if (!mounted) return;

      if (claimed == null) {
        setState(() {
          _message =
              'This job was already claimed by another provider. '
              'The list will now refresh.';
        });
      } else {
        setState(() {
          _message = 'Job claimed successfully.';
        });
      }

      await _loadPortal();
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _message = 'Could not claim job:\n$error';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isClaiming = false;
        });
      }
    }
  }

  Future<void> _updateStatus(
    String bookingId,
    String newStatus,
  ) async {
    try {
      await supabase
          .from('bookings')
          .update({'status': newStatus})
          .eq('id', bookingId)
          .eq('provider_id', _providerId!);

      if (!mounted) return;

      setState(() {
        _message = 'Job status changed to $newStatus.';
      });

      await _loadPortal();
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _message = 'Could not update job status:\n$error';
      });
    }
  }

  Widget _jobCard(
    Map<String, dynamic> job, {
    required Widget action,
  }) {
    final service = job['service_type']?.toString() ?? 'Service';
    final location = job['location']?.toString() ?? 'Not provided';
    final time = job['preferred_time']?.toString() ?? 'Not provided';
    final notes = job['notes']?.toString() ?? '';
    final status = job['status']?.toString() ?? 'pending';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              service,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Location: $location'),
            Text('Preferred time: $time'),
            Text('Status: $status'),
            if (notes.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('Notes: $notes'),
            ],
            const SizedBox(height: 14),
            action,
          ],
        ),
      ),
    );
  }

  Widget _openJobSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Open requests',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Claim an unassigned request. The first successful claim wins.',
            ),
            const SizedBox(height: 16),
            if (_openJobs.isEmpty)
              const Text('No open requests are available right now.')
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _openJobs.length,
                itemBuilder: (context, index) {
                  final job = _openJobs[index];

                  return _jobCard(
                    job,
                    action: FilledButton.icon(
                      onPressed: _isClaiming
                          ? null
                          : () => _claimJob(job['id'].toString()),
                      icon: const Icon(Icons.handshake),
                      label: Text(
                        _isClaiming ? 'Claiming...' : 'Claim job',
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _myJobSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My assigned jobs',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (_myJobs.isEmpty)
              const Text('You have not claimed any jobs yet.')
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _myJobs.length,
                itemBuilder: (context, index) {
                  final job = _myJobs[index];
                  final status = job['status']?.toString() ?? 'assigned';

                  return _jobCard(
                    job,
                    action: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (status == 'assigned')
                          OutlinedButton(
                            onPressed: () => _updateStatus(
                              job['id'].toString(),
                              'in_progress',
                            ),
                            child: const Text('Start job'),
                          ),
                        if (status == 'assigned' || status == 'in_progress')
                          FilledButton(
                            onPressed: () => _updateStatus(
                              job['id'].toString(),
                              'completed',
                            ),
                            child: const Text('Mark completed'),
                          ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Portal'),
        actions: [
          IconButton(
            onPressed: _loading ? null : _loadPortal,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh jobs',
          ),
        ],
      ),
      body: _loading
    ? const Center(child: CircularProgressIndicator())
    : SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 900;

                  final content = isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _openJobSection()),
                            const SizedBox(width: 24),
                            Expanded(child: _myJobSection()),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _openJobSection(),
                            const SizedBox(height: 24),
                            _myJobSection(),
                          ],
                        );

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (_message != null) ...[
                        SelectableText(
                          _message!,
                          style: TextStyle(
                            color: _message!.startsWith('Could not')
                                ? Colors.red
                                : Colors.green.shade700,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                      content,
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}