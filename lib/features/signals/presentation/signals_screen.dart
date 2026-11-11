import 'package:aitek_task/common_widget/custom_app_bar_widget.dart';
import 'package:aitek_task/constants/custom_app_list.dart';
import 'package:aitek_task/features/signals/presentation/widgets/currency_pair_selector.dart';
import 'package:aitek_task/features/signals/presentation/widgets/signal_card_widget.dart';
import 'package:aitek_task/features/signals/presentation/widgets/signals_date_filter_widget.dart';
import 'package:aitek_task/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignalsScreen extends StatefulWidget {
  const SignalsScreen({super.key});

  @override
  State<SignalsScreen> createState() => _SignalsScreenState();
}

class _SignalsScreenState extends State<SignalsScreen> {
  DateTime fromDate = DateTime.now().subtract(const Duration(days: 7));

  DateTime toDate = DateTime.now();

  bool isLoading = false;

  Future<void> selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(start: fromDate, end: toDate),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2563EB),
              onPrimary: Colors.white,
              surface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        fromDate = picked.start;
        toDate = picked.end;
      });
    }
  }

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  Future<void> loadSignals() async {
    if (selectedPairs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one currency pair.'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // TODO: Integrate GetAnalyticSignals API here.

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: CustomAppBar(title: 'Signals Archive', showLeadingIcon: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Explore historical trading signals',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
              UIHelper.verticalSpace(12.h),
              // Currency Pair Selection

              CurrencyPairSelector(
                currencyPairs: currencyPairs,
                selectedPairs: selectedPairs,
                onSelectionChanged: (pairs) {
                  setState(() {
                    selectedPairs
                      ..clear()
                      ..addAll(pairs);
                  });
                },
              ),
              UIHelper.verticalSpace(22.h),

              SignalsDateFilterWidget(
                fromDate: fromDate,
                toDate: toDate,
                isLoading: isLoading,
                onSelectDateRange: selectDateRange,
                onLoadSignals: loadSignals,
              ),

              UIHelper.verticalSpace(26.h),
              // Signals List Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Historical Signals',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0B1F45),
                    ),
                  ),
                  Text(
                    '${signals.length} Results',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(14.h),

              ...signals.map((signal) => SignalCardWidget(signal: signal)),

              // SignalCardWidget(signal: apiSignal),
            ],
          ),
        ),
      ),
    );
  }
}
