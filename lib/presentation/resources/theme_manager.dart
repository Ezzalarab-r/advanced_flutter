import 'package:flutter/material.dart';

import 'colors_manager.dart';
import 'fonts_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

ThemeData getAppTheme() {
  return ThemeData(
    // Main Colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryLight,
    primaryColorDark: ColorManager.primaryDark,
    disabledColor: ColorManager.grey,
    splashColor: ColorManager.primaryLight, // ribble effect

    // Text Theme
    textTheme: TextTheme(
      headlineLarge: getBoldStyle(
        fontColor: ColorManager.grey_3,
        fontSize: FontSize.s18,
      ),
      headlineMedium: getRegularStyle(
        fontColor: ColorManager.grey_3,
        fontSize: FontSize.s16,
      ),
      displayLarge: getLightStyle(
        fontColor: ColorManager.grey_3,
        fontSize: FontSize.s16,
      ),
      titleMedium: getMediumStyle(
        fontColor: ColorManager.primary,
        fontSize: FontSize.s16,
      ),
      bodyLarge: getRegularStyle(fontColor: ColorManager.grey3),
      bodySmall: getRegularStyle(fontColor: ColorManager.grey_2),
      labelSmall: getBoldStyle(
        fontColor: ColorManager.primary,
        fontSize: FontSize.s12,
      ),
    ),

    // Card View Theme
    cardTheme: const CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    // App Bar Theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.white,
      elevation: AppSize.s0,
      shadowColor: ColorManager.primaryLight,
      titleTextStyle: getRegularStyle(
        fontSize: FontSize.s16,
        fontColor: ColorManager.white,
      ),
    ),

    // Button Theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey3,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primaryLight,
    ),

    // Elevated Button Them
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
          fontColor: ColorManager.white,
          fontSize: FontSize.s18,
        ),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),

    // Input Decoration Theme (TextFormFiled)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(
        fontSize: FontSize.s14,
        fontColor: ColorManager.grey3,
      ),
      labelStyle: getMediumStyle(
        fontColor: ColorManager.grey,
        fontSize: FontSize.s14,
      ),
      errorStyle: getRegularStyle(fontColor: ColorManager.error),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorManager.grey,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorManager.error,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorManager.grey_3,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
    ),
  );
}
