import 'package:alab_technology_test/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  ThemeProvider() {
    _loadThemePreference();
  }

  // Toggle between light and dark mode
  void toggleTheme(bool isOn) {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    _saveThemePreference(isOn);
    notifyListeners();
  }

  // Set theme directly
  void setTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    _saveThemePreference(themeMode == ThemeMode.dark);
    notifyListeners();
  }

  // Get current theme data
  ThemeData get currentTheme {
    return _themeMode == ThemeMode.dark ? AppTheme.darkTheme : AppTheme.lightTheme;
  }

  // Save theme preference to SharedPreferences
  Future<void> _saveThemePreference(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  // Load theme preference from SharedPreferences
  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}