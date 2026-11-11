import 'package:aitek_task/assets_helper/app_colors.dart';
import 'package:aitek_task/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RememberMeRowWidget extends StatelessWidget {
  const RememberMeRowWidget({
    required this.value,
    required this.onChanged,
    this.onForgotPassword,
    super.key,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final VoidCallback? onForgotPassword;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 24.r,
          height: 24.r,
          child: Checkbox(
            value: value,
            activeColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
            ),
            onChanged: (newValue) => onChanged(newValue ?? false),
          ),
        ),
        UIHelper.horizontalSpace(8.w),
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged(!value),
            child: Text(
              'Remember me',
              style: TextStyle(fontSize: 13.sp, color: AppColors.darkTextColor),
            ),
          ),
        ),
        TextButton(
          onPressed: onForgotPassword,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(0, 36.h),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Forgot Password?',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
