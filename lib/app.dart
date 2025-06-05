import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart'; // We will create this for custom theming
import 'features/auth/screens/auth_wrapper_screen.dart'; // Import the new wrapper
import 'core/navigation/app_router.dart'; // Import the AppRouter

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'แอปจัดการเงินวัด',
      debugShowCheckedModeBanner: false, // Removes the debug banner
      theme: AppTheme.lightTheme, // Using a custom light theme
      // darkTheme: AppTheme.darkTheme, // Optionally, define a dark theme
      // themeMode: ThemeMode.system, // Or ThemeMode.light, ThemeMode.dark

      // Use AuthWrapperScreen as the home to handle initial routing logic
      home: const AuthWrapperScreen(),
      // Use the onGenerateRoute from AppRouter for named navigation
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
