import 'package:flutter/material.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Define your primary and accent colors
  // You can use online color pickers to find suitable hex codes
  // Example colors (you should replace these with your preferred colors)
  static const Color _primaryColor = Color(0xFF2E7D32); // A shade of green
  static const Color _primaryColorLight = Color(0xFF60AD5E);
  static const Color _primaryColorDark = Color(0xFF005005);

  static const Color _accentColor = Color(
    0xFFFFC107,
  ); // A shade of amber/yellow

  static const Color _textColorPrimary = Color(
    0xFF212121,
  ); // Dark grey for text
  static const Color _textColorSecondary = Color(
    0xFF757575,
  ); // Lighter grey for secondary text

  // Light Theme Definition
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: _primaryColor,
    primaryColorLight: _primaryColorLight,
    primaryColorDark: _primaryColorDark,
    // accentColor is deprecated, use colorScheme.secondary instead
    colorScheme: const ColorScheme.light(
      primary: _primaryColor,
      secondary: _accentColor,
      onPrimary: Colors.white, // Text/icon color on primary color
      onSecondary: Colors.black, // Text/icon color on secondary color
      error: Colors.redAccent,
    ),
    scaffoldBackgroundColor: Colors.grey[100], // Light grey background
    appBarTheme: const AppBarTheme(
      color: _primaryColor,
      elevation: 4.0,
      iconTheme: IconThemeData(color: Colors.white), // Icon color on AppBar
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: _textColorPrimary),
      bodyMedium: TextStyle(color: _textColorSecondary),
      // Define other text styles as needed (headline, title, caption, etc.)
    ),
    // You can customize other theme properties like buttonTheme, cardTheme, etc.
  );

  // Optionally, define a Dark Theme here in a similar way
  // static final ThemeData darkTheme = ThemeData(...);
}
