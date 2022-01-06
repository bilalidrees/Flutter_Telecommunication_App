import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  BuildContext? _context;
  static AppColors? _instance;

  AppColors(_context) {
    this._context = _context;
  }

  factory AppColors.of(BuildContext context) {
    if (_instance == null) _instance = AppColors(context);
    return _instance!;
  }

//  Color _mainColor = Color(0xFFFF4E6A);
  Color _mainColor = Color(0xFF8bc53f);
  Color _mainDarkColor = Color(0xFFea5c44);
  Color _secondColor = Color(0xFF000000);
  Color _facebookColor = Color(0xFF3b5998);
  Color _secondDarkColor = Color(0xFFccccdd);
  Color _accentColor = Color(0xFF8C98A8);
  Color _accentDarkColor = Color(0xFF9999aa);

  static Color mainScreenColor = Color(0xFFc01010);
  static Color itemBackgroundScreenColor = Color(0xFF272727);
  static Color darkBackgroundScreenColor = Color(0xFF393232);


  static Color greyScreenColor = Color(0xFFFCFCFC);

  static Color customButtonColorYellow = const Color(0xFFFFCC00);
  static const Color white = const Color(0xFFFFFFFF);

  static const Color google_signin = const Color(0xFFdd4b39);
  static const Color deliveryStatusHighlightColor = const Color(0xFF005295);
  static const Color dim_grey = const Color(0xFF6f6f6f);
  static Color black = const Color(0xFF000000);
  static Color fbColor = const Color(0xFF3b5998);
  static Color davyGrey = const Color.fromARGB(10, 85, 85, 85);

  static Color whiteSmoke = const Color(0xFFf4f7f9);
  static Color selectedButtonColor = const Color(0xFF8bc53f);
  static Color timberWolf = const Color(0xFFD0D0D0);
  static Color greyTextColor = const Color(0xFFF8F8F8);

  static Color buttonDisableColor = const Color(0xFFCCFF90).withOpacity(0.5);
  static Color buttonDisableTextColor = const Color(0xFF6f6f6f);

  // ignore: non_constant_identifier_names
  static Color buttonDenied = const Color(0xFFc8171d);
  static Color textHighlightColor = const Color(0xFF3b5998);
  static Color buttonSaveColor = const Color(0xFF004b8f);
  //ufone Theme Colors
  static const greenColor = Color(0xff81B214);
  static const orangeColor = Color(0xffFF7600);

  static const MaterialColor whiteAppBar = MaterialColor(
    _greyPrimaryValue,
    <int, Color>{
      50: Color(0xFFFAFAFA),
      100: Color(0xFFF5F5F5),
      200: Color(0xFFEEEEEE),
      300: Color(0xFFE0E0E0),
      350: Color(0xFFD6D6D6), // only for raised button while pressed in light theme
      400: Color(0xFFBDBDBD),
      500: Color(_greyPrimaryValue),
      600: Color(0xFF757575),
      700: Color(0xFF616161),
      800: Color(0xFF424242),
      850: Color(0xFF303030), // only for background color in dark theme
      900: Color(0xFF212121),
    },
  );
  static const int _greyPrimaryValue = 0xFFFFFFFF;

  Color setOpacity(double opacity) {
    return customButtonColorYellow.withOpacity(opacity);
  }

  Color mainColor(double opacity) {
    return this._mainDarkColor.withOpacity(opacity);
  }

  Color secondColor(double opacity) {
    return this._secondColor.withOpacity(opacity);
  }

  Color facebookColor(double opacity) {
    return this._facebookColor.withOpacity(opacity);
  }

  Color accentColor(double opacity) {
    return this._accentColor.withOpacity(opacity);
  }

  Color mainDarkColor(double opacity) {
    return this._mainDarkColor.withOpacity(opacity);
  }

  Color secondDarkColor(double opacity) {
    return this._secondDarkColor.withOpacity(opacity);
  }

  Color accentDarkColor(double opacity) {
    return this._accentDarkColor.withOpacity(opacity);
  }
}
