import 'package:aitek_task/helpers/ui_helpers.dart';
import 'package:aitek_task/features/signals/model/signal_model.dart';
import 'package:aitek_task/constants/text_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignalCardWidget extends StatelessWidget {
  final SignalModel signal;

  const SignalCardWidget({super.key, required this.signal});

  @override
  Widget build(BuildContext context) {
    final isBuy = signal.type == 'BUY';

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE8EDF5)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  signal.pair,
                  style: TextFontStyle.headlineRoboto80012Blue,
                ),
              ),

              UIHelper.horizontalSpace(8.w),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isBuy
                      ? const Color(0xFFDCFCE7)
                      : const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(7.r),
                ),
                child: Text(
                  signal.type,
                  style: TextFontStyle.headlineRoboto80010Badge.copyWith(
                    color: isBuy
                        ? const Color(0xFF15803D)
                        : const Color(0xFFDC2626),
                  ),
                ),
              ),

              const Spacer(),

              if (signal.status.isNotEmpty)
                Text(
                  signal.status,
                  style: TextFontStyle.headlineRoboto60010Secondary,
                ),
            ],
          ),

          UIHelper.verticalSpace(15.h),

          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          UIHelper.verticalSpace(14.h),

          Row(
            children: [
              SignalValueRowWidget(title: 'Entry Price', value: signal.entry),
              SignalValueRowWidget(title: 'Stop Loss', value: signal.stopLoss),
              SignalValueRowWidget(
                title: 'Take Profit',
                value: signal.takeProfit,
              ),
            ],
          ),

          UIHelper.verticalSpace(14.h),

          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 14.r,
                color: const Color(0xFF94A3B8),
              ),

              UIHelper.horizontalSpace(5.w),

              Text(
                '${signal.date}  •  ${signal.time}',
                style: TextFontStyle.headlineRoboto40010Secondary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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

          SizedBox(height: 5.h),

          Text(value, style: TextFontStyle.headlineRoboto70011Dark),
        ],
      ),
    );
  }
}
