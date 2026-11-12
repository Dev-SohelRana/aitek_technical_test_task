import 'package:aitek_task/assets_helper/app_colors.dart';
import 'package:aitek_task/constants/app_constants.dart';
import 'package:aitek_task/constants/text_font_style.dart';
import 'package:aitek_task/features/home/presentation/widgets/account_top_card_widget.dart';
import 'package:aitek_task/features/home/presentation/widgets/home_header_widget.dart';
import 'package:aitek_task/features/home/presentation/widgets/supported_currency_pairs_widget.dart';
import 'package:aitek_task/helpers/di.dart';
import 'package:aitek_task/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAppColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeaderWidget(),
              UIHelper.verticalSpace(24.h),
              AccountTopCardWidget(
                accountLoginNumber:
                    appData.read(kKeyLoginID) ?? 'Login ID not found',
              ),
              UIHelper.verticalSpace(28.h),
              SupportedCurrencyPairsWidget(
                currencyPairs: [
                  {'symbol': 'EURUSD', 'name': 'Euro / US Dollar'},
                  {'symbol': 'GBPUSD', 'name': 'British Pound / US Dollar'},
                  {'symbol': 'USDJPY', 'name': 'US Dollar / Japanese Yen'},
                  {'symbol': 'USDCHF', 'name': 'US Dollar / Swiss Franc'},
                  {'symbol': 'USDCAD', 'name': 'US Dollar / Canadian Dollar'},
                  {'symbol': 'AUDUSD', 'name': 'Australian Dollar / US Dollar'},
                  {
                    'symbol': 'NZDUSD',
                    'name': 'New Zealand Dollar / US Dollar',
                  },
                ],
              ),

              // SupportedCurrencyPairsWidget(currencyPairs: currencyPairsFromApi),
              UIHelper.verticalSpace(24.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF4FF),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFFDCE8FF)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.primaryColor,
                      size: 23.r,
                    ),

                    UIHelper.horizontalSpace(12.w),

                    Expanded(
                      child: Text(
                        'Access historical trading signals by selecting currency pairs and a date range.',
                        style: TextFontStyle.headlineRoboto40011DarkHeight15,
                      ),
                    ),
                  ],
                ),
              ),

              UIHelper.verticalSpace(20.h),
            ],
          ),
        ),
      ),
    );
  }
}
