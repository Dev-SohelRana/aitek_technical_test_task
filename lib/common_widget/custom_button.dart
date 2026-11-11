import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../assets_helper/app_colors.dart';
import '../constants/text_font_style.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final BorderRadius? borderRadius;
  final Color? fillColor;
  final Color? textColor;
  final Color? borderColor;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.title,
    this.borderRadius,
    this.fillColor,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: fillColor ?? AppColors.primaryColor,
          borderRadius: borderRadius ?? BorderRadius.circular(8.r),
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextFontStyle.headlinePublicSans60018white.copyWith(
                  color: textColor ?? AppColors.cFFFFFF,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
