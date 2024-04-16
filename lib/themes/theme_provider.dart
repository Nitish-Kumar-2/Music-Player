import "package:flutter/material.dart";
import "package:music_player/themes/dark_mode.dart";
import "package:music_player/themes/light_mode.dart";

class ThemeProvider extends ChangeNotifier {
  // intially , Light Mode
  ThemeData _themeData = lightMode;
  // get Theme
  ThemeData get themeData => _themeData;
  // Is Dark Mode
  bool get isDarkMode => _themeData == darkMode;
  // set Theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;

    // update UI
    notifyListeners();
  }

  // toggle theme
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
