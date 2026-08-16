import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/auth_service.dart';
import 'notifications_page.dart';

final supabase = Supabase.instance.client;

class ProviderPortalPage extends StatefulWidget {
  const ProviderPortalPage({super.key});

  @override
  State<ProviderPortalPage> createState() => _ProviderPortalPageState();
}

class _ProviderPortalPageState extends State<ProviderPortalPage> {
  String? providerId;
  List<Map<String, dynamic>> assignedBookings = [];

  bool loading = true;
  String message = '';

  @override
  void initState() {
    super.initState();
    loadProviderPortal();
  }

  Future<void> loadProviderPortal() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      setState(() {
        loading = false;
        message = 'Please sign in as a provider.';
      });
      return;
    }

    debugPrint('Signed-in user ID: ${user.id}');
    debugPrint('Signed-in email: ${user.email}');

    setState(() {
      loading = true;
      message = '';
    });

    try {
      final provider = await supabase
          .from('providers')
          .select('id, user_id, pvsc_verified, rating_avg')
          .eq('user_id', user.id)
          .maybeSingle();

      if (provider == null) {
        setState(() {
          loading = false;
          message = 'No provider profile is linked to this account.';
        });
        return;
      }

      providerId = provider['id'].toString();

      final bookings = await supabase
          .from('bookings')
          .select()
          .eq('provider_id', providerId!)
          .order('created_at', ascending: false);

      setState(() {
        assignedBookings = List<Map<String, dynamic>>.from(bookings);
        loading = false;
      });
    } catch (error) {
      setState(() {
        loading = false;
        message = 'Could not load provider portal:\n$error';
      });
    }
  }

  Future<void> updateBookingStatus(
    String bookingId,
    String newStatus,
  ) async {
    try {
      await supabase
          .from('bookings')
          .update({'status': newStatus})
          .eq('id', bookingId);

      setState(() {
        message = 'Booking updated to $newStatus.';
      });

      await loadProviderPortal();
    } catch (error) {
      setState(() {
        message = 'Could not update booking:\n$error';
      });
    }
  }

  void signOut() async {
    final authService = context.read<AuthService>();
    await authService.signOut();

    if (mounted) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  void openNotifications() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const NotificationsPage(),
      ),
    );
  }

  Widget bookingCard(Map<String, dynamic> booking) {
    final bookingId = booking['id'].toString();
    final status = booking['status']?.toString() ?? 'pending';

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              booking['service_type']?.toString() ?? 'Service request',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Location: ${booking['location'] ?? 'Not provided'}'),
            Text(
              'Preferred time: '
              '${booking['preferred_time'] ?? 'Not provided'}',
            ),
            Text('Status: $status'),
            Text('Booking ID: $bookingId'),

            if (booking['notes'] != null &&
                booking['notes'].toString().isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('Notes: ${booking['notes']}'),
            ],

            const SizedBox(height: 16),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (status == 'assigned')
                  FilledButton.icon(
                    onPressed: () {
                      updateBookingStatus(bookingId, 'accepted');
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Accept'),
                  ),

                if (status == 'assigned')
                  OutlinedButton.icon(
                    onPressed: () {
                      updateBookingStatus(bookingId, 'declined');
                    },
                    icon: const Icon(Icons.close),
                    label: const Text('Decline'),
                  ),

                if (status == 'accepted')
                  FilledButton.icon(
                    onPressed: () {
                      updateBookingStatus(bookingId, 'in_progress');
                    },
                    icon: const Icon(Icons.directions_car),
                    label: const Text('Start travel'),
                  ),

                if (status == 'in_progress')
                  FilledButton.icon(
                    onPressed: () {
                      updateBookingStatus(bookingId, 'completed');
                    },
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Mark completed'),
                  ),

                if (status == 'completed')
                  const Chip(
                    avatar: Icon(Icons.check),
                    label: Text('Completed'),
                  ),

                if (status == 'declined')
                  const Chip(
                    avatar: Icon(Icons.close),
                    label: Text('Declined'),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Portal'),
        actions: [
          IconButton(
            onPressed: openNotifications,
            icon: const Icon(Icons.notifications),
            tooltip: 'Notifications',
          ),
          IconButton(
            onPressed: loadProviderPortal,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
            tooltip: 'Sign out',
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;

          final content = loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    const Text(
                      'Assigned bookings',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    if (message.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(message),
                      ),

                    if (assignedBookings.isEmpty)
                      const Card(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Text(
                            'No bookings are currently assigned to you.',
                          ),
                        ),
                      ),

                    ...assignedBookings.map(bookingCard),
                  ],
                );

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isWide ? 1000 : double.infinity,
              ),
              child: content,
            ),
          );
        },
      ),
    );
  }
}