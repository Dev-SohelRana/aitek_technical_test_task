import 'package:aitek_task/constants/text_font_style.dart';
import 'package:aitek_task/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginWelcomeSectionWidget extends StatelessWidget {
  const LoginWelcomeSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Welcome Back', style: TextFontStyle.headlineRoboto80028Dark),
        UIHelper.verticalSpace(8.h),
        Text(
          'Sign in to access your trading account',
          style: TextFontStyle.headlineRoboto40014Secondary,
        ),
      ],
    );
  }
}
