import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/locale_provider.dart';
import '../services/font_size_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';

import '../widgets/top_banner_widget.dart';

class ClientSignupPage extends StatefulWidget {
  const ClientSignupPage({super.key});

  @override
  State<ClientSignupPage> createState() => _ClientSignupPageState();
}

class _ClientSignupPageState extends State<ClientSignupPage> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _loginNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _neighbourhoodController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _submitting = false;
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;
  String? _message;
  bool _isError = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _loginNameController.dispose();
    _phoneController.dispose();
    _neighbourhoodController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _createAccount() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _submitting = true;
      _message = null;
      _isError = false;
    });

    try {
      final loginName = _loginNameController.text.trim();

      // Pass user metadata directly inside auth signUp
      final response = await Supabase.instance.client.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        emailRedirectTo: 'http://localhost:32277',
        data: {
          'full_name': _fullNameController.text.trim(),
          'login_name': loginName,
          'phone': _phoneController.text.trim(),
          'neighbourhood': _neighbourhoodController.text.trim(),
        },
      );

      if (!mounted) return;

      if (response.session == null) {
        // Email confirmation is required
        setState(() {
          _message = AppLocalizations.of(context)!.accountCreatedCheckEmailReturn;
          _isError = false;
        });
      } else {
        // User logged in directly (Email confirmation disabled)
        Navigator.of(context).pop();
      }
    } on AuthException catch (error) {
      if (!mounted) return;

      setState(() {
        _message = error.message;
        _isError = true;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _message = AppLocalizations.of(context)!.couldNotCreateAccount(error.toString());
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
        title: AppLocalizations.of(context)!.createAccountTitle,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Icon(
                          Icons.person_add_alt_1_outlined,
                          size: 52,
                          color: Color(0xFF0C7A6C),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          AppLocalizations.of(context)!.joinNeighbourCare,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppLocalizations.of(context)!.createClientAccountSubtitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _fullNameController,
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.fullNameLabel,
                            hintText: AppLocalizations.of(context)!.fullNameHint,
                            prefixIcon: Icon(Icons.person_outline),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return AppLocalizations.of(context)!.enterFullName;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _loginNameController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.loginNameLabel,
                            hintText: AppLocalizations.of(context)!.loginNameHint,
                            prefixIcon: Icon(Icons.badge_outlined),
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
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.phoneNumberLabel,
                            hintText: '403-555-0123',
                            prefixIcon: Icon(Icons.phone_outlined),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return AppLocalizations.of(context)!.enterPhoneNumber;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _neighbourhoodController,
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.neighbourhoodOptionalLabel,
                            hintText: AppLocalizations.of(context)!.neighbourhoodHint,
                            prefixIcon: Icon(Icons.location_city_outlined),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.emailAddressLabel,
                            hintText: AppLocalizations.of(context)!.emailHint,
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return AppLocalizations.of(context)!.enterEmailAddress;
                            }
                            if (!value.contains('@')) {
                              return AppLocalizations.of(context)!.enterValidEmailAddress;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _hidePassword,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.passwordLabel,
                            helperText: AppLocalizations.of(context)!.passwordHelperText,
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _hidePassword = !_hidePassword;
                                });
                              },
                              icon: Icon(
                                _hidePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.length < 8) {
                              return AppLocalizations.of(context)!.passwordTooShort;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _hideConfirmPassword,
                          onFieldSubmitted: (_) => _createAccount(),
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.confirmPasswordLabel,
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _hideConfirmPassword =
                                      !_hideConfirmPassword;
                                });
                              },
                              icon: Icon(
                                _hideConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value != _passwordController.text) {
                              return AppLocalizations.of(context)!.passwordsDoNotMatch;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 48,
                          child: FilledButton.icon(
                            onPressed: _submitting ? null : _createAccount,
                            icon: _submitting
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.person_add_alt_1_outlined),
                            label: Text(
                              _submitting
                                  ? AppLocalizations.of(context)!.creatingAccountEllipsis
                                  : AppLocalizations.of(context)!.createAccountTitle,
                            ),
                          ),
                        ),
                        if (_message != null) ...[
                          const SizedBox(height: 16),
                          SelectableText(
                            _message!,
                            textAlign: TextAlign.center,
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
      ),
    );
  }
}