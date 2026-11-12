import 'package:aitek_task/assets_helper/app_colors.dart';
import 'package:aitek_task/constants/text_font_style.dart';
import 'package:aitek_task/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupportedCurrencyPairsWidget extends StatelessWidget {
  final List<Map<String, String>> currencyPairs;

  const SupportedCurrencyPairsWidget({super.key, required this.currencyPairs});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Supported Currency Pairs',
              style: TextFontStyle.headlineRoboto80017Dark,
            ),
            Text(
              '${currencyPairs.length} Pairs',
              style: TextFontStyle.headlineRoboto60011Primary,
            ),
          ],
        ),

        UIHelper.verticalSpace(6.h),

        Text(
          'Currency pairs available in Signals Archive',
          style: TextFontStyle.headlineRoboto40012Secondary,
        ),

        UIHelper.verticalSpace(14.h),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: const Color(0xFFE8EDF5)),
          ),
          child: Column(
            children: [
              ...currencyPairs.asMap().entries.map((entry) {
                final index = entry.key;
                final pair = entry.value;

                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Row(
                        children: [
                          Container(
                            height: 40.r,
                            width: 46.r,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(11.r),
                            ),
                            child: Icon(
                              Icons.currency_exchange_rounded,
                              color: AppColors.primaryColor,
                              size: 21.r,
                            ),
                          ),

                          UIHelper.horizontalSpace(12.w),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pair['symbol'] ?? '',
                                  style: TextFontStyle.headlineRoboto70014Dark,
                                ),
                                UIHelper.verticalSpace(3.h),
                                Text(
                                  pair['name'] ?? '',
                                  style: TextFontStyle
                                      .headlineRoboto40010Secondary,
                                ),
                              ],
                            ),
                          ),

                          Icon(
                            Icons.check_circle_rounded,
                            color: const Color(0xFF16A34A),
                            size: 19.r,
                          ),
                        ],
                      ),
                    ),

                    if (index != currencyPairs.length - 1)
                      const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  ],
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
