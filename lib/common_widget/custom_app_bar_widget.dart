import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../assets_helper/app_colors.dart';
import '../assets_helper/app_icons.dart';
import '../constants/text_font_style.dart';
import '../helpers/navigation_service.dart';
import '../helpers/ui_helpers.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? actionIcon;
  final VoidCallback? actionOnTap;
  final Color? bgColor;
  final bool showLeadingIcon;
  final VoidCallback? leadingOnTap;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actionIcon,
    this.actionOnTap,
    this.bgColor,
    this.showLeadingIcon = true,
    this.leadingOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: bgColor ?? AppColors.cFFFFFF,
      leadingWidth: 55.w,
      leading: showLeadingIcon
          ? GestureDetector(
              onTap:
                  leadingOnTap ??
                  () {
                    NavigationService.goBack;
                  },
              child: Padding(
                padding: EdgeInsets.all(10.sp),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.buttonBgColor,
                    borderRadius: BorderRadius.circular(52.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(4.h),
                    child: Image.asset(
                      AppIcons.backIcon,
                      height: 24.h,
                      color: AppColors.backgroundAppColor,
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox(),
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
        child: UIHelper.customDivider(
          color: AppColors.fontGreyColor.withAlpha(5),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight * 1.h);
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../assets_helper/app_colors.dart';
// import '../assets_helper/app_icons.dart';
// import '../constants/text_font_style.dart';
// import '../helpers/navigation_service.dart';
// import '../helpers/ui_helpers.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final Widget? actionIcon;
//   final VoidCallback? actionOnTap;
//   final Color? bgColor;

//   const CustomAppBar({
//     super.key,
//     required this.title,
//     this.actionIcon,
//     this.actionOnTap,
//     this.bgColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       elevation: 1,
//       // titleSpacing: 10,
//       automaticallyImplyLeading: true,
//       centerTitle: true,
//       backgroundColor: bgColor ?? AppColors.cFFFFFF,
//       leadingWidth: 50.w,
//       leading: GestureDetector(
//         onTap: () {
//           NavigationService.goBack;
//         },
//         child: Padding(
//           padding: EdgeInsets.all(8.sp),
//           child: Container(
//             decoration: BoxDecoration(
//               color: AppColors.buttonBgColor,
//               borderRadius: BorderRadius.circular(52.r),
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(6.h),
//               child: Image.asset(
//                 AppIcons.backIcon,
//                 height: 24.h,
//                 color: AppColors.backgroundAppColor,
//               ),
//             ),
//           ),
//         ),
//       ),

//       title: Text(
//         title,
//         style: TextFontStyle.headlinePublicSans70020.copyWith(
//           color: AppColors.buttonBgColor,
//         ),
//       ),
//       actions: actionIcon != null
//           ? [
//               Padding(
//                 padding: EdgeInsets.only(right: 10.w),
//                 child: GestureDetector(onTap: actionOnTap, child: actionIcon),
//               ),
//             ]
//           : null,
//       bottom: PreferredSize(
//         preferredSize: const Size.fromHeight(0.5),
//         child: UIHelper.customDivider(
//           color: AppColors.fontGreyColor.withAlpha(5),
//         ),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight * 0.8);
// }
