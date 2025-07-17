import 'package:app/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'extra_colors.dart';

class AppTheme {
  ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final colorScheme = _buildColorScheme(brightness);
    final themeData = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      extensions: [buildExtraColors()],
      inputDecorationTheme: _buildInputDecorationTheme(brightness),
      colorScheme: colorScheme,
      filledButtonTheme: _buildFilledButtonTheme(brightness),
      outlinedButtonTheme: _buildOutlinedButtonTheme(brightness),
      textButtonTheme: _buildTextButtonTheme(brightness),
      scaffoldBackgroundColor: colorScheme.background,
      canvasColor: colorScheme.background,
      cardColor: colorScheme.surface,
      dialogBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      dividerColor: colorScheme.outline,
    );
    return themeData.copyWith(
      textTheme: _buildTextTheme(themeData.textTheme),
    );
  }

  final borderRadius = BorderRadius.circular(BorderSize.extraSmall);
  final padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 14);

  Brightness getBrightness() {
    return currentBrightness.value;
  }

  final currentBrightness = ValueNotifier<Brightness>(Brightness.light);

  ThemeData buildDarkTheme() {
    currentBrightness.value = Brightness.dark;
    return _build(Brightness.dark);
  }

  ThemeData buildLightTheme() {
    currentBrightness.value = Brightness.light;
    return _build(Brightness.light);
  }

  InputDecorationTheme _buildInputDecorationTheme(Brightness brightness) {
    final colorScheme = _buildColorScheme(brightness);
    OutlineInputBorder buildBorder(Color color, {double width = 1}) {
      return OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return InputDecorationTheme(
      contentPadding: padding,
      fillColor: colorScheme.surface.withOpacity(0.5),
      filled: true,
      activeIndicatorBorder: BorderSide.none,
      border: buildBorder(colorScheme.outline.withOpacity(0.5)),
      errorBorder: buildBorder(colorScheme.error),
      enabledBorder: buildBorder(colorScheme.outline.withOpacity(0.5)),
      focusedBorder: buildBorder(colorScheme.primary),
      focusedErrorBorder: buildBorder(colorScheme.error, width: 2),
      disabledBorder: buildBorder(colorScheme.outline.withOpacity(0.5)),
    );
  }

  TextTheme _buildTextTheme(TextTheme textTheme) {
    return GoogleFonts.cairoTextTheme(textTheme);
  }

  ExtraColors buildExtraColors() {
    return const ExtraColors(
      success: Color(0xFF22C55E),
      onSuccess: Colors.white,
      error: Color(0xFFEF4444),
    );
  }

  ColorScheme _buildColorScheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return ColorScheme(
      brightness: brightness,
      primary: const Color(0xFF22D3EE), // Cyan
      onPrimary: Colors.white,
      primaryContainer: const Color(0xFFFBBF24), // Yellow/Orange
      onPrimaryContainer: Colors.black,
      secondary: const Color(0xFFA78BFA), // Purple
      onSecondary: Colors.white,
      secondaryContainer: const Color(0xFF38BDF8), // Aqua
      onSecondaryContainer: Colors.black,
      tertiary: const Color(0xFF38BDF8), // Aqua
      onTertiary: Colors.white,
      tertiaryContainer: const Color(0xFF22D3EE), // Cyan
      onTertiaryContainer: Colors.black,
      error: const Color(0xFFEF4444),
      onError: Colors.white,
      errorContainer: const Color(0xFFFECACA),
      onErrorContainer: Colors.black,
      background: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
      onBackground: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF1E293B),
      surface: isDark ? const Color(0xFF273043) : const Color(0xFFFFFFFF),
      onSurface: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF1E293B),
      surfaceVariant: isDark ? const Color(0xFF334155) : const Color(0xFFE0E7EF),
      onSurfaceVariant: isDark ? const Color(0xFFD1D5DB) : const Color(0xFF334155),
      outline: isDark ? const Color(0xFF64748B) : const Color(0xFFCBD5E1),
      shadow: isDark ? const Color(0xFF000000) : const Color(0xFF000000),
      inverseSurface: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF273043),
      onInverseSurface: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
      inversePrimary: const Color(0xFF38BDF8),
      surfaceTint: const Color(0xFF22D3EE),
    );
  }

  FilledButtonThemeData _buildFilledButtonTheme(Brightness brightness) {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(0, 55),
        maximumSize: const Size(double.infinity, double.infinity),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        backgroundColor: _buildColorScheme(brightness).primary,
        foregroundColor: _buildColorScheme(brightness).onPrimary,
      ),
    );
  }

  OutlinedButtonThemeData _buildOutlinedButtonTheme(Brightness brightness) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        side: BorderSide(color: _buildColorScheme(brightness).primary),
      ),
    );
  }

  TextButtonThemeData _buildTextButtonTheme(Brightness brightness) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        foregroundColor: _buildColorScheme(brightness).primary,
      ),
    );
  }
}

final colorSchemeNotifier =
    ValueNotifier<ColorScheme>(AppTheme()._buildColorScheme(AppTheme().getBrightness()));
