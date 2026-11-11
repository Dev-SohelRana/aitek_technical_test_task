import 'package:aitek_task/assets_helper/app_colors.dart';
import 'package:aitek_task/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back,',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF64748B),
                ),
              ),
              UIHelper.verticalSpace(4.h),
              Text(
                'Trader!',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.darkTextColor,
                ),
              ),
            ],
          ),
        ),

        Container(
          height: 46.r,
          width: 46.r,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: IconButton(
            onPressed: () {
              // NavigationService.navigateTo(Routes.profileScreen);
            },
            icon: Icon(
              Icons.notifications_rounded,
              color: AppColors.primaryColor,
              size: 25.r,
            ),
          ),
        ),
      ],
    );
  }
}
