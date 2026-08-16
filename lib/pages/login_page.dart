import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/auth_service.dart';
import 'provider_signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;
  bool hidePassword = true;
  String message = '';

  Future<void> signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        message = 'Enter both email and password.';
      });
      return;
    }

    setState(() {
      loading = true;
      message = '';
    });

    try {
      final authService = context.read<AuthService>();
      await authService.signIn(email: email, password: password);
      // AuthGate will react to the signed-in event.
    } on AuthException catch (error) {
      if (!mounted) return;
      setState(() {
        message = error.message;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        message = 'Sign-in failed:\n$error';
      });
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  Future<void> signUp() async {
    final rawEmail = emailController.text;
     final email = rawEmail.trim();
    final password = passwordController.text;

    debugPrint('SignUp: rawEmail="$rawEmail" trimmed="$email"');


    if (email.isEmpty || password.isEmpty) {
      setState(() {
        message = 'Enter an email and password to create an account.';
      });
      return;
    }

    if (password.length < 6) {
      setState(() {
        message = 'Password must contain at least 6 characters.';
      });
      return;
    }

    setState(() {
      loading = true;
      message = '';
    });

    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
        emailRedirectTo: 'http://localhost:32277',
      );

      if (!mounted) return;

      if (response.session == null) {
        setState(() {
          message =
              'Account created. Check your email to confirm your account, '
              'then sign in.';
        });
      } else {
        setState(() {
          message = 'Account created and signed in.';
        });
      }
    } on AuthException catch (error) {
      if (!mounted) return;

      debugPrint(
        'SignUp error: ${error.message}, '
        'status=${error.statusCode}, code=${error.code}',
      );
      
      setState(() {
        message = error.message;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        message = 'Could not create account:\n$error';
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
  final email = emailController.text.trim();

  if (email.isEmpty) {
    setState(() {
      message = 'Enter the email address first, then resend confirmation.';
    });
    return;
  }

  setState(() {
    loading = true;
    message = '';
  });

  try {
    await Supabase.instance.client.auth.resend(
      type: OtpType.signup,
      email: email,
      emailRedirectTo: 'http://localhost:3000',
    );

    if (!mounted) return;

    setState(() {
      message =
          'A new confirmation email has been sent. '
          'Use only the newest link, and open it once.';
    });
  } on AuthException catch (error) {
    if (!mounted) return;

    setState(() {
      message = 'Could not resend confirmation email: ${error.message}';
    });
  } catch (error) {
    if (!mounted) return;

    setState(() {
      message = 'Could not resend confirmation email:\n$error';
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NeighbourCare Calgary'),
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
                    const Text(
                      'Welcome to NeighbourCare',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign in to book and manage home services.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'you@example.com',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      obscureText: hidePassword,
                      onSubmitted: (_) => signIn(),
                      decoration: InputDecoration(
                        labelText: 'Password',
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
                            : const Text('Sign in'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton(
                      onPressed: loading ? null : signUp,
                      child: const Text('Create test account'),
                    ),
                    const SizedBox(height: 10),
                    TextButton.icon(
                      onPressed: loading ? null : resendConfirmationEmail,
                      icon: const Icon(Icons.mark_email_unread_outlined),
                      label: const Text('Resend confirmation email'),
                    ),
                    if (message.isNotEmpty) ...[
                      const SizedBox(height: 18),
                      SelectableText(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: message.toLowerCase().contains('failed') ||
                                  message.toLowerCase().contains('error') ||
                                  message.toLowerCase().contains('invalid')
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
                      child: const Text('Apply to become a provider'),
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