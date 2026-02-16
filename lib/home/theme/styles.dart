import 'package:flutter/material.dart';
import 'package:flutter_application_4/home/theme/colors.dart';

class AppTextStyles {
  static const TextStyle city = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.whiteText,
  );

  static const TextStyle smallTemp = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.whiteText,
  );

  static const TextStyle normalWhite = TextStyle(
    fontSize: 14,
    color: AppColors.whiteText,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle smallcardTitle = TextStyle(
    fontSize: 12,
    color: AppColors.greyText,
  );

  static const TextStyle cardValue = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}
