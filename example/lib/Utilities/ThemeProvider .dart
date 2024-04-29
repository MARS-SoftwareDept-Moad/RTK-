// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _currentTheme = ThemeMode.light;
  ThemeMode get currentTheme => _currentTheme;

  bool get isDarkMode => _currentTheme == ThemeMode.dark;

  String _selectedImage = 'assets/LightMood.PNG'; // Default image
  String get selectedImage => _selectedImage;

  void toggleTheme() {
    _currentTheme =
        (_currentTheme == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    _selectedImage =
        isDarkMode ? 'assets/DarkMood.PNG' : 'assets/LightMood.PNG';
    notifyListeners();
  }
}
