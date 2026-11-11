import 'package:aitek_task/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../assets_helper/app_colors.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    super.key,
    this.marketPairs = const ['EURUSD', 'GBPUSD', 'USDJPY'],
  });

  final List<String> marketPairs;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24.w, 30.h, 24.w, 36.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.darkHeaderColor,
            AppColors.blueHeaderColor,
            AppColors.primaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36.r),
          bottomRight: Radius.circular(36.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 46.r,
                width: 46.r,
                decoration: BoxDecoration(
                  color: AppColors.whiteOverlay12,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: AppColors.whiteOverlay20),
                ),
                child: Icon(
                  Icons.candlestick_chart_rounded,
                  color: AppColors.cFFFFFF,
                  size: 27.r,
                ),
              ),
              UIHelper.horizontalSpace(12.w),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Forex',
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.cFFFFFF,
                      ),
                    ),
                    TextSpan(
                      text: 'Copy',
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.accentBlueColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(28.h),
          Text(
            'Trade Smarter.',
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.cFFFFFF,
              height: 1.25,
            ),
          ),
          UIHelper.verticalSpace(6.h),
          Text(
            'Grow Bigger.',
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.lightBlueAccentColor,
              height: 1.25,
            ),
          ),
          UIHelper.verticalSpace(12.h),
          Text(
            'Access your trading account securely.',
            style: TextStyle(fontSize: 14.sp, color: AppColors.white70),
          ),
          UIHelper.verticalSpace(24.h),
          Row(
            children: [
              for (var index = 0; index < marketPairs.length; index++) ...[
                if (index > 0) UIHelper.horizontalSpace(8.w),
                Expanded(child: MarketPairChip(pair: marketPairs[index])),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class MarketPairChip extends StatelessWidget {
  const MarketPairChip({required this.pair, super.key});

  final String pair;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.whiteOverlay10,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.whiteOverlay15),
      ),
      child: Text(
        pair,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.cFFFFFF,
        ),
      ),
    );
  }
}
