import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum AppTheme { system, light, dark, navy }

class ThemeService extends ChangeNotifier {
  static const _storage = FlutterSecureStorage();
  static const _themeKey = 'selected_app_theme';

  AppTheme _currentTheme = AppTheme.navy;

  ThemeService() {
    _loadTheme();
  }

  AppTheme get currentTheme => _currentTheme;

  Future<void> _loadTheme() async {
    final savedTheme = await _storage.read(key: _themeKey);
    if (savedTheme != null) {
      _currentTheme = AppTheme.values.firstWhere(
        (e) => e.name == savedTheme,
        orElse: () => AppTheme.navy,
      );
      notifyListeners();
    }
  }

  Future<void> setTheme(AppTheme theme) async {
    _currentTheme = theme;
    await _storage.write(key: _themeKey, value: theme.name);
    notifyListeners();
  }

  ThemeMode get themeMode {
    switch (_currentTheme) {
      case AppTheme.light:
        return ThemeMode.light;
      case AppTheme.dark:
      case AppTheme.navy:
        return ThemeMode.dark;
      case AppTheme.system:
        return ThemeMode.system;
    }
  }

  ThemeData get lightTheme {
    return _buildTheme(Brightness.light, Colors.white, Colors.grey[100]!);
  }

  ThemeData get darkTheme {
    return _buildTheme(Brightness.dark, Colors.black, const Color(0xFF111827));
  }

  ThemeData get navyTheme {
    return _buildTheme(Brightness.dark, const Color(0xFF0B1220), const Color(0xFF111827));
  }

  ThemeData get currentThemeData {
    switch (_currentTheme) {
      case AppTheme.light:
        return lightTheme;
      case AppTheme.dark:
        return darkTheme;
      case AppTheme.navy:
        return navyTheme;
      case AppTheme.system:
        return lightTheme; // Default to light for system if requested specifically
    }
  }

  ThemeData _buildTheme(Brightness brightness, Color scaffoldBg, Color cardBg) {
    const primary = Color(0xFF6366F1);
    final textColor = brightness == Brightness.dark ? Colors.white : Colors.black;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      primaryColor: primary,
      scaffoldBackgroundColor: scaffoldBg,
      cardColor: cardBg,
      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldBg,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      dividerColor: brightness == Brightness.dark ? Colors.white10 : Colors.black12,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: brightness,
        surface: scaffoldBg,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(color: textColor),
        bodyMedium: TextStyle(color: textColor.withValues(alpha: 0.7)),
      ),
    );
  }
}
