import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'admin_portal_page.dart';
import 'login_page.dart';
import 'provider_portal_page.dart';
import 'weather_forum_page.dart';

final supabase = Supabase.instance.client;

class ServicesBookingPage extends StatefulWidget {
  final String? forumPostId;
  final String? forumPostTitle;
  final String? forumCategory;

  const ServicesBookingPage({
    super.key,
    this.forumPostId,
    this.forumPostTitle,
    this.forumCategory,
  });

  @override
  State<ServicesBookingPage> createState() => _ServicesBookingPageState();
}

class _ServicesBookingPageState extends State<ServicesBookingPage> {
  final _formKey = GlobalKey<FormState>();

  final _categoryController = TextEditingController();
  final _locationController = TextEditingController();
  final _preferredTimeController = TextEditingController();
  final _detailsController = TextEditingController();

  List<Map<String, dynamic>> _bookings = [];

  bool _loadingBookings = false;
  bool _submitting = false;
  bool _checkingRole = true;
  bool _isAdmin = false;

  String? _formMessage;
  String? _listMessage;

@override
void initState() {
  super.initState();

  if (widget.forumCategory != null) {
    _categoryController.text = _serviceCategoryFromForum(
      widget.forumCategory!,
    );
  }

  if (widget.forumPostTitle != null) {
    _detailsController.text =
        'Requested from community post: ${widget.forumPostTitle}\n\n'
        'Please describe the help needed:';
  }

  _loadMyBookings();
  _loadRole();
}

String _serviceCategoryFromForum(String category) {
  switch (category) {
    case 'weather':
      return 'Weather-related home help';
    case 'diy':
      return 'Home repair / DIY help';
    case 'dining':
      return 'Other local assistance';
    default:
      return 'Home service';
  }
}

  @override
  void dispose() {
    _categoryController.dispose();
    _locationController.dispose();
    _preferredTimeController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

Future<void> _loadRole() async {
  final user = supabase.auth.currentUser;

  if (user == null) {
    if (mounted) {
      setState(() {
        _checkingRole = false;
        _isAdmin = false;
      });
    }
    return;
  }

  try {
    final profile = await supabase
        .from('users')
        .select('id, role')
        .eq('id', user.id)
        .maybeSingle();

    final role = profile?['role']?.toString().trim().toLowerCase();

    debugPrint('Signed-in ID: ${user.id}');
    debugPrint('Profile from public.users: $profile');
    debugPrint('Resolved role: $role');

    if (!mounted) return;

    setState(() {
      _isAdmin = role == 'admin';
      _checkingRole = false;
    });
  } catch (error) {
    debugPrint('Role lookup failed: $error');

    if (!mounted) return;

    setState(() {
      _isAdmin = false;
      _checkingRole = false;
      _listMessage = 'Could not verify account role: $error';
    });
  }
}

  Future<void> _loadMyBookings() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      setState(() {
        _bookings = [];
        _listMessage = 'Please sign in to view your bookings.';
      });
      return;
    }

    setState(() {
      _loadingBookings = true;
      _listMessage = null;
    });

    try {
      final result = await supabase
          .from('bookings')
          .select()
          .eq('client_id', user.id)
          .order('created_at', ascending: false);

      if (!mounted) return;

      setState(() {
        _bookings = List<Map<String, dynamic>>.from(result);
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _listMessage = 'Could not load bookings:\n$error';
      });
    } finally {
      if (mounted) {
        setState(() {
          _loadingBookings = false;
        });
      }
    }
  }

  Future<void> _submitBooking() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      setState(() {
        _formMessage = 'Please sign in before submitting a booking.';
      });
      return;
    }

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _submitting = true;
      _formMessage = null;
    });

    try {
      final insertedBooking = await supabase
          .from('bookings')
          .insert({
            'client_id': user.id,

            // Keep this null for a new request.
            // A Provider Portal will later set this to public.providers.id.
            'provider_id': null,

            'service_type': _categoryController.text.trim(),
            'forum_post_id': widget.forumPostId,
            'status': 'pending',
            'total_amount': 0,
            'location': _locationController.text.trim(),
            'notes': _detailsController.text.trim(),
            'preferred_time': _preferredTimeController.text.trim(),
          })
          .select()
          .single();

      if (!mounted) return;

      _categoryController.clear();
      _locationController.clear();
      _preferredTimeController.clear();
      _detailsController.clear();

      setState(() {
        _formMessage =
            'Booking submitted successfully.\n'
            'Booking ID: ${insertedBooking['id']}';
      });

      await _loadMyBookings();
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _formMessage = 'Could not submit booking:\n$error';
      });
    } finally {
      if (mounted) {
        setState(() {
          _submitting = false;
        });
      }
    }
  }

  Future<void> _signOut() async {
    try {
      await supabase.auth.signOut();

      if (!mounted) return;

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ),
        (route) => false,
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not sign out: $error'),
        ),
      );
    }
  }

  void _openProviderPortal() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ProviderPortalPage(),
      ),
    );
  }

  void _openAdminPortal() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const AdminPortalPage(),
      ),
    );
  }

  Widget _buildBookingForm() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
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
              if (widget.forumPostTitle != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Text(
                    'This booking started from the community post: '
                    '${widget.forumPostTitle}',
                  ),
              ),
            ],
              const SizedBox(height: 24),
              TextFormField(
                controller: _categoryController,
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
                controller: _locationController,
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
                controller: _preferredTimeController,
                decoration: const InputDecoration(
                  labelText: 'Preferred time',
                  hintText: 'Today 5–7 PM or Saturday morning',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _detailsController,
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
                  onPressed: _submitting ? null : _submitBooking,
                  icon: _submitting
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.send),
                  label: Text(
                    _submitting ? 'Submitting...' : 'Submit booking',
                  ),
                ),
              ),
              if (_formMessage != null) ...[
                const SizedBox(height: 16),
                SelectableText(
                  _formMessage!,
                  style: TextStyle(
                    color: _formMessage!.startsWith('Could not')
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

  Widget _buildBookingList() {
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
                  onPressed: _loadingBookings ? null : _loadMyBookings,
                  tooltip: 'Refresh bookings',
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_loadingBookings)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (_listMessage != null)
              SelectableText(
                _listMessage!,
                style: const TextStyle(color: Colors.red),
              )
            else if (_bookings.isEmpty)
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
                itemCount: _bookings.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final booking = _bookings[index];

                  final serviceType =
                      booking['service_type']?.toString() ?? 'Service';

                  final location =
                      booking['location']?.toString() ?? 'Not provided';

                  final preferredTime =
                      booking['preferred_time']?.toString() ?? 'Not provided';

                  final notes = booking['notes']?.toString() ?? '';

                  final status =
                      booking['status']?.toString() ?? 'pending';

                  final amount =
                      booking['total_amount']?.toString() ?? '0';

                  return Padding(
  padding: const EdgeInsets.symmetric(vertical: 8),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const CircleAvatar(
        child: Icon(Icons.home_repair_service),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              serviceType,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Text('Location: $location'),
            Text('Preferred time: $preferredTime'),
            Text('Estimated amount: \$$amount'),
            if (notes.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text('Notes: $notes'),
            ],
          ],
        ),
      ),
      const SizedBox(width: 8),
      Chip(
          label: Text(
            status.replaceAll('_', ' '),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          backgroundColor: switch (status) {
            'pending' => Colors.orange.shade100,
            'assigned' => Colors.blue.shade100,
            'in_progress' => Colors.purple.shade100,
            'completed' => Colors.green.shade100,
          _=> Colors.grey.shade200,
        },
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
        title: const Text('NeighbourCare Services'),
        actions: [
          if (_checkingRole)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
          if (_isAdmin)
            IconButton(
              onPressed: _openAdminPortal,
              icon: const Icon(Icons.admin_panel_settings),
              tooltip: 'Admin portal',
            ),
          IconButton(
            onPressed: _openProviderPortal,
            icon: const Icon(Icons.engineering),
            tooltip: 'Provider portal',
          ),
          IconButton(
            tooltip: 'Community Forum',
            icon: const Icon(Icons.forum_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const WeatherForumPage(),
                ),
              );
            },
          ),
          IconButton(
            onPressed: _loadingBookings ? null : _loadMyBookings,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh bookings',
          ),
          IconButton(
            onPressed: _signOut,
            icon: const Icon(Icons.logout),
            tooltip: 'Sign out',
          ),
        ],
      ),
      body: SafeArea(
  child: LayoutBuilder(
    builder: (context, constraints) {
      final isWide = constraints.maxWidth >= 900;

      final content = isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildBookingForm()),
                const SizedBox(width: 24),
                Expanded(child: _buildBookingList()),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildBookingForm(),
                const SizedBox(height: 24),
                _buildBookingList(),
              ],
            );

      return SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: content,
          ),
        ),
      );
    },
  ),
),
    );
  }
}