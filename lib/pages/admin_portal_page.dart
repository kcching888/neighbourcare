import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
        message = 'Could not load admin data:\n$error';
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
      message = 'Booking assigned to provider.';
    });

    await loadAdminData();
  } catch (error) {
    setState(() {
      message = 'Could not assign provider:\n$error';
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
          ? 'Provider approved successfully.'
          : 'Provider verification was removed.';
    });

    await loadAdminData();
  } catch (error) {
    if (!mounted) return;

    setState(() {
      message = 'Could not update provider verification:\n$error';
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
        message = 'Booking status updated to $newStatus.';
      });

      await loadAdminData();
    } catch (error) {
      setState(() {
        message = 'Could not update booking status:\n$error';
      });
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
        status,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      backgroundColor: color,
    );
  }

  Widget bookingRow(Map<String, dynamic> booking) {
    final bookingId = booking['id'].toString();
    final serviceType = booking['service_type']?.toString() ?? 'Service';
    final location = booking['location']?.toString() ?? 'Not provided';
    final preferredTime =
        booking['preferred_time']?.toString() ?? 'Not provided';
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
            Text('Location: $location'),
            Text('Preferred time: $preferredTime'),
            Text('Amount: \$${amount.isEmpty ? '0' : amount}'),
            if (notes.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text('Notes: $notes'),
            ],
            const SizedBox(height: 12),

            // Provider assignment
            Row(
              children: [
                const Text('Provider: '),
                Expanded(
                  child: DropdownButton<String>(
                    value: providerId,
                    hint: const Text('Unassigned'),
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
                        verified ? 'Verified' : '',
                        'rating: $rating',
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
                    label: const Text('Assign'),
                  ),

                if (status == 'assigned')
                  FilledButton.icon(
                    onPressed: () {
                      updateBookingStatus(bookingId, 'accepted');
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Force accept'),
                  ),

                if (status == 'assigned')
                  OutlinedButton.icon(
                    onPressed: () {
                      updateBookingStatus(bookingId, 'declined');
                    },
                    icon: const Icon(Icons.close),
                    label: const Text('Force decline'),
                  ),

                if (status == 'accepted')
                  FilledButton.icon(
                    onPressed: () {
                      updateBookingStatus(bookingId, 'in_progress');
                    },
                    icon: const Icon(Icons.directions_car),
                    label: const Text('Start job'),
                  ),

                if (status == 'in_progress')
                  FilledButton.icon(
                    onPressed: () {
                      updateBookingStatus(bookingId, 'completed');
                    },
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Complete'),
                  ),

                if (status != 'completed' && status != 'cancelled')
                  OutlinedButton.icon(
                    onPressed: () {
                      updateBookingStatus(bookingId, 'cancelled');
                    },
                    icon: const Icon(Icons.cancel),
                    label: const Text('Cancel'),
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
        title: const Text('Admin Portal'),
        actions: [
          IconButton(
            onPressed: loadAdminData,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text('Filter: '),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButton<String>(
                    value: statusFilter,
                    isExpanded: true,
                    items: [
                      const DropdownMenuItem(
                        value: 'all',
                        child: Text('All'),
                      ),
                      const DropdownMenuItem(
                        value: 'pending',
                        child: Text('Pending'),
                      ),
                      const DropdownMenuItem(
                        value: 'assigned',
                        child: Text('Assigned'),
                      ),
                      const DropdownMenuItem(
                        value: 'accepted',
                        child: Text('Accepted'),
                      ),
                      const DropdownMenuItem(
                        value: 'declined',
                        child: Text('Declined'),
                      ),
                      const DropdownMenuItem(
                        value: 'in_progress',
                        child: Text('In progress'),
                      ),
                      const DropdownMenuItem(
                        value: 'completed',
                        child: Text('Completed'),
                      ),
                      const DropdownMenuItem(
                        value: 'cancelled',
                        child: Text('Cancelled'),
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
                      const Text(
  'Provider approval',
  style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  ),
),
const SizedBox(height: 12),

if (providers.isEmpty)
  const Card(
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Text('No provider applications found.'),
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
            : (email.isNotEmpty ? email : 'Provider $providerId');

        return ListTile(
          leading: CircleAvatar(
            child: Icon(
              verified ? Icons.verified : Icons.pending_actions,
            ),
          ),
          title: Text(displayName),
          subtitle: Text(
            email.isEmpty ? 'No email available' : email,
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
            child: Text(verified ? 'Suspend' : 'Approve'),
          ),
        );
      }).toList(),
    ),
  ),

const SizedBox(height: 24),

const SizedBox(height: 24),
const Text(
  'Bookings',
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