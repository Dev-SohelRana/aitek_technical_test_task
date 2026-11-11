import 'package:aitek_task/assets_helper/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../assets_helper/app_colors.dart';
import '../constants/text_font_style.dart';
import '../helpers/navigation_service.dart';
import '../helpers/ui_helpers.dart';

class ProfileAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final Widget? actionIcon;
  final VoidCallback? actionOnTap;
  final Color? bgColor;

  const ProfileAppBarWidget({
    super.key,
    required this.title,
    this.actionIcon,
    this.actionOnTap,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      excludeHeaderSemantics: true,
      elevation: 3,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      backgroundColor: bgColor ?? AppColors.cFFFFFF,
      leadingWidth: 60.w,
      leading: GestureDetector(
        onTap: () {
          NavigationService.goBack;
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.buttonBgColor,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(12.sp),
              child: SvgPicture.asset(AppIcons.arrowBackIcon),
            ),
          ),
        ),
      ),
      title: Text(
        title,
        style: TextFontStyle.headlinePublicSans70020.copyWith(
          color: AppColors.buttonBgColor,
        ),
      ),
      actions: actionIcon != null
          ? [
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: GestureDetector(onTap: actionOnTap, child: actionIcon),
              ),
            ]
          : null,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.5),
        child: UIHelper.customDivider(color: AppColors.fontGreyColor),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 0.9);
}
