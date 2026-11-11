import 'package:aitek_task/assets_helper/app_colors.dart';
import 'package:aitek_task/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginWelcomeSectionWidget extends StatelessWidget {
  const LoginWelcomeSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.darkTextColor,
          ),
        ),
        UIHelper.verticalSpace(8.h),
        Text(
          'Sign in to access your trading account',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.secondaryTextColor,
          ),
        ),
      ],
    );
  }
}
