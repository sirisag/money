// lib/main.dart
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; // Import for date formatting initialization
import 'package:money/screens/auth/universal_login_setup_screen.dart';
// import 'package:money/services/database_helper.dart'; // หากมีการใช้งาน DB ใน main

// Global instance of SharedPreferences
// SharedPreferences? globalPrefs; // คุณสามารถใช้ SharedPreferences.getInstance() โดยตรงในหน้าที่ต้องการได้
// หรือถ้าจะใช้ global instance ก็ตรวจสอบให้แน่ใจว่ามีการจัดการ lifecycle ที่เหมาะสม

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize date formatting for the Thai locale
  await initializeDateFormatting('th_TH', null);

  // Initialize SharedPreferences if you plan to use a global instance
  // globalPrefs = await SharedPreferences.getInstance();

  // Initialize database (optional here, as it will be initialized when first called by DatabaseHelper)
  // await DatabaseHelper().database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'แอปจัดการเงินวัด',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
      // Start with the new universal login/setup screen
      home: const UniversalLoginSetupScreen(),
    );
  }
}
