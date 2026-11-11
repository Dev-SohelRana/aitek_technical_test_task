import 'package:flutter/material.dart';
import '../assets_helper/app_colors.dart';

final class CustomTheme {
  CustomTheme._();
  static const MaterialColor kToDark = MaterialColor(
    0xFFF9500A, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: AppColors.containerBg, //10%
      100: AppColors.containerBg, //20%
      200: AppColors.containerBg, //30%
      300: AppColors.containerBg, //40%
      400: AppColors.containerBg, //50%
      500: AppColors.containerBg, //60%
      600: AppColors.containerBg, //70%
      700: AppColors.containerBg, //80%
      800: AppColors.containerBg, //80%
      900: AppColors.containerBg, //80%
    },
  );
  static ThemeData get mainTheme {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      primarySwatch: CustomTheme.kToDark,
      scaffoldBackgroundColor: AppColors.cFFFFFF,
    );
  }
}
