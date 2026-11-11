import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../assets_helper/app_colors.dart';
import '../constants/text_font_style.dart';

class SubjectSelectCustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final BorderRadius? borderRadius;
  final Color? fillColor;
  final Color? textColor;
  final Color? borderColor;

  const SubjectSelectCustomButton({
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
          color: fillColor ?? AppColors.buttonBgColor,
          borderRadius: borderRadius ?? BorderRadius.circular(8.r),
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                title,
                style: TextFontStyle.headlinePublicSans50014black.copyWith(
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
