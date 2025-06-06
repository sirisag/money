import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/features/auth/notifiers/auth_notifier.dart';
import 'package:money/features/auth/screens/initial_setup_chooser_screen.dart';
import 'package:money/features/auth/screens/login_screen.dart';
import 'package:money/data/models/app_user.dart'; // Import UserRole
// Import your dashboard screens here once they are created
import 'package:money/features/treasurer/screens/treasurer_dashboard_screen.dart';
import 'package:money/features/driver/screens/driver_dashboard_screen.dart';
import 'package:money/features/monk/screens/monk_dashboard_screen.dart';

class AuthWrapperScreen extends ConsumerWidget {
  const AuthWrapperScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    switch (authState.status) {
      case AuthStatus.unknown:
        // Show a loading indicator while checking auth status
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case AuthStatus.firstTimeSetup:
        return const InitialSetupChooserScreen();
      case AuthStatus.unauthenticated:
        return const LoginScreen();
      case AuthStatus.authenticated:
        if (authState.currentUser == null ||
            authState.currentRole == null ||
            authState.currentRole == UserRole.unknown) {
          // This case should ideally not happen if authenticated, but it's a safeguard.
          // Consider logging out or showing an error.
          // Using WidgetsBinding.instance.addPostFrameCallback to avoid calling setState during build.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(authNotifierProvider.notifier).logout();
          });
          return const Scaffold(
            body: Center(child: Text('Authentication error. Logging out...')),
          );
        }
        switch (authState.currentRole!) {
          case UserRole.treasurer:
            return const TreasurerDashboardScreen();
          case UserRole.driver:
            return const DriverDashboardScreen();
          case UserRole.monk:
            return const MonkDashboardScreen();
          default:
            // Fallback, or perhaps logout if role is truly unknown/invalid
            return Scaffold(
              body: Center(
                child: Text(
                  'Authenticated! Unknown Role: ${authState.currentRole}',
                ),
              ),
            );
        }
    }
  }
}
