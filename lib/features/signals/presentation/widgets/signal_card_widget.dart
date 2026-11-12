import 'package:aitek_task/helpers/ui_helpers.dart';
import 'package:aitek_task/features/signals/model/signal_model.dart';
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
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF2563EB),
                  ),
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
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w800,
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
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF64748B),
                  ),
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
                style: TextStyle(
                  fontSize: 10.sp,
                  color: const Color(0xFF64748B),
                ),
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
          Text(
            title,
            style: TextStyle(
              fontSize: 9.sp,
              color: const Color(0xFF94A3B8),
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 5.h),

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
