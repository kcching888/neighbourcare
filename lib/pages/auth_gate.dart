import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import 'login_page.dart';
import 'services_booking_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();

    if (authService.loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (authService.error != null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Authentication error:\n${authService.error}',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    if (authService.session == null) {
      return const LoginPage();
    }

    return const ServicesBookingPage();
  }
}