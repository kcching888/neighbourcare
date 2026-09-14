import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';

import '../widgets/top_banner_widget.dart';
import 'login_page.dart';

final supabase = Supabase.instance.client;

class ProviderSignupPage extends StatefulWidget {
  const ProviderSignupPage({super.key});

  @override
  State<ProviderSignupPage> createState() => _ProviderSignupPageState();
}

class _ProviderSignupPageState extends State<ProviderSignupPage> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _loginNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _submitting = false;
  String? _message;
  bool _isError = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _loginNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

Future<void> _submitProviderApplication() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _submitting = true;
      _message = null;
      _isError = false;
    });

    try {
      final loginName = _loginNameController.text.trim();

      final response = await supabase.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        data: {
          'first_name': _firstNameController.text.trim(),
          'last_name': _lastNameController.text.trim(),
          'login_name': loginName,
        },
      );

      final user = response.user;

      debugPrint('Signup user ID: ${user?.id}');
debugPrint('Signup session exists: ${response.session != null}');
debugPrint(
  'Current session after signup: '
  '${supabase.auth.currentSession != null}',
);
debugPrint(
  'Current user after signup: '
  '${supabase.auth.currentUser?.id}',
);

      if (user == null) {
        throw Exception('Account creation did not return a user.');
      }

      try {
        await supabase
            .from('users')
            .update({'login_name': loginName})
            .eq('id', user.id);
      } on PostgrestException catch (error) {
        if (!mounted) return;
        setState(() {
          _message = error.code == '23505'
              ? AppLocalizations.of(context)!.loginNameTaken
              : AppLocalizations.of(context)!.couldNotSaveLoginName(error.message);
          _isError = true;
          _submitting = false;
        });
        return;
      }

      await supabase.from('providers').insert({
        'user_id': user.id,
        'pvsc_verified': false,
        'rating_avg': 0,
      });

      if (!mounted) return;

      setState(() {
        _message = AppLocalizations.of(context)!.applicationSubmittedPendingApproval;
        _isError = false;
      });
    } on AuthException catch (error) {
      if (!mounted) return;

      setState(() {
        _message = AppLocalizations.of(context)!.couldNotCreateAccount(error.message);
        _isError = true;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _message = AppLocalizations.of(context)!.couldNotSubmitApplication(error.toString());
        _isError = true;
      });
    } finally {
      if (mounted) {
        setState(() {
          _submitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBannerWidget(
        title: AppLocalizations.of(context)!.becomeAProviderTitle,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.providerApplicationTitle,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppLocalizations.of(context)!.submitApplicationSubtitle,
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.firstNameLabel,
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return AppLocalizations.of(context)!.enterFirstName;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.lastNameLabel,
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return AppLocalizations.of(context)!.enterLastName;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _loginNameController,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.loginNameLabel,
                            hintText: AppLocalizations.of(context)!.loginNameHint,
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            final trimmed = value?.trim() ?? '';
                            if (trimmed.isEmpty) {
                              return AppLocalizations.of(context)!.enterLoginName;
                            }
                            if (trimmed.length < 3) {
                              return AppLocalizations.of(context)!.loginNameMinLength;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.emailLabel,
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null ||
                                !value.trim().contains('@')) {
                              return AppLocalizations.of(context)!.enterValidEmailAddress;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.passwordLabel,
                            helperText: AppLocalizations.of(context)!.passwordHelperText,
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.length < 8) {
                              return AppLocalizations.of(context)!.passwordMinLength8;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        FilledButton.icon(
                          onPressed:
                              _submitting ? null : _submitProviderApplication,
                          icon: _submitting
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.send),
                          label: Text(
                            _submitting
                                ? AppLocalizations.of(context)!.submittingEllipsis
                                : AppLocalizations.of(context)!.submitApplicationButton,
                          ),
                        ),
                        if (_message != null) ...[
                          const SizedBox(height: 16),
                          SelectableText(
                            _message!,
                            style: TextStyle(
                              color: _isError
                                  ? Colors.red
                                  : Colors.green.shade700,
                            ),
                          ),
                        ],
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const LoginPage(),
                              ),
                            );
                          },
                          child: Text(AppLocalizations.of(context)!.backToSignIn),
                        ),
                      ],
                    ),
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