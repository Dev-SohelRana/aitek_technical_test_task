import 'package:aitek_task/constants/text_font_style.dart';
import 'package:aitek_task/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrencyPairSelector extends StatelessWidget {
  final List<String> currencyPairs;
  final List<String> selectedPairs;
  final ValueChanged<List<String>> onSelectionChanged;

  const CurrencyPairSelector({
    super.key,
    required this.currencyPairs,
    required this.selectedPairs,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Currency Pairs',
              style: TextFontStyle.headlineRoboto80015Dark,
            ),
            Text(
              '${selectedPairs.length} Selected',
              style: TextFontStyle.headlineRoboto60011Primary,
            ),
          ],
        ),
        UIHelper.verticalSpace(12.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFFE8EDF5)),
          ),
          child: Wrap(
            spacing: 8.w,
            runSpacing: 10.h,
            children: currencyPairs.map((pair) {
              final isSelected = selectedPairs.contains(pair);

              return InkWell(
                borderRadius: BorderRadius.circular(9.r),
                onTap: () {
                  final updatedPairs = List<String>.from(selectedPairs);

                  if (isSelected) {
                    updatedPairs.remove(pair);
                  } else {
                    updatedPairs.add(pair);
                  }

                  onSelectionChanged(updatedPairs);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 9.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFEFF6FF)
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(9.r),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF2563EB)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSelected) ...[
                        Icon(
                          Icons.check_circle_rounded,
                          size: 14.r,
                          color: const Color(0xFF2563EB),
                        ),
                        SizedBox(width: 5.w),
                      ],
                      Text(
                        pair,
                        style: TextFontStyle.headlineRoboto70011Pair.copyWith(
                          color: isSelected
                              ? const Color(0xFF2563EB)
                              : const Color(0xFF475569),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
