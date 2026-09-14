import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../widgets/top_banner_widget.dart';
import '../l10n/app_localizations.dart';

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
  bool _isError = false;

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
        _message = AppLocalizations.of(context)!.signInAsProvider;
        _isError = true;
      });
      return;
    }

    setState(() {
      _loading = true;
      _message = null;
      _isError = false;
    });

    try {
      final provider = await supabase
          .from('providers')
          .select('id, pvsc_verified')
          .eq('user_id', user.id)
          .maybeSingle();

      if (provider == null) {
        if (!mounted) return;
        setState(() {
          _message = AppLocalizations.of(context)!.noProviderProfileLinked;
          _isError = true;
          _loading = false;
        });
        return;
      }

      if (provider['pvsc_verified'] != true) {
        if (!mounted) return;
        setState(() {
          _message = AppLocalizations.of(context)!.providerNotVerified;
          _isError = true;
          _loading = false;
        });
        return;
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
        _message = AppLocalizations.of(context)!.couldNotLoadProviderPortal(error.toString());
        _isError = true;
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
      _isError = false;
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
          _message = AppLocalizations.of(context)!.jobAlreadyClaimed;
          _isError = true;
        });
      } else {
        setState(() {
          _message = AppLocalizations.of(context)!.jobClaimedSuccess;
          _isError = false;
        });
      }

      await _loadPortal();
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _message = AppLocalizations.of(context)!.couldNotClaimJob(error.toString());
        _isError = true;
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
        _message = AppLocalizations.of(context)!.jobStatusChanged(newStatus);
        _isError = false;
      });

      await _loadPortal();
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _message = AppLocalizations.of(context)!.couldNotUpdateJobStatus(error.toString());
        _isError = true;
      });
    }
  }

  String _statusLabel(BuildContext context, String status) {
    final l = AppLocalizations.of(context)!;
    switch (status) {
      case 'pending':
        return l.statusPending;
      case 'assigned':
        return l.statusAssigned;
      case 'in_progress':
        return l.statusInProgress;
      case 'completed':
        return l.statusCompleted;
      default:
        return status.replaceAll('_', ' ');
    }
  }

  Widget _jobCard(
    Map<String, dynamic> job, {
    required Widget action,
  }) {
    final service = job['service_type']?.toString() ?? AppLocalizations.of(context)!.serviceFallback;
    final location = job['location']?.toString() ?? AppLocalizations.of(context)!.notProvided;
    final time = job['preferred_time']?.toString() ?? AppLocalizations.of(context)!.notProvided;
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
            Text(AppLocalizations.of(context)!.locationValue(location)),
            Text(AppLocalizations.of(context)!.preferredTimeValue(time)),
            Text(AppLocalizations.of(context)!.statusValue(_statusLabel(context, status))),
            if (notes.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(AppLocalizations.of(context)!.notesValue(notes)),
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
            Text(
              AppLocalizations.of(context)!.openRequestsTitle,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.claimUnassignedSubtitle,
            ),
            const SizedBox(height: 16),
            if (_openJobs.isEmpty)
              Text(AppLocalizations.of(context)!.noOpenRequests)
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
                        _isClaiming ? AppLocalizations.of(context)!.claimingEllipsis : AppLocalizations.of(context)!.claimJobButton,
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
            Text(
              AppLocalizations.of(context)!.myAssignedJobsTitle,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (_myJobs.isEmpty)
              Text(AppLocalizations.of(context)!.noClaimedJobsYet)
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
                            child: Text(AppLocalizations.of(context)!.startJobButton),
                          ),
                        if (status == 'assigned' || status == 'in_progress')
                          FilledButton(
                            onPressed: () => _updateStatus(
                              job['id'].toString(),
                              'completed',
                            ),
                            child: Text(AppLocalizations.of(context)!.markCompletedButton),
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
      appBar: TopBannerWidget(
        title: AppLocalizations.of(context)!.providerPortalTitle,
        onRefresh: _loading ? null : _loadPortal,
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
                            color: _isError
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