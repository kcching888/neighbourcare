import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _nameController = TextEditingController();

  bool _loading = true;
  bool _saving = false;
  String? _message;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      if (mounted) {
        setState(() {
          _loading = false;
          _message = 'Please sign in to view your profile.';
        });
      }
      return;
    }

    try {
      final profile = await Supabase.instance.client
          .from('users')
          .select('fullname, email, role')
          .eq('id', user.id)
          .maybeSingle();

      if (!mounted) return;

      setState(() {
        _nameController.text =
            profile?['fullname']?.toString() ??
            user.userMetadata?['full_name']?.toString() ??
            '';
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _loading = false;
        _message = 'Could not load profile: $error';
      });
    }
  }

  Future<void> _saveProfile() async {
    final user = Supabase.instance.client.auth.currentUser;
    final fullName = _nameController.text.trim();

    if (user == null) {
      setState(() {
        _message = 'Please sign in before updating your profile.';
      });
      return;
    }

    if (fullName.isEmpty) {
      setState(() {
        _message = 'Enter a name to display in the app.';
      });
      return;
    }

    setState(() {
      _saving = true;
      _message = null;
    });

    try {
      await Supabase.instance.client
          .from('users')
          .update({'fullname': fullName})
          .eq('id', user.id);

      await Supabase.instance.client.auth.updateUser(
        UserAttributes(
          data: {'full_name': fullName},
        ),
      );

      if (!mounted) return;

      setState(() {
        _message = 'Profile updated successfully.';
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _message = 'Could not update profile: $error';
      });
    } finally {
      if (mounted) {
        setState(() {
          _saving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My profile'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  child: Icon(Icons.person, size: 30),
                                ),
                                SizedBox(width: 16),
                                Text(
                                  'Your account',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Email',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            SelectableText(user?.email ?? 'Not available'),
                            const SizedBox(height: 20),
                            TextField(
                              controller: _nameController,
                              textCapitalization: TextCapitalization.words,
                              decoration: const InputDecoration(
                                labelText: 'Display name',
                                hintText: 'Enter your name',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton.icon(
                                onPressed: _saving ? null : _saveProfile,
                                icon: _saving
                                    ? const SizedBox(
                                        height: 18,
                                        width: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Icon(Icons.save_outlined),
                                label: Text(
                                  _saving ? 'Saving...' : 'Save profile',
                                ),
                              ),
                            ),
                            if (_message != null) ...[
                              const SizedBox(height: 16),
                              Text(
                                _message!,
                                style: TextStyle(
                                  color: _message!.startsWith('Could not') ||
                                          _message!.startsWith('Please') ||
                                          _message!.startsWith('Enter')
                                      ? Colors.red
                                      : Colors.green.shade700,
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
      ),
    );
  }
}