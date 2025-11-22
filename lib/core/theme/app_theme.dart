import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Modern, minimalist app theme following clean design principles
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // ========================================================================
  // COLORS - Modern, clean palette
  // ========================================================================

  // Primary colors
  static const Color primaryColor = Color(0xFF2D3142);      // Deep navy/charcoal
  static const Color primaryLight = Color(0xFF4F5D75);      // Lighter navy
  static const Color primaryDark = Color(0xFF1A1D2E);       // Darker navy

  // Accent colors
  static const Color accentColor = Color(0xFF00B4D8);       // Vibrant cyan/blue
  static const Color accentLight = Color(0xFF90E0EF);       // Light cyan
  static const Color accentDark = Color(0xFF0077B6);        // Deep blue

  // Neutral colors
  static const Color backgroundColor = Color(0xFFFAFAFA);   // Off-white
  static const Color surfaceColor = Color(0xFFFFFFFF);      // Pure white
  static const Color cardColor = Color(0xFFFFFFFF);         // Card background

  // Text colors
  static const Color textPrimary = Color(0xFF2D3142);       // Dark text
  static const Color textSecondary = Color(0xFF6C757D);     // Gray text
  static const Color textTertiary = Color(0xFFADB5BD);      // Light gray text

  // Status colors
  static const Color successColor = Color(0xFF06D6A0);      // Green
  static const Color errorColor = Color(0xFFEF476F);        // Red
  static const Color warningColor = Color(0xFFFFD166);      // Amber
  static const Color infoColor = Color(0xFF118AB2);         // Blue

  // Grays
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);

  // ========================================================================
  // SPACING - Consistent rhythm using 8px grid
  // ========================================================================

  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing40 = 40.0;
  static const double spacing48 = 48.0;
  static const double spacing64 = 64.0;

  // ========================================================================
  // BORDER RADIUS - Consistent rounded corners
  // ========================================================================

  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
  static const double radiusCircle = 1000.0;

  // ========================================================================
  // ELEVATION - Material shadow depths
  // ========================================================================

  static const double elevationNone = 0.0;
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
  static const double elevationXHigh = 16.0;

  // ========================================================================
  // TYPOGRAPHY - Clean, readable font system
  // ========================================================================

  static const String fontFamily = 'Inter';

  static const TextStyle displayLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.2,
    color: textPrimary,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.2,
    color: textPrimary,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.25,
    height: 1.2,
    color: textPrimary,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.3,
    color: textPrimary,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.3,
    color: textPrimary,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.3,
    color: textPrimary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    height: 1.5,
    color: textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.5,
    color: textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.5,
    color: textSecondary,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.4,
    color: textPrimary,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.4,
    color: textPrimary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.4,
    color: textSecondary,
  );

  // ========================================================================
  // THEME DATA - Light theme
  // ========================================================================

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // Color scheme
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: accentColor,
      surface: surfaceColor,
      background: backgroundColor,
      error: errorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textPrimary,
      onBackground: textPrimary,
      onError: Colors.white,
    ),

    // Scaffold
    scaffoldBackgroundColor: backgroundColor,

    // App bar
    appBarTheme: const AppBarTheme(
      backgroundColor: surfaceColor,
      foregroundColor: textPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        letterSpacing: -0.25,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),

    // Card
    cardTheme: CardTheme(
      color: cardColor,
      elevation: elevationLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
      ),
      margin: const EdgeInsets.all(spacing8),
    ),

    // Elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: elevationNone,
        padding: const EdgeInsets.symmetric(
          horizontal: spacing24,
          vertical: spacing16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // Text button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: spacing16,
          vertical: spacing12,
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.25,
        ),
      ),
    ),

    // Outlined button
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: gray300, width: 1),
        padding: const EdgeInsets.symmetric(
          horizontal: spacing24,
          vertical: spacing16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // Input decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: gray100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: errorColor, width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: spacing16,
        vertical: spacing16,
      ),
      hintStyle: const TextStyle(
        color: textTertiary,
        fontSize: 14,
      ),
    ),

    // Chip
    chipTheme: ChipThemeData(
      backgroundColor: gray100,
      selectedColor: primaryColor,
      labelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: spacing12,
        vertical: spacing8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusSmall),
      ),
    ),

    // Bottom navigation bar
    bottomNavigationBarTheme: const BottomNavigationBarTheme(
      backgroundColor: surfaceColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: gray500,
      type: BottomNavigationBarType.fixed,
      elevation: elevationMedium,
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Divider
    dividerTheme: const DividerThemeData(
      color: gray200,
      thickness: 1,
      space: 1,
    ),

    // Icon
    iconTheme: const IconThemeData(
      color: textPrimary,
      size: 24,
    ),

    // Typography
    textTheme: const TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
    ),
  );

  // ========================================================================
  // DARK THEME
  // ========================================================================

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: const ColorScheme.dark(
      primary: accentColor,
      secondary: accentLight,
      surface: Color(0xFF1A1D2E),
      background: Color(0xFF0F111A),
      error: errorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.white,
      onBackground: Colors.white,
      onError: Colors.white,
    ),

    scaffoldBackgroundColor: const Color(0xFF0F111A),
    // ... rest of dark theme configuration
  );
}
