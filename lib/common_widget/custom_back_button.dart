import 'package:aitek_task/assets_helper/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../assets_helper/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onTap;
  const CustomBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.buttonBgColor,
          borderRadius: BorderRadius.circular(52.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(6.h),
          child: Image.asset(
            AppIcons.backIcon,
            height: 24.h,
            color: AppColors.backgroundAppColor,
          ),
        ),
      ),
    );
  }
}
