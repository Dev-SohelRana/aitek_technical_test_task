import 'package:aitek_task/assets_helper/app_colors.dart';
import 'package:aitek_task/constants/text_font_style.dart';
import 'package:aitek_task/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecurityInfoWidget extends StatelessWidget {
  const SecurityInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider(color: AppColors.borderColor)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  Icon(
                    Icons.verified_user_outlined,
                    size: 17.r,
                    color: AppColors.secondaryTextColor,
                  ),
                  UIHelper.horizontalSpace(6.w),
                  Text(
                    'Secure & Encrypted',
                    style: TextFontStyle.headlineRoboto40012Secondary,
                  ),
                ],
              ),
            ),
            const Expanded(child: Divider(color: AppColors.borderColor)),
          ],
        ),
        UIHelper.verticalSpace(20.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: AppColors.securityBackgroundColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.securityBorderColor),
          ),
          child: Row(
            children: [
              Container(
                height: 44.r,
                width: 44.r,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlueOverlay10,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.shield_rounded,
                  color: AppColors.primaryColor,
                  size: 26.r,
                ),
              ),
              UIHelper.horizontalSpace(12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Security Matters',
                      style: TextFontStyle.headlineRoboto70013Dark,
                    ),
                    UIHelper.verticalSpace(4.h),
                    Text(
                      'Your account information is protected.',
                      style: TextFontStyle.headlineRoboto40011Secondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
