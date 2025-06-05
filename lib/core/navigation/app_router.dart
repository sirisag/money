import 'package:flutter/material.dart';
import 'package:money/features/auth/screens/initial_setup_chooser_screen.dart';
import 'package:money/features/auth/screens/login_screen.dart';
import 'package:money/features/auth/screens/treasurer_initial_setup_screen.dart';
// Import other screens as they are created
import 'package:money/features/treasurer/screens/treasurer_dashboard_screen.dart';
import 'package:money/features/driver/screens/driver_dashboard_screen.dart';
import 'package:money/features/monk/screens/monk_dashboard_screen.dart';

class AppRoutes {
  static const String initialSetupChooser = '/initial-setup-chooser';
  static const String treasurerInitialSetup = '/treasurer-initial-setup';
  static const String login = '/login';
  static const String treasurerDashboard = '/treasurer-dashboard';
  static const String driverDashboard = '/driver-dashboard';
  static const String monkDashboard = '/monk-dashboard';
  // Add other routes here
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.initialSetupChooser:
        return MaterialPageRoute(
          builder: (_) => const InitialSetupChooserScreen(),
        );
      case AppRoutes.treasurerInitialSetup:
        return MaterialPageRoute(
          builder: (_) => const TreasurerInitialSetupScreen(),
        );
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.treasurerDashboard:
        return MaterialPageRoute(
          builder: (_) => const TreasurerDashboardScreen(),
        );
      case AppRoutes.driverDashboard:
        return MaterialPageRoute(builder: (_) => const DriverDashboardScreen());
      case AppRoutes.monkDashboard:
        return MaterialPageRoute(builder: (_) => const MonkDashboardScreen());
      default:
        // If the route is not found, you can navigate to a default page or an error page
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
