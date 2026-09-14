import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';

import '../widgets/top_banner_widget.dart';
import 'provider_signup_page.dart';
import 'provider_portal_page.dart';
import 'services_booking_page.dart';
import 'client_signup_page.dart';

class LoginPage extends StatefulWidget {
  final bool openProviderPortal;

  const LoginPage({
    super.key,
    this.openProviderPortal = false,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final identifierController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();

  bool loading = false;
  bool hidePassword = true;
  String message = '';
  bool _isError = false;

  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> signIn() async {
    final input = identifierController.text.trim();
    final password = passwordController.text;

    if (input.isEmpty || password.isEmpty) {
      setState(() {
        message = AppLocalizations.of(context)!.enterSignupDetails;
        _isError = true;
      });
      return;
    }

    setState(() {
      loading = true;
      message = '';
      _isError = false;
    });

    try {
      String targetEmail = input;

      // If input is a login_name, resolve email via RPC function from auth.users
      if (!input.contains('@')) {
        final String? resolvedEmail = await _supabase.rpc(
          'get_email_by_login_name',
          params: {'p_login_name': input},
        );

        if (resolvedEmail == null || resolvedEmail.isEmpty) {
          throw const AuthException('Invalid login name or password.');
        }

        targetEmail = resolvedEmail;
      }

      // Authenticate against Supabase Auth using resolved email
      final response = await _supabase.auth.signInWithPassword(
        email: targetEmail,
        password: password,
      );

      debugPrint(
        'Sign-in completed. User ID: ${response.user?.id}, Session exists: ${response.session != null}',
      );

      if (!mounted) return;

      if (widget.openProviderPortal) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const ProviderPortalPage()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const ServicesBookingPage()),
        );
      }
    } on AuthException catch (error) {
      if (!mounted) return;
      debugPrint(
        'Sign-in error: ${error.message}, status: ${error.statusCode}, code: ${error.code}',
      );
      setState(() {
        message = error.message;
        _isError = true;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        message = error.toString();
        _isError = true;
      });
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  Future<void> resendConfirmationEmail() async {
    final email = identifierController.text.trim();

    if (email.isEmpty) {
      setState(() {
        message = AppLocalizations.of(context)!.enterEmailFirstResend;
        _isError = true;
      });
      return;
    }

    setState(() {
      loading = true;
      message = '';
      _isError = false;
    });

    try {
      await _supabase.auth.resend(
        type: OtpType.signup,
        email: email,
        emailRedirectTo: 'http://localhost:3000',
      );

      if (!mounted) return;

      setState(() {
        message = AppLocalizations.of(context)!.confirmationEmailResent;
        _isError = false;
      });
    } on AuthException catch (error) {
      if (!mounted) return;
      setState(() {
        message = AppLocalizations.of(context)!.couldNotResendConfirmation(error.message);
        _isError = true;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        message = AppLocalizations.of(context)!.couldNotResendConfirmation(error.toString());
        _isError = true;
      });
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    identifierController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBannerWidget(
        title: AppLocalizations.of(context)!.neighbourCareCalgaryTitle,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(
                      Icons.home_work_outlined,
                      size: 58,
                      color: Color(0xFF0C7A6C),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.welcomeToNeighbourCare,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context)!.signInSubtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: identifierController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Email or Username',
                        hintText: 'Enter your email or username',
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      obscureText: hidePassword,
                      onSubmitted: (_) => signIn(),
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.passwordLabel,
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 48,
                      child: FilledButton(
                        onPressed: loading ? null : signIn,
                        child: loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(AppLocalizations.of(context)!.signIn),
                      ),
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton(
                      onPressed: loading
                          ? null
                          : () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const ClientSignupPage(),
                                ),
                              );
                            },
                      child: Text(AppLocalizations.of(context)!.newToNeighbourCareSignUp),
                    ),
                    const SizedBox(height: 10),
                    TextButton.icon(
                      onPressed: loading ? null : resendConfirmationEmail,
                      icon: const Icon(Icons.mark_email_unread_outlined),
                      label: Text(AppLocalizations.of(context)!.resendConfirmationEmail),
                    ),
                    if (message.isNotEmpty) ...[
                      const SizedBox(height: 18),
                      SelectableText(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _isError
                              ? Colors.red
                              : Colors.green.shade700,
                        ),
                      ),
                    ],
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ProviderSignupPage(),
                          ),
                        );
                      },
                      child: Text(AppLocalizations.of(context)!.applyToBecomeProvider),
                    ),
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