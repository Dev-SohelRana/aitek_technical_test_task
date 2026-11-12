import 'package:aitek_task/constants/text_font_style.dart';
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
          Text(title, style: TextFontStyle.headlineRoboto5009Muted),
          UIHelper.verticalSpace(5.h),
          Text(value, style: TextFontStyle.headlineRoboto70011Dark),
        ],
      ),
    );
  }
}
