import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: Colors.deepPurple,
  scaffoldBackgroundColor: const Color(0xFFF3E5F5),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.deepPurple,
  ).copyWith(
    primary: Colors.deepPurple,
    secondary: Colors.deepPurpleAccent,
    surface: const Color(0xFFF3E5F5),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.deepPurple[700],
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFF4A148C)),
    bodyMedium: TextStyle(color: Color(0xFF6A1B9A)),
    bodySmall: TextStyle(color: Color(0xFF8E24AA)),
    labelLarge: TextStyle(color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.deepPurple,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepPurple,
    foregroundColor: Colors.white,
  ),
  iconTheme: IconThemeData(
    color: Colors.deepPurple[700],
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFF3E5F5),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
      borderRadius: BorderRadius.circular(12),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 1.5),
      borderRadius: BorderRadius.circular(12),
    ),
    hintStyle: TextStyle(color: Colors.deepPurple[300]),
    labelStyle: TextStyle(color: Colors.deepPurple[700]),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: const Color(0xFFF3E5F5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    titleTextStyle: const TextStyle(color: Colors.deepPurple, fontSize: 20),
    contentTextStyle: TextStyle(color: Colors.deepPurple[700]),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.deepPurple,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.deepPurple[100],
  ),
);
