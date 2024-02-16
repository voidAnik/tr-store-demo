import 'package:flutter/material.dart';

class TTextTheme {
  static TextTheme lightTextTheme = const TextTheme(
    headlineLarge: TextStyle(
        fontSize: 24.0,
        fontFamily: 'roboto',
        fontWeight: FontWeight.w700,
        color: Colors.black),
    headlineMedium: TextStyle(
        fontSize: 20.0,
        fontFamily: 'roboto',
        fontWeight: FontWeight.w600,
        color: Colors.black),
    headlineSmall: TextStyle(
        fontSize: 16.0,
        fontFamily: 'roboto',
        fontWeight: FontWeight.w400,
        color: Colors.black),
    titleLarge: TextStyle(
        fontSize: 20.0,
        fontFamily: 'roboto',
        fontWeight: FontWeight.w600,
        color: Colors.black),
    titleMedium: TextStyle(
        fontSize: 16.0,
        fontFamily: 'roboto',
        fontWeight: FontWeight.w500,
        color: Colors.black),
    titleSmall: TextStyle(
        fontSize: 14.0,
        fontFamily: 'roboto',
        fontWeight: FontWeight.w400,
        color: Colors.black),
    bodyLarge:
        TextStyle(fontSize: 16.0, fontFamily: 'roboto', color: Colors.black),
    bodyMedium:
        TextStyle(fontSize: 14.0, fontFamily: 'roboto', color: Colors.black),
    bodySmall:
        TextStyle(fontSize: 12.0, fontFamily: 'roboto', color: Colors.black),
  );
}
