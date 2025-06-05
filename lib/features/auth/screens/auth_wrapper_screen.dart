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
        // Navigate to the correct dashboard based on the role
        // This is where you'd implement role-based navigation
        // For now, let's show a placeholder
        // if (authState.currentRole == UserRole.treasurer) {
        //   return const TreasurerDashboardScreen();
        // } else if (authState.currentRole == UserRole.driver) {
        //   return const DriverDashboardScreen();
        // } else if (authState.currentRole == UserRole.monk) {
        //   return const MonkDashboardScreen();
        // }
        return Scaffold(
          body: Center(
            child: Text('Authenticated! Role: ${authState.currentRole}'),
          ),
        );
    }
  }
}
