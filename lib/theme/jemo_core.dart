import 'package:flutter/material.dart';

class JemoCoreTheme {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  static const double borderRadiusValue = 10.0;
  static const double borderWidthValue = 2.5;

  static const String fontFamily = 'Roboto';

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: black,
        onPrimary: white,
        secondary: white,
        onSecondary: black,
        surface: white,
        onSurface: black,
        error: Colors.redAccent,
        onError: white,
        outline: black,
      ),
      scaffoldBackgroundColor: white,
      fontFamily: fontFamily,
      appBarTheme: const AppBarTheme(
        backgroundColor: black,
        foregroundColor: white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
        shape: Border(
          bottom: BorderSide(color: white, width: borderWidthValue),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: black,
          fontSize: 32,
        ),
        displayMedium: TextStyle(
          fontWeight: FontWeight.bold,
          color: black,
          fontSize: 24,
        ),
        displaySmall: TextStyle(
          fontWeight: FontWeight.bold,
          color: black,
          fontSize: 18,
        ),
        headlineMedium: TextStyle(fontWeight: FontWeight.bold, color: black),
        labelLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: white,
          letterSpacing: 1.1,
        ),
        bodyLarge: TextStyle(color: black),
        bodyMedium: TextStyle(color: black),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: black,
          foregroundColor: white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusValue),
            side: const BorderSide(color: white, width: borderWidthValue),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: white,
          foregroundColor: black,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          side: const BorderSide(color: black, width: borderWidthValue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusValue),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue),
          side: const BorderSide(color: black, width: borderWidthValue),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue),
          borderSide: const BorderSide(color: black, width: borderWidthValue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue),
          borderSide: const BorderSide(color: black, width: borderWidthValue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue),
          borderSide: const BorderSide(
            color: black,
            width: borderWidthValue + 1,
          ),
        ),
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, color: black),
        hintStyle: TextStyle(color: black.withAlpha(150)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: black,
        foregroundColor: white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue),
          side: const BorderSide(color: white, width: borderWidthValue),
        ),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue),
          side: const BorderSide(color: black, width: borderWidthValue),
        ),
        tileColor: white,
        textColor: black,
        iconColor: black,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue),
          side: const BorderSide(color: black, width: borderWidthValue),
        ),
        titleTextStyle: const TextStyle(
          color: black,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: white,
        onPrimary: black,
        secondary: black,
        onSecondary: white,
        surface: black,
        onSurface: white,
        error: Colors.redAccent,
        onError: black,
        outline: white,
      ),
      scaffoldBackgroundColor: black,
      fontFamily: fontFamily,
      appBarTheme: const AppBarTheme(
        backgroundColor: black,
        foregroundColor: white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
        shape: Border(
          bottom: BorderSide(color: white, width: borderWidthValue),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: white,
          fontSize: 32,
        ),
        displayMedium: TextStyle(
          fontWeight: FontWeight.bold,
          color: white,
          fontSize: 24,
        ),
        displaySmall: TextStyle(
          fontWeight: FontWeight.bold,
          color: white,
          fontSize: 18,
        ),
        headlineMedium: TextStyle(fontWeight: FontWeight.bold, color: white),
        labelLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: black,
          letterSpacing: 1.1,
        ),
        bodyLarge: TextStyle(color: white),
        bodyMedium: TextStyle(color: white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: white,
          foregroundColor: black,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusValue),
            side: const BorderSide(color: black, width: borderWidthValue),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: black,
          foregroundColor: white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          side: const BorderSide(color: white, width: borderWidthValue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusValue),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: black,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue),
          side: const BorderSide(color: white, width: borderWidthValue),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue),
          borderSide: const BorderSide(color: white, width: borderWidthValue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue),
          borderSide: const BorderSide(color: white, width: borderWidthValue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue),
          borderSide: const BorderSide(
            color: white,
            width: borderWidthValue + 1,
          ),
        ),
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, color: white),
        hintStyle: TextStyle(color: white.withAlpha(150)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: white,
        foregroundColor: black,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue),
          side: const BorderSide(color: black, width: borderWidthValue),
        ),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue),
          side: const BorderSide(color: white, width: borderWidthValue),
        ),
        tileColor: black,
        textColor: white,
        iconColor: white,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue),
          side: const BorderSide(color: white, width: borderWidthValue),
        ),
        titleTextStyle: const TextStyle(
          color: white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
    );
  }
}
