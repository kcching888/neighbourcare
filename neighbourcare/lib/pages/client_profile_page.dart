import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../services/auth_service.dart';
import '../widgets/top_banner_widget.dart';
import 'gold_points_history_page.dart';

class ClientProfilePage extends StatefulWidget {
  const ClientProfilePage({super.key});

  @override
  State<ClientProfilePage> createState() => _ClientProfilePageState();
}

class _ClientProfilePageState extends State<ClientProfilePage> {
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _neighbourhoodController = TextEditingController();

  String _loginName = '';
  String _role = '';
  bool _loading = true;
  bool _saving = false;
  String _message = '';
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    try {
      final data = await Supabase.instance.client
          .from('users')
          .select('login_name, full_name, phone, neighbourhood, role')
          .eq('id', user.id)
          .maybeSingle();

      if (data != null) {
        setState(() {
          _loginName = data['login_name'] ?? user.email ?? '';
          _fullNameController.text = data['full_name'] ?? '';
          _phoneController.text = data['phone'] ?? '';
          _neighbourhoodController.text = data['neighbourhood'] ?? '';
          _role = data['role'] ?? 'client';
        });
      } else {
        _fullNameController.text = user.userMetadata?['full_name'] ?? '';
        _phoneController.text = user.userMetadata?['phone'] ?? '';
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _message = 'Failed to load profile: $e';
          _isError = true;
        });
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Future<void> _updateProfile() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    setState(() {
      _saving = true;
      _message = '';
      _isError = false;
    });

    final fullName = _fullNameController.text.trim();
    final phone = _phoneController.text.trim();
    final neighbourhood = _neighbourhoodController.text.trim();

    try {
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(
          data: {
            'full_name': fullName,
            'phone': phone,
          },
        ),
      );

      await Supabase.instance.client.from('users').upsert({
        'id': user.id,
        'full_name': fullName,
        'phone': phone,
        'neighbourhood': neighbourhood,
      });

      if (!mounted) return;
      setState(() {
        _message = 'Profile updated successfully!';
        _isError = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _message = 'Failed to update profile: $e';
        _isError = true;
      });
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _neighbourhoodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final goldPoints = context.watch<AuthService>().goldPoint;

    return Scaffold(
      appBar: TopBannerWidget(
        title: AppLocalizations.of(context)!.neighbourCareCalgaryTitle,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: _loading
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const CircleAvatar(
                            radius: 36,
                            backgroundColor: Color(0xFF0C7A6C),
                            child: Icon(Icons.person, size: 44, color: Colors.white),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _loginName.isNotEmpty ? _loginName : (user?.email ?? 'Client'),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (user?.email != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              user!.email!,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                            ),
                          ],
                          const SizedBox(height: 16),

                          // Fixed Clickable Gold Points Badge
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.amber.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.amber.shade400),
                            ),
                            child: Material(
                              type: MaterialType.transparency,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const GoldPointsHistoryPage(),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.monetization_on,
                                        color: Colors.amber,
                                        size: 28,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Gold Points: $goldPoints',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.amber.shade900,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Icon(
                                        Icons.chevron_right,
                                        color: Colors.amber.shade900,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          TextField(
                            controller: _fullNameController,
                            decoration: const InputDecoration(
                              labelText: 'Full Name',
                              prefixIcon: Icon(Icons.person_outline),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              prefixIcon: Icon(Icons.phone_outlined),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _neighbourhoodController,
                            decoration: const InputDecoration(
                              labelText: 'Neighbourhood',
                              prefixIcon: Icon(Icons.location_city_outlined),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'Role',
                              prefixIcon: Icon(Icons.badge_outlined),
                              border: OutlineInputBorder(),
                            ),
                            child: Text(_role.toUpperCase()),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            height: 48,
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFF0C7A6C),
                              ),
                              onPressed: _saving ? null : _updateProfile,
                              child: _saving
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text('Save Changes'),
                            ),
                          ),
                          if (_message.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            Text(
                              _message,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _isError ? Colors.red : Colors.green.shade700,
                              ),
                            ),
                          ],
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}