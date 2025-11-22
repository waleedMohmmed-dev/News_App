import 'package:flutter/material.dart';
import 'package:news_app_practice/core/futures/styling/app_colors.dart';

class AppStyles {
  static TextStyle primaryHeadLinesStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
  );

  static TextStyle subtitlesStyles = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.secendaryColor,
  );

  static TextStyle black16w500Style = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryColor,
  );
  static TextStyle blacks14w700 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryColor,
  );
  static TextStyle browng14w600 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Color(0xff6D6265),
  );
}
