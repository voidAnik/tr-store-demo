import 'package:flutter/material.dart';
import 'package:tr_store_demo/core/constants/app_colors.dart';

import 'text_theme.dart';

class AppTheme {
  AppTheme._();
  static ThemeData lightTheme = ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    //primaryColor: Colors.white,
    primaryColor: AppColors.primaryColor,
    // Define the default font family.

    fontFamily: 'roboto',
    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.

    textTheme: TTextTheme.lightTextTheme,
    elevatedButtonTheme:
        ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
    scrollbarTheme: const ScrollbarThemeData().copyWith(
        thumbColor: MaterialStateProperty.all(AppColors.primaryColor)),
  );
}
