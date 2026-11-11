import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../assets_helper/app_colors.dart';
import '../../../../common_widget/custom_button.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../helpers/ui_helpers.dart';

class LogoutDialogWidget extends StatelessWidget {
  final VoidCallback logoutOnTap;

  const LogoutDialogWidget({super.key, required this.logoutOnTap});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.cFFFFFF,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: BorderSide(color: AppColors.fontGreyColor),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.all(20.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 64.r,
              width: 64.r,
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.square_arrow_right,
                color: Colors.red,
                size: 30.r,
              ),
            ),

            UIHelper.verticalSpace(18.h),

            Text(
              'Are you sure you want to logout?',
              style: TextFontStyle.headlinePublicSans70024.copyWith(
                color: AppColors.logoutRedColor,
              ),
              textAlign: TextAlign.center,
            ),

            UIHelper.verticalSpace(24.h),

            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onTap: () => Navigator.pop(context),
                    title: 'Cancel',
                    fillColor: AppColors.subColors.withAlpha(180),
                    textColor: AppColors.c000000,
                  ),
                ),

                UIHelper.horizontalSpace(12.w),

                Expanded(
                  child: CustomButton(
                    onTap: logoutOnTap,
                    title: 'Yes, Logout',
                    textColor: AppColors.cFFFFFF,
                    fillColor: AppColors.logoutRedColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
