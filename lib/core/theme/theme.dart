import 'package:blog_hub/core/theme/app_pallet.dart';
import 'package:flutter/material.dart';

class AppTheme{
  static  _borderDesign([Color color=AppPallet.borderColor]) => OutlineInputBorder(
      borderSide: BorderSide(
          color: color,
          width: 3
      ),
      borderRadius: BorderRadius.circular(20)
  );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallet.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallet.transparentColor
    ),
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(AppPallet.backgroundColor),
      side: BorderSide.none
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding:  const EdgeInsets.all(20),
      border: _borderDesign(),
      enabledBorder: _borderDesign(),
      focusedBorder: _borderDesign(AppPallet.gradient2),
      errorBorder: _borderDesign(AppPallet.errorColor)
    )
  );
}