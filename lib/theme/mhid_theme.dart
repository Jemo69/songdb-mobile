import 'package:flutter/material.dart';

class MHIDTheme {
  // --- Reference Tokens (mh.ref) ---
  static const Color refColorNeutral0 = Color(0xFF000000); // Black
  static const Color refColorNeutral100 = Color(0xFFFFFFFF); // White
  static const Color refColorNeutral95 = Color(0xFFF2F2F7); // Light gray (HIG-like)
  static const Color refColorNeutral10 = Color(0xFF1C1C1E); // Dark gray (HIG-like)

  static const double refShapeCornerS = 4.0;
  static const double refShapeCornerM = 10.0;
  static const double refShapeCornerL = 16.0;

  // --- Motion Tokens ---
  static Duration get motionDurationEnter => const Duration(milliseconds: 250);
  static Duration get motionDurationExit => const Duration(milliseconds: 150);
  static Duration get motionDurationFeedback => const Duration(milliseconds: 200);
  static Duration get motionDurationSpatial => const Duration(milliseconds: 350);

  static Curve get motionEasingEnter => Curves.decelerate;
  static Curve get motionEasingExit => Curves.fastOutSlowIn; // Use fastOutSlowIn instead of accelerate if not found
  static Curve get motionEasingExpressive => Curves.easeOutBack;

  static ThemeData getTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;

    // Color Palette based on MHID (90% Neutral)
    final Color backgroundColor = isDark ? refColorNeutral0 : refColorNeutral100;
    final Color surfaceColor = isDark ? refColorNeutral10 : refColorNeutral95;
    final Color onSurfaceColor = isDark ? refColorNeutral100 : refColorNeutral0;

    // Primary is used sparingly (Minimalist Color Mandate)
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
        outline: onSurfaceColor.withOpacity(0.12),
      ),
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: 'Roboto',

      // Typography (Hierarchical Type Scale)
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: onSurfaceColor, letterSpacing: -0.5),
        displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: onSurfaceColor, letterSpacing: -0.5),
        displaySmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: onSurfaceColor, letterSpacing: -0.2),
        headlineMedium: TextStyle(fontWeight: FontWeight.w600, color: onSurfaceColor, letterSpacing: 0.1),
        labelLarge: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1),
        bodyLarge: TextStyle(color: onSurfaceColor, fontSize: 16, height: 1.5),
        bodyMedium: TextStyle(color: onSurfaceColor, fontSize: 14, height: 1.4),
      ),

      // AppBar (Content First, Minimalist)
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

      // Action Components (Inverted Emphasis Hierarchy)
      // High Emphasis -> Filled
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: onPrimaryColor,
          elevation: 0, // Tonal Elevation
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(refShapeCornerM),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      // Medium Emphasis (Default) -> Outlined or Tonal
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: BorderSide(color: onSurfaceColor.withOpacity(0.12)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(refShapeCornerM),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      // Low Emphasis -> Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),

      // Components
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(refShapeCornerM),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(refShapeCornerM),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(refShapeCornerM),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(refShapeCornerM),
          borderSide: BorderSide(color: primaryColor, width: 1.5),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),

      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: backgroundColor,
        selectedIconTheme: IconThemeData(color: primaryColor),
        unselectedIconTheme: IconThemeData(color: onSurfaceColor.withOpacity(0.5)),
        selectedLabelTextStyle: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        unselectedLabelTextStyle: TextStyle(color: onSurfaceColor.withOpacity(0.5)),
        elevation: 0,
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: backgroundColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: onSurfaceColor.withOpacity(0.5),
        type: BottomNavigationBarType.fixed,
        elevation: 0, // Content-First (No heavy shadow)
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: onPrimaryColor,
        elevation: 2, // Subtle elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(refShapeCornerL),
        ),
      ),

      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: MHIDPageTransitionsBuilder(),
          TargetPlatform.iOS: MHIDPageTransitionsBuilder(),
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
    // MHID Duration Standard: Screen Entry 250ms
    return FadeTransition(
      opacity: animation.drive(
        CurveTween(curve: Curves.easeInOut),
      ),
      child: SlideTransition(
        position: animation.drive(
          Tween<Offset>(
            begin: const Offset(0.05, 0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeOutCubic)),
        ),
        child: child,
      ),
    );
  }
}
