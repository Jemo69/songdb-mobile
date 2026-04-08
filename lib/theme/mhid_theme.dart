import 'package:flutter/material.dart';

class MHIDTheme {
  // --- Reference Tokens (mh.ref) ---
  static const Color refColorNeutral0 = Color(0xFF000000);
  static const Color refColorNeutral100 = Color(0xFFFFFFFF);
  static const Color refColorNeutral95 = Color(0xFFF2F2F7); // Light gray for tonal shifts
  static const Color refColorNeutral10 = Color(0xFF1C1C1E); // Dark gray for dark mode surfaces

  static const double refShapeCornerS = 4.0;
  static const double refShapeCornerM = 8.0;
  static const double refShapeCornerL = 12.0;

  // --- System Tokens (mh.sys) ---
  // These will be derived based on brightness in the theme getter,
  // but we can define some semantic constants here if needed.

  static Duration get motionDurationEnter => const Duration(milliseconds: 250);
  static Duration get motionDurationExit => const Duration(milliseconds: 150);
  static Duration get motionDurationFeedback => const Duration(milliseconds: 200);
  static Duration get motionDurationSpatial => const Duration(milliseconds: 350);

  static Curve get motionEasingEnter => Curves.decelerate; // Standard Decelerate
  static Curve get motionEasingExit => Curves.accelerate; // Standard Accelerate
  static Curve get motionEasingExpressive => Curves.easeOutBack; // Expressive (More subtle than elasticOut)

  static ThemeData getTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;

    // Color Palette based on MHID (90% Neutral)
    final Color backgroundColor = isDark ? refColorNeutral0 : refColorNeutral100;
    final Color surfaceColor = isDark ? refColorNeutral10 : refColorNeutral95;
    final Color onSurfaceColor = isDark ? refColorNeutral100 : refColorNeutral0;
    final Color primaryColor = isDark ? refColorNeutral100 : refColorNeutral0;
    final Color onPrimaryColor = isDark ? refColorNeutral0 : refColorNeutral100;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primaryColor,
        onPrimary: onPrimaryColor,
        secondary: surfaceColor,
        onSecondary: onSurfaceColor,
        error: Colors.redAccent,
        onError: Colors.white,
        surface: backgroundColor,
        onSurface: onSurfaceColor,
        surfaceContainerHighest: surfaceColor,
        outline: onSurfaceColor.withOpacity(0.12), // Subtle outline for MHID
      ),
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: 'Roboto',

      // Typography
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: onSurfaceColor),
        displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: onSurfaceColor),
        displaySmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: onSurfaceColor),
        headlineMedium: TextStyle(fontWeight: FontWeight.w600, color: onSurfaceColor),
        bodyLarge: TextStyle(color: onSurfaceColor, fontSize: 16),
        bodyMedium: TextStyle(color: onSurfaceColor, fontSize: 14),
      ),

      // Component Themes
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        foregroundColor: onSurfaceColor,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: onSurfaceColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),

      cardTheme: CardTheme(
        color: surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(refShapeCornerM),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: onPrimaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(refShapeCornerS),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: BorderSide(color: primaryColor.withOpacity(0.12)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(refShapeCornerS),
          ),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: onPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(refShapeCornerS),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(refShapeCornerS),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(refShapeCornerS),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(refShapeCornerS),
          borderSide: BorderSide(color: primaryColor, width: 1.0),
        ),
      ),

      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: surfaceColor,
        selectedIconTheme: IconThemeData(color: primaryColor),
        unselectedIconTheme: IconThemeData(color: onSurfaceColor.withOpacity(0.64)),
        selectedLabelTextStyle: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        unselectedLabelTextStyle: TextStyle(color: onSurfaceColor.withOpacity(0.64)),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: backgroundColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: onSurfaceColor.withOpacity(0.64),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: MHIDPageTransitionsBuilder(),
          TargetPlatform.iOS: MHIDPageTransitionsBuilder(),
          TargetPlatform.macOS: MHIDPageTransitionsBuilder(),
          TargetPlatform.windows: MHIDPageTransitionsBuilder(),
          TargetPlatform.linux: MHIDPageTransitionsBuilder(),
        },
      ),
    );
  }

  static ThemeData get lightTheme => getTheme(Brightness.light);
  static ThemeData get darkTheme => getTheme(Brightness.dark);
}

class MHIDPageTransitionsBuilder extends PageTransitionsBuilder {
  const MHIDPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation.drive(
        CurveTween(curve: Curves.easeIn),
      ),
      child: child,
    );
  }
}
