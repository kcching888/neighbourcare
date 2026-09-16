import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/locale_provider.dart';
import '../services/font_size_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../widgets/top_banner_widget.dart';
import '../l10n/app_localizations.dart';

final supabase = Supabase.instance.client;

class AdminPortalPage extends StatefulWidget {
  const AdminPortalPage({super.key});

  @override
  State<AdminPortalPage> createState() => _AdminPortalPageState();
}

class _AdminPortalPageState extends State<AdminPortalPage> {
  List<Map<String, dynamic>> allBookings = [];
  List<Map<String, dynamic>> providers = [];

  String statusFilter = 'all';
  bool loading = true;
  String message = '';

  @override
  void initState() {
    super.initState();
    loadAdminData();
  }

  Future<void> loadAdminData() async {
    setState(() {
      loading = true;
      message = '';
    });

    try {
      // Bookings query
      var bookingsQuery = supabase
          .from('bookings')
          .select('''
            id,
            client_id,
            provider_id,
            service_type,
            location,
            preferred_time,
            notes,
            status,
            total_amount,
            created_at
          ''')
          .order('created_at', ascending: false);

      if (statusFilter != 'all') {
        bookingsQuery = supabase
            .from('bookings')
            .select('''
              id,
              client_id,
              provider_id,
              service_type,
              location,
              preferred_time,
              notes,
              status,
              total_amount,
              created_at
            ''')
            .eq('status', statusFilter)
            .order('created_at', ascending: false);
      }

      final bookingsResult = await bookingsQuery;

      // Providers query with name and contact
      final providersResult = await supabase
        .from('provider_profiles')
        .select('''
            provider_id,
            user_id,
            pvsc_verified,
            rating_avg,
            email,
            first_name,
            last_name
          ''')
          .order('rating_avg', ascending: false);

      setState(() {
        allBookings = List<Map<String, dynamic>>.from(bookingsResult);
        providers = List<Map<String, dynamic>>.from(providersResult);
        loading = false;
      });
    } catch (error) {
      setState(() {
        loading = false;
        message = AppLocalizations.of(context)!.couldNotLoadAdminData(error.toString());
      });
    }
  }

Future<void> assignProvider(String bookingId, String? providerId) async {
  if (providerId == null) return;

  try {
    await supabase
        .from('bookings')
        .update({
          'provider_id': providerId,
          'status': 'assigned',
        })
        .eq('id', bookingId);

    setState(() {
      message = AppLocalizations.of(context)!.bookingAssignedToProvider;
    });

    await loadAdminData();
  } catch (error) {
    setState(() {
      message = AppLocalizations.of(context)!.couldNotAssignProvider(error.toString());
    });
  }
}

Future<void> setProviderVerification(
  String providerId,
  bool verified,
) async {
  try {
    await supabase
        .from('providers')
        .update({
          'pvsc_verified': verified,
        })
        .eq('id', providerId);

    if (!mounted) return;

    setState(() {
      message = verified
          ? AppLocalizations.of(context)!.providerApprovedSuccess
          : AppLocalizations.of(context)!.providerVerificationRemoved;
    });

    await loadAdminData();
  } catch (error) {
    if (!mounted) return;

    setState(() {
      message = AppLocalizations.of(context)!.couldNotUpdateProviderVerification(error.toString());
    });
  }
}


  Future<void> updateBookingStatus(String bookingId, String newStatus) async {
    try {
      await supabase
          .from('bookings')
          .update({'status': newStatus})
          .eq('id', bookingId);

      setState(() {
        message = AppLocalizations.of(context)!.bookingStatusUpdated(newStatus);
      });

      await loadAdminData();
    } catch (error) {
      setState(() {
        message = AppLocalizations.of(context)!.couldNotUpdateBookingStatus(error.toString());
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
      case 'accepted':
        return l.statusAccepted;
      case 'declined':
        return l.statusDeclined;
      case 'in_progress':
        return l.statusInProgress;
      case 'completed':
        return l.statusCompleted;
      case 'cancelled':
        return l.statusCancelled;
      default:
        return status.replaceAll('_', ' ');
    }
  }

  Widget statusChip(String status) {
    Color color;
    IconData icon;

    switch (status) {
      case 'pending':
        color = Colors.grey;
        icon = Icons.pending_actions;
        break;
      case 'assigned':
        color = Colors.blue;
        icon = Icons.assignment;
        break;
      case 'accepted':
        color = Colors.green;
        icon = Icons.check_circle_outline;
        break;
      case 'declined':
        color = Colors.orange;
        icon = Icons.cancel_outlined;
        break;
      case 'in_progress':
        color = Colors.indigo;
        icon = Icons.directions_car;
        break;
      case 'completed':
        color = Colors.teal;
        icon = Icons.done_all;
        break;
      case 'cancelled':
        color = Colors.red;
        icon = Icons.error_outline;
        break;
      default:
        color = Colors.grey;
        icon = Icons.info_outline;
    }

    return Chip(
      avatar: Icon(icon, size: 18, color: Colors.white),
      label: Text(
        _statusLabel(context, status),
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      backgroundColor: color,
    );
  }

  Widget bookingRow(Map<String, dynamic> booking) {
    final bookingId = booking['id'].toString();
    final serviceType = booking['service_type']?.toString() ?? AppLocalizations.of(context)!.serviceFallback;
    final location = booking['location']?.toString() ?? AppLocalizations.of(context)!.notProvided;
    final preferredTime =
        booking['preferred_time']?.toString() ?? AppLocalizations.of(context)!.notProvided;
    final status = booking['status']?.toString() ?? 'pending';
    final providerId = booking['provider_id'];
    final amount = booking['total_amount']?.toString() ?? '0';
    final notes = booking['notes']?.toString() ?? '';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    serviceType,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                statusChip(status),
              ],
            ),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.locationValue(location)),
            Text(AppLocalizations.of(context)!.preferredTimeValue(preferredTime)),
            Text(AppLocalizations.of(context)!.amountValue(amount.isEmpty ? '0' : amount)),
            if (notes.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(AppLocalizations.of(context)!.notesValue(notes)),
            ],
            const SizedBox(height: 12),

            // Provider assignment
            Row(
              children: [
                Text(AppLocalizations.of(context)!.providerLabelPrefix),
                Expanded(
                  child: DropdownButton<String>(
                    value: providerId,
                    hint: Text(AppLocalizations.of(context)!.unassigned),
                    isExpanded: true,
                    items: providers.map((p) {
                      final providerId = p['provider_id'].toString();
                      final firstName = p['first_name']?.toString().trim() ?? '';
                      final lastName = p['last_name']?.toString().trim() ?? '';
                      final email = p['email']?.toString().trim() ?? '';
                      final verified = p['pvsc_verified'] == true;
                      final rating = p['rating_avg'] ?? 0;

                      final name = [firstName, lastName]
                       .where((s) => s.isNotEmpty)
                       .join(' ')
                       .trim();

                      final displayName =
                        name.isNotEmpty ? name : (email.isNotEmpty ? email : providerId);

                      final label = [
                        displayName,
                        verified ? AppLocalizations.of(context)!.verifiedLabel : '',
                        AppLocalizations.of(context)!.ratingValue(rating.toString()),
                      ].where((s) => s.isNotEmpty).join(' • ');

                      return DropdownMenuItem(
                        value: providerId,
                        child: Text(
                          label,
                          overflow: TextOverflow.ellipsis,
                       ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      assignProvider(bookingId, value);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Status actions
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (status == 'pending')
                  FilledButton.icon(
                    onPressed: () {
                      assignProvider(bookingId, providerId);
                    },
                    icon: const Icon(Icons.assignment),
                    label: Text(AppLocalizations.of(context)!.assignButton),
                  ),

                if (status == 'assigned')
                  FilledButton.icon(
                    onPressed: () {
                      updateBookingStatus(bookingId, 'accepted');
                    },
                    icon: const Icon(Icons.check),
                    label: Text(AppLocalizations.of(context)!.forceAcceptButton),
                  ),

                if (status == 'assigned')
                  OutlinedButton.icon(
                    onPressed: () {
                      updateBookingStatus(bookingId, 'declined');
                    },
                    icon: const Icon(Icons.close),
                    label: Text(AppLocalizations.of(context)!.forceDeclineButton),
                  ),

                if (status == 'accepted')
                  FilledButton.icon(
                    onPressed: () {
                      updateBookingStatus(bookingId, 'in_progress');
                    },
                    icon: const Icon(Icons.directions_car),
                    label: Text(AppLocalizations.of(context)!.startJobButton),
                  ),

                if (status == 'in_progress')
                  FilledButton.icon(
                    onPressed: () {
                      updateBookingStatus(bookingId, 'completed');
                    },
                    icon: const Icon(Icons.check_circle),
                    label: Text(AppLocalizations.of(context)!.completeButton),
                  ),

                if (status != 'completed' && status != 'cancelled')
                  OutlinedButton.icon(
                    onPressed: () {
                      updateBookingStatus(bookingId, 'cancelled');
                    },
                    icon: const Icon(Icons.cancel),
                    label: Text(AppLocalizations.of(context)!.cancel),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);
    return Scaffold(
      appBar: TopBannerWidget(
        fontScale: fontSizeProvider.scaleFactor,
        onLanguageChanged: (locale) {
          localeProvider.setLocale(locale);
        },
        onFontScaleChanged: (scale) {
          fontSizeProvider.setScaleFactor(scale);
        },
        title: AppLocalizations.of(context)!.adminPortalTitle,
        onRefresh: loadAdminData,
      ),
      body: Column(
        children: [
          // Filter bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(AppLocalizations.of(context)!.filterLabelPrefix),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButton<String>(
                    value: statusFilter,
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(
                        value: 'all',
                        child: Text(AppLocalizations.of(context)!.filterAll),
                      ),
                      DropdownMenuItem(
                        value: 'pending',
                        child: Text(AppLocalizations.of(context)!.statusPending),
                      ),
                      DropdownMenuItem(
                        value: 'assigned',
                        child: Text(AppLocalizations.of(context)!.statusAssigned),
                      ),
                      DropdownMenuItem(
                        value: 'accepted',
                        child: Text(AppLocalizations.of(context)!.statusAccepted),
                      ),
                      DropdownMenuItem(
                        value: 'declined',
                        child: Text(AppLocalizations.of(context)!.statusDeclined),
                      ),
                      DropdownMenuItem(
                        value: 'in_progress',
                        child: Text(AppLocalizations.of(context)!.statusInProgress),
                      ),
                      DropdownMenuItem(
                        value: 'completed',
                        child: Text(AppLocalizations.of(context)!.statusCompleted),
                      ),
                      DropdownMenuItem(
                        value: 'cancelled',
                        child: Text(AppLocalizations.of(context)!.statusCancelled),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        statusFilter = value ?? 'all';
                      });
                      loadAdminData();
                    },
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      if (message.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(message),
                        ),
                      Text(
  AppLocalizations.of(context)!.providerApprovalTitle,
  style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  ),
),
const SizedBox(height: 12),

if (providers.isEmpty)
  Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Text(AppLocalizations.of(context)!.noProviderApplicationsFound),
    ),
  )
else
  Card(
    child: Column(
      children: providers.map((provider) {
        final providerId = provider['provider_id'].toString();
        final verified = provider['pvsc_verified'] == true;

        final firstName =
            provider['first_name']?.toString().trim() ?? '';
        final lastName =
            provider['last_name']?.toString().trim() ?? '';
        final email = provider['email']?.toString().trim() ?? '';

        final name = [firstName, lastName]
            .where((part) => part.isNotEmpty)
            .join(' ');

        final displayName = name.isNotEmpty
            ? name
            : (email.isNotEmpty ? email : AppLocalizations.of(context)!.providerIdFallback(providerId));

        return ListTile(
          leading: CircleAvatar(
            child: Icon(
              verified ? Icons.verified : Icons.pending_actions,
            ),
          ),
          title: Text(displayName),
          subtitle: Text(
            email.isEmpty ? AppLocalizations.of(context)!.noEmailAvailable : email,
          ),
          trailing: FilledButton(
            onPressed: () => setProviderVerification(
              providerId,
              !verified,
            ),
            style: FilledButton.styleFrom(
              backgroundColor: verified
                  ? Colors.red.shade700
                  : Colors.green.shade700,
            ),
            child: Text(verified ? AppLocalizations.of(context)!.suspendButton : AppLocalizations.of(context)!.approveButton),
          ),
        );
      }).toList(),
    ),
  ),

const SizedBox(height: 24),

const SizedBox(height: 24),
Text(
  AppLocalizations.of(context)!.bookingsTitle,
  style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  ),
),
const SizedBox(height: 12),
                      ...allBookings.map(bookingRow),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}