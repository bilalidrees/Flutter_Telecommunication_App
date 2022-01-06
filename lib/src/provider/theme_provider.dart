import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  bool _selectedTheme = false;

  bool get selectedTheme => _selectedTheme;

  void setTheme(bool value) {
    _selectedTheme = value;
    notifyListeners();
  }
}