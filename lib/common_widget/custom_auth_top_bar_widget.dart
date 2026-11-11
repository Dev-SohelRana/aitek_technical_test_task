import 'package:aitek_task/assets_helper/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../assets_helper/app_colors.dart';
import '../constants/text_font_style.dart';
import '../helpers/navigation_service.dart';
import '../helpers/ui_helpers.dart';

class CustomAuthTopBarWidget extends StatelessWidget {
  final String? title;
  final bool? showDivider;

  const CustomAuthTopBarWidget({
    super.key,
    this.title,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationService.goBack;
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.buttonBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.sp),
                    child: SvgPicture.asset(AppIcons.arrowBackIcon),
                  ),
                ),
                UIHelper.horizontalSpace(8.w),
                Text(title ?? '', style: TextFontStyle.headlinePublicSans70020),
              ],
            ),
          ),
          if (showDivider ?? false)
            UIHelper.customDivider(color: AppColors.fontGreyColor, height: 1.h),
        ],
      ),
    );
  }
}
