import 'package:aitek_task/constants/text_font_style.dart';
import 'package:aitek_task/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignalsDateFilterWidget extends StatelessWidget {
  final DateTime fromDate;
  final DateTime toDate;
  final bool isLoading;
  final VoidCallback onSelectDateRange;
  final VoidCallback onLoadSignals;

  const SignalsDateFilterWidget({
    super.key,
    required this.fromDate,
    required this.toDate,
    required this.isLoading,
    required this.onSelectDateRange,
    required this.onLoadSignals,
  });

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date Range', style: TextFontStyle.headlineRoboto80015Dark),

        UIHelper.verticalSpace(12.h),

        GestureDetector(
          onTap: onSelectDateRange,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: const Color(0xFFE8EDF5)),
            ),
            child: Row(
              children: [
                Container(
                  height: 40.r,
                  width: 40.r,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(11.r),
                  ),
                  child: Icon(
                    Icons.calendar_month_rounded,
                    color: const Color(0xFF2563EB),
                    size: 21.r,
                  ),
                ),

                UIHelper.horizontalSpace(12.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected Period',
                        style: TextFontStyle.headlineRoboto40010Secondary,
                      ),

                      SizedBox(height: 4.h),

                      Text(
                        '${formatDate(fromDate)} - ${formatDate(toDate)}',
                        style: TextFontStyle.headlineRoboto70012Dark,
                      ),
                    ],
                  ),
                ),

                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: const Color(0xFF64748B),
                  size: 22.r,
                ),
              ],
            ),
          ),
        ),

        UIHelper.verticalSpace(18.h),

        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            onPressed: isLoading ? null : onLoadSignals,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              disabledBackgroundColor: const Color(0xFF93B4F5),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.r),
              ),
            ),
            child: isLoading
                ? SizedBox(
                    height: 21.r,
                    width: 21.r,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                        size: 19.r,
                      ),

                      SizedBox(width: 8.w),

                      Text(
                        'Load Signals',
                        style: TextFontStyle.headlineRoboto70014White,
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
