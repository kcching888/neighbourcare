import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/locale_provider.dart';
import '../services/font_size_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';

import '../widgets/top_banner_widget.dart';

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
  bool _isError = false;

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
          _message = AppLocalizations.of(context)!.signInToViewProfile;
          _isError = true;
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
        _message = AppLocalizations.of(context)!.couldNotLoadProfile(error.toString());
        _isError = true;
      });
    }
  }

  Future<void> _saveProfile() async {
    final user = Supabase.instance.client.auth.currentUser;
    final fullName = _nameController.text.trim();

    if (user == null) {
      setState(() {
        _message = AppLocalizations.of(context)!.signInBeforeUpdatingProfile;
        _isError = true;
      });
      return;
    }

    if (fullName.isEmpty) {
      setState(() {
        _message = AppLocalizations.of(context)!.enterDisplayName;
        _isError = true;
      });
      return;
    }

    setState(() {
      _saving = true;
      _message = null;
      _isError = false;
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
        _message = AppLocalizations.of(context)!.profileUpdatedSuccess;
        _isError = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _message = AppLocalizations.of(context)!.couldNotUpdateProfile(error.toString());
        _isError = true;
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
    final localeProvider = Provider.of<LocaleProvider>(context);
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);
    final user = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      appBar: TopBannerWidget(
        fontScale: fontSizeProvider.scaleFactor,
        onLanguageChanged: (locale) {
          localeProvider.setLocale(locale);
        },
        onFontScaleChanged: (scale) {
          fontSizeProvider.setScaleFactor(scale);
        },
        title: AppLocalizations.of(context)!.myProfileTitle,
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
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 28,
                                  child: Icon(Icons.person, size: 30),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  AppLocalizations.of(context)!.yourAccountTitle,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Text(
                              AppLocalizations.of(context)!.emailLabel,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            SelectableText(user?.email ?? AppLocalizations.of(context)!.notAvailable),
                            const SizedBox(height: 20),
                            TextField(
                              controller: _nameController,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.displayNameLabel,
                                hintText: AppLocalizations.of(context)!.enterYourNameHint,
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
                                  _saving ? AppLocalizations.of(context)!.savingEllipsis : AppLocalizations.of(context)!.saveProfileButton,
                                ),
                              ),
                            ),
                            if (_message != null) ...[
                              const SizedBox(height: 16),
                              Text(
                                _message!,
                                style: TextStyle(
                                  color: _isError
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