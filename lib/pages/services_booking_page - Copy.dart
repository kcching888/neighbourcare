import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/auth_service.dart';
import 'provider_portal_page.dart';
import 'admin_portal_page.dart';
import 'notifications_page.dart';

final supabase = Supabase.instance.client;

class ServicesBookingPage extends StatefulWidget {
  const ServicesBookingPage({super.key});

  @override
  State<ServicesBookingPage> createState() => _ServicesBookingPageState();
}

class _ServicesBookingPageState extends State<ServicesBookingPage> {
  final formKey = GlobalKey<FormState>();

  final categoryController = TextEditingController();
  final locationController = TextEditingController();
  final preferredTimeController = TextEditingController();
  final detailsController = TextEditingController();

  List<Map<String, dynamic>> bookings = [];

  bool loadingBookings = false;
  bool submitting = false;
  String message = '';

  @override
  void initState() {
    super.initState();
    loadMyBookings();
  }

  @override
  void dispose() {
    categoryController.dispose();
    locationController.dispose();
    preferredTimeController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  Future<void> loadMyBookings() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      setState(() {
        message = 'Please sign in before viewing your bookings.';
      });
      return;
    }

    setState(() {
      loadingBookings = true;
    });

    try {
      final result = await supabase
          .from('bookings')
          .select()
          .eq('client_id', user.id)
          .order('created_at', ascending: false);

      if (!mounted) return;

      setState(() {
        bookings = List<Map<String, dynamic>>.from(result);
        message = '';
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        message = 'Could not load bookings:\n$error';
      });
    } finally {
      if (mounted) {
        setState(() {
          loadingBookings = false;
        });
      }
    }
  }

  Future<void> submitBooking() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      setState(() {
        message = 'Please sign in before submitting a booking.';
      });
      return;
    }

    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      submitting = true;
      message = '';
    });

    try {
      final insertedBooking = await supabase
          .from('bookings')
          .insert({
            'client_id': user.id,
            'provider_id': null,
            'service_type': categoryController.text.trim(),
            'status': 'pending',
            'total_amount': 0,
            'location': locationController.text.trim(),
            'notes': detailsController.text.trim(),
            'preferred_time': preferredTimeController.text.trim(),
          })
          .select()
          .single();

      categoryController.clear();
      locationController.clear();
      preferredTimeController.clear();
      detailsController.clear();

      if (!mounted) return;

      setState(() {
        message =
            'Booking submitted successfully.\n'
            'Booking ID: ${insertedBooking['id']}';
      });

      await loadMyBookings();
    } catch (error) {
      if (!mounted) return;

      setState(() {
        message = 'Could not submit booking:\n$error';
      });
    } finally {
      if (mounted) {
        setState(() {
          submitting = false;
        });
      }
    }
  }

  void signOut() async {
    final authService = context.read<AuthService>();
    await authService.signOut();
  }

  void openProviderPortal() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ProviderPortalPage(),
      ),
    );
  }

  void openAdminPortal() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const AdminPortalPage(),
      ),
    );
  }

  void openNotifications() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const NotificationsPage(),
      ),
    );
  }

  Widget buildBookingForm() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Book a home service',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Describe the service you need in Calgary.',
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 24),

              TextFormField(
                controller: categoryController,
                decoration: const InputDecoration(
                  labelText: 'Service category',
                  hintText: 'Plumbing, furnace, snow removal...',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter a service category';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  hintText: 'Neighbourhood or postal code',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter your location';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: preferredTimeController,
                decoration: const InputDecoration(
                  labelText: 'Preferred time',
                  hintText: 'Today 5–7 PM or Saturday morning',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: detailsController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Describe the issue',
                  hintText: 'Tell us what needs to be repaired or completed.',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Describe the issue';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: submitting ? null : submitBooking,
                  icon: submitting
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.send),
                  label: Text(
                    submitting ? 'Submitting...' : 'Submit booking',
                  ),
                ),
              ),

              if (message.isNotEmpty) ...[
                const SizedBox(height: 16),
                SelectableText(
                  message,
                  style: TextStyle(
                    color: message.startsWith('Could not')
                        ? Colors.red
                        : Colors.green.shade700,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBookingList() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'My bookings',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: loadingBookings ? null : loadMyBookings,
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Refresh bookings',
                ),
              ],
            ),
            const SizedBox(height: 12),

            if (loadingBookings)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (bookings.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'No bookings yet. Submit your first service request.',
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: bookings.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final booking = bookings[index];

                  final serviceType =
                      booking['service_type']?.toString() ?? 'Service';

                  final location =
                      booking['location']?.toString() ?? 'Not provided';

                  final preferredTime =
                      booking['preferred_time']?.toString() ?? 'Not provided';

                  final notes =
                      booking['notes']?.toString() ?? '';

                  final status =
                      booking['status']?.toString() ?? 'pending';

                  final amount =
                      booking['total_amount']?.toString() ?? '0';

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(
                      child: Icon(Icons.home_repair_service),
                    ),
                    title: Text(serviceType),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        'Location: $location\n'
                        'Preferred time: $preferredTime\n'
                        'Amount: \$${amount.isEmpty ? '0' : amount}'
                        '${notes.isEmpty ? '' : '\nNotes: $notes'}',
                      ),
                    ),
                    isThreeLine: true,
                    trailing: Chip(
                      label: Text(status),
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
    final authService = context.watch<AuthService>();
    final isAdmin = authService.isAdmin;

    return Scaffold(
      appBar: AppBar(
        title: const Text('NeighbourCare Services'),
        actions: [
          if (isAdmin)
            IconButton(
              onPressed: openAdminPortal,
              icon: const Icon(Icons.admin_panel_settings),
              tooltip: 'Admin portal',
            ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const NotificationsPage(),
                ),
              );
            },
            icon: const Icon(Icons.notifications),
            tooltip: 'Notifications',
          ),
     //     IconButton(
     //       onPressed: openNotifications,
     //       icon: const Icon(Icons.notifications),
     //       tooltip: 'Notifications',
     //     ),
          IconButton(
            onPressed: loadMyBookings,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh bookings',
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ProviderPortalPage(),
                ),
              );
            },
            icon: const Icon(Icons.engineering),
            tooltip: 'Provider portal',
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

          final content = isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: buildBookingForm()),
                    const SizedBox(width: 24),
                    Expanded(child: buildBookingList()),
                  ],
                )
              : ListView(
                  children: [
                    buildBookingForm(),
                    const SizedBox(height: 24),
                    buildBookingList(),
                  ],
                );

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: content,
              ),
            ),
          );
        },
      ),
    );
  }
}