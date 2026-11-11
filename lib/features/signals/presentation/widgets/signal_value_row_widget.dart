import 'package:aitek_task/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignalValueRowWidget extends StatelessWidget {
  final String title;
  final String value;

  const SignalValueRowWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 9.sp,
              color: const Color(0xFF94A3B8),
              fontWeight: FontWeight.w500,
            ),
          ),
          UIHelper.verticalSpace(5.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0B1F45),
            ),
          ),
        ],
      ),
    );
  }
}
