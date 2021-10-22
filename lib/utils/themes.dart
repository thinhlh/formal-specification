import 'package:flutter/material.dart';
import 'package:formal_specification/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData themeData = ThemeData(
    textTheme: GoogleFonts.robotoTextTheme(),
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    accentColor: AppColors.secondary,
    scaffoldBackgroundColor: AppColors.background,
  );
}
