import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/locale_provider.dart';
import '../services/font_size_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'admin_portal_page.dart';
import 'discover_calgary_page.dart';
import 'provider_portal_page.dart';
import 'category_forum_page.dart';
import '../widgets/top_banner_widget.dart';
import '../l10n/app_localizations.dart';

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
  final _preferredTimeController = TextEditingController();
  final _detailsController = TextEditingController();
  final _customLocationController = TextEditingController();

  // Location dropdown selection
  String? _selectedLocation;

  // Predefined locations around the Calgary region
  final List<String> _locationOptions = [
    'Calgary NW',
    'Calgary NE',
    'Calgary SW',
    'Calgary SE',
    'Airdrie',
    'Chestermere',
    'Cochrane',
    'Okotoks',
    'Other / Custom',
  ];

  // Quick-fill presets for Option 2 (Preferred Time)
  final List<String> _timePresets = [
    'ASAP',
    'This Weekend',
    'Weekday Mornings',
    'Weekday Evenings',
    'Flexible',
  ];

  List<Map<String, dynamic>> _bookings = [];

  bool _loadingBookings = false;
  bool _submitting = false;
  bool _checkingRole = true;
  bool _isAdmin = false;
  bool _isInitialized = false;

  String? _formMessage;
  bool _isFormError = false;
  String? _listMessage;

  @override
  void initState() {
    super.initState();
    _loadMyBookings();
    _loadRole();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      if (widget.forumCategory != null) {
        _categoryController.text = _serviceCategoryFromForum(
          widget.forumCategory!,
        );
      }

      if (widget.forumPostTitle != null) {
        _detailsController.text = AppLocalizations.of(context)!
            .requestedFromCommunityPost(widget.forumPostTitle!);
      }

      _isInitialized = true;
    }
  }

  String _serviceCategoryFromForum(String category) {
    switch (category) {
      case 'weather':
        return AppLocalizations.of(context)!.weatherRelatedHomeHelp;
      case 'diy':
        return AppLocalizations.of(context)!.homeRepairDiyHelp;
      case 'dining':
        return AppLocalizations.of(context)!.otherLocalAssistance;
      default:
        return AppLocalizations.of(context)!.homeServiceFallback;
    }
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _preferredTimeController.dispose();
    _detailsController.dispose();
    _customLocationController.dispose();
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

      if (!mounted) return;

      setState(() {
        _isAdmin = role == 'admin';
        _checkingRole = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _isAdmin = false;
        _checkingRole = false;
        _listMessage = AppLocalizations.of(context)!.couldNotVerifyRole(error.toString());
      });
    }
  }

  Future<void> _loadMyBookings() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      setState(() {
        _bookings = [];
        _listMessage = AppLocalizations.of(context)!.signInToViewBookings;
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
        _listMessage = AppLocalizations.of(context)!.couldNotLoadBookings(error.toString());
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
        _formMessage = AppLocalizations.of(context)!.signInBeforeBooking;
        _isFormError = true;
      });
      return;
    }

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final resolvedLocation = _selectedLocation == 'Other / Custom'
        ? _customLocationController.text.trim()
        : _selectedLocation ?? '';

    setState(() {
      _submitting = true;
      _formMessage = null;
      _isFormError = false;
    });

    try {
      final insertedBooking = await supabase
          .from('bookings')
          .insert({
            'client_id': user.id,
            'provider_id': null,
            'service_type': _categoryController.text.trim(),
            'forum_post_id': widget.forumPostId,
            'status': 'pending',
            'total_amount': 0,
            'location': resolvedLocation,
            'notes': _detailsController.text.trim(),
            'preferred_time': _preferredTimeController.text.trim(),
          })
          .select()
          .single();

      if (!mounted) return;

      _categoryController.clear();
      _preferredTimeController.clear();
      _detailsController.clear();
      _customLocationController.clear();
      setState(() {
        _selectedLocation = null;
      });

      setState(() {
        _formMessage = AppLocalizations.of(context)!.bookingSubmittedSuccess(insertedBooking['id'].toString());
        _isFormError = false;
      });

      await _loadMyBookings();
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _formMessage = AppLocalizations.of(context)!.couldNotSubmitBooking(error.toString());
        _isFormError = true;
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
          builder: (_) => const DiscoverCalgaryPage(),
        ),
        (route) => false,
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.couldNotSignOut(error.toString())),
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

  String _statusLabel(BuildContext context, String status) {
    final L = AppLocalizations.of(context)!;
    switch (status) {
      case 'pending':
        return L.statusPending;
      case 'assigned':
        return L.statusAssigned;
      case 'in_progress':
        return L.statusInProgress;
      case 'completed':
        return L.statusCompleted;
      default:
        return status.replaceAll('_', ' ');
    }
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
              Text(
                AppLocalizations.of(context)!.bookAHomeService,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.describeServiceSubtitle,
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
                    AppLocalizations.of(context)!.bookingStartedFromPost(widget.forumPostTitle!),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.serviceCategoryLabel,
                  hintText: AppLocalizations.of(context)!.serviceCategoryHint,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppLocalizations.of(context)!.enterServiceCategory;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Confined Location Selector Dropdown
              DropdownButtonFormField<String>(
                value: _selectedLocation,
                decoration: const InputDecoration(
                  labelText: 'Location / Area',
                  hintText: 'Select your community area',
                  border: OutlineInputBorder(),
                ),
                items: _locationOptions.map((location) {
                  return DropdownMenuItem<String>(
                    value: location,
                    child: Text(location),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedLocation = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a location';
                  }
                  return null;
                },
              ),
              if (_selectedLocation == 'Other / Custom') ...[
                const SizedBox(height: 12),
                TextFormField(
                  controller: _customLocationController,
                  decoration: const InputDecoration(
                    labelText: 'Specify Custom Location',
                    hintText: 'e.g., Cochrane West, Balzac',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (_selectedLocation == 'Other / Custom' &&
                        (value == null || value.trim().isEmpty)) {
                      return 'Please provide custom location details';
                    }
                    return null;
                  },
                ),
              ],
              const SizedBox(height: 16),

              // Option 2: Preferred Time Field with Quick Presets
              TextFormField(
                controller: _preferredTimeController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.preferredTimeLabel,
                  hintText: 'e.g., Weekdays after 5 PM or Sat morning',
                  border: const OutlineInputBorder(),
                  suffixIcon: _preferredTimeController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _preferredTimeController.clear();
                            });
                          },
                        )
                      : null,
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: _timePresets.map((preset) {
                  return ActionChip(
                    label: Text(preset, style: const TextStyle(fontSize: 12)),
                    onPressed: () {
                      setState(() {
                        _preferredTimeController.text = preset;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _detailsController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.describeIssueLabel,
                  hintText: AppLocalizations.of(context)!.describeIssueHint,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppLocalizations.of(context)!.describeIssueValidator;
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
                    _submitting
                        ? AppLocalizations.of(context)!.submittingEllipsis
                        : AppLocalizations.of(context)!.submitBookingButton,
                  ),
                ),
              ),
              if (_formMessage != null) ...[
                const SizedBox(height: 16),
                SelectableText(
                  _formMessage!,
                  style: TextStyle(
                    color: _isFormError
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
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.myBookings,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _loadingBookings ? null : _loadMyBookings,
                  tooltip: AppLocalizations.of(context)!.refreshBookings,
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  AppLocalizations.of(context)!.noBookingsYet,
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
                      booking['service_type']?.toString() ?? AppLocalizations.of(context)!.serviceFallback;

                  final location =
                      booking['location']?.toString() ?? AppLocalizations.of(context)!.notProvided;

                  final preferredTime =
                      booking['preferred_time']?.toString() ?? AppLocalizations.of(context)!.notProvided;

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
                              Text(AppLocalizations.of(context)!.locationValue(location)),
                              Text(AppLocalizations.of(context)!.preferredTimeValue(preferredTime)),
                              Text(AppLocalizations.of(context)!.estimatedAmountValue(amount)),
                              if (notes.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text(AppLocalizations.of(context)!.notesValue(notes)),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Chip(
                          label: Text(
                            _statusLabel(context, status),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          backgroundColor: switch (status) {
                            'pending' => Colors.orange.shade100,
                            'assigned' => Colors.blue.shade100,
                            'in_progress' => Colors.purple.shade100,
                            'completed' => Colors.green.shade100,
                            _ => Colors.grey.shade200,
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
        title: AppLocalizations.of(context)!.neighbourCareServicesTitle,
        onRefresh: _loadingBookings ? null : _loadMyBookings,
        extraActions: [
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
              tooltip: AppLocalizations.of(context)!.adminPortalTooltip,
            ),
          IconButton(
            onPressed: _openProviderPortal,
            icon: const Icon(Icons.engineering),
            tooltip: AppLocalizations.of(context)!.providerPortalTooltip,
          ),
          IconButton(
            tooltip: AppLocalizations.of(context)!.communityForumTooltip,
            icon: const Icon(Icons.forum_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryForumPage(
                    category: null,
                    title: AppLocalizations.of(context)!.community,
                  ),
                ),
              );
            },
          ),
          IconButton(
            onPressed: _signOut,
            icon: const Icon(Icons.logout),
            tooltip: AppLocalizations.of(context)!.signOutTooltip,
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