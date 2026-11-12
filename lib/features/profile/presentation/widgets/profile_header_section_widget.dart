import 'package:aitek_task/assets_helper/app_colors.dart';
import 'package:aitek_task/constants/text_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeaderSectionWidget extends StatelessWidget {
  final String title;
  final IconData icon;

  const ProfileHeaderSectionWidget({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 21.r, color: AppColors.primaryColor),
        SizedBox(width: 10.w),
        Text(title, style: TextFontStyle.headlineRoboto70016Dark),
      ],
    );
  }
}
