import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode themeMode;

  ThemeData lightMode = ThemeData.light(useMaterial3: true);
  ThemeData darkMode = ThemeData.dark(useMaterial3: true);

  ThemeManager({required this.themeMode});

  static const int defaultThemeIndex = 0;

  static const Map<int, ThemeMode> modeMapper = {
    0: ThemeMode.light,
    1: ThemeMode.dark,
    2: ThemeMode.system,
  };

  void setThemeMode(ThemeMode selectedMode) {
    themeMode = selectedMode;
    _saveThemeModePreference();
    notifyListeners();
  }

  void _saveThemeModePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('theme', themeIndex());
  }

  int themeIndex() {
    for (int index in modeMapper.keys) {
      if (themeMode == modeMapper[index]) return index;
    }
    return defaultThemeIndex;
  }
}
