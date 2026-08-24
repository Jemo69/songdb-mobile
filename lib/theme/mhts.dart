import 'package:flutter/material.dart';

/// MHID Design Token System (MHTS) for SongDB.
///
/// Reference tokens are the approved constants; system tokens resolve per
/// brightness. Every visual decision in the app flows through these.
abstract final class Mh {
  // mh.ref.color — deep prayer-book teal seed; dynamic color derives the rest.
  static const Color _seedLight = Color(0xFF22635B);
  static const Color _seedDark = Color(0xFF8CD5C8);

  // mh.sys.shape.corner
  static const double cornerS = 10;
  static const double cornerM = 16;
  static const double cornerL = 28;

  static ThemeData theme(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: brightness == Brightness.light ? _seedLight : _seedDark,
      brightness: brightness,
    );
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: scheme.onSurface,
          fontSize: 22,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.25,
        ),
      ),
      textTheme: _textTheme(scheme),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cornerM),
        ),
        tileColor: scheme.surfaceContainerLow,
        iconColor: scheme.onSurfaceVariant,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primaryContainer,
        foregroundColor: scheme.onPrimaryContainer,
        elevation: 0,
        focusElevation: 1,
        hoverElevation: 1,
        highlightElevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cornerL),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark
            ? scheme.surfaceContainerHigh
            : scheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerS),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerS),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerS),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cornerS),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surfaceContainerHigh,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cornerM),
        ),
      ),
    );
  }

  /// Type scale: hierarchy through scale + weight. Lyrics body gets height
  /// 1.7 and a capped measure at the call site; titles stay sentence case.
  static TextTheme _textTheme(ColorScheme scheme) {
    return Typography.material2021().black.copyWith(
          displaySmall: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.5,
            color: scheme.onSurface,
          ),
          headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.25,
            color: scheme.onSurface,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: scheme.onSurface,
          ),
          bodyLarge: TextStyle(
            fontSize: 17,
            height: 1.7,
            color: scheme.onSurface,
          ),
          bodyMedium: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
          labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.4,
            color: scheme.onSurfaceVariant,
          ),
        );
  }
}

/// mh.sys.motion — M3 Expressive curves at MHID durations.
abstract final class MhMotion {
  static const Duration enter = Duration(milliseconds: 250);
  static const Duration exit = Duration(milliseconds: 150);
}
