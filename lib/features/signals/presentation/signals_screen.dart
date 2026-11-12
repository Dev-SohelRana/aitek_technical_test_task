import 'package:aitek_task/common_widget/custom_app_bar_widget.dart';
import 'package:aitek_task/constants/custom_app_list.dart';
import 'package:aitek_task/constants/text_font_style.dart';
import 'package:aitek_task/features/signals/presentation/widgets/currency_pair_selector.dart';
import 'package:aitek_task/features/signals/presentation/widgets/signal_card_widget.dart';
import 'package:aitek_task/features/signals/presentation/widgets/signals_date_filter_widget.dart';
import 'package:aitek_task/helpers/ui_helpers.dart';
import 'package:aitek_task/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignalsScreen extends StatefulWidget {
  const SignalsScreen({super.key});

  @override
  State<SignalsScreen> createState() => _SignalsScreenState();
}

class _SignalsScreenState extends State<SignalsScreen> {
  final List<String> _selectedPairs = ['EURUSD', 'GBPUSD'];
  DateTime fromDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime toDate = DateTime.now();

  Future<void> selectDateRange() async {
    final picked = await showDateRangePicker(
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

  Future<void> loadSignals() async {
    if (_selectedPairs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one currency pair.'),
        ),
      );
      return;
    }

    await signalsRXObj.getSignals(
      pairs: List<String>.from(_selectedPairs),
      fromDate: fromDate,
      toDate: toDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: CustomAppBar(title: 'Signals Archive', showLeadingIcon: false),
      body: SafeArea(
        child: Obx(() {
          final isLoading = signalsRXObj.isLoading.value;
          final errorMessage = signalsRXObj.errorMessage.value;
          final signalList = signalsRXObj.signals.toList(growable: false);
          final hasLoaded = signalsRXObj.hasLoaded.value;

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Center(
                      child: Text(
                        'Explore historical trading signals',
                        textAlign: TextAlign.center,
                        style: TextFontStyle.headlineRoboto40014Secondary,
                      ),
                    ),
                    UIHelper.verticalSpace(12.h),
                    CurrencyPairSelector(
                      currencyPairs: currencyPairs,
                      selectedPairs: _selectedPairs,
                      onSelectionChanged: (pairs) {
                        setState(() {
                          _selectedPairs
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Historical Signals',
                          style: TextFontStyle.headlineRoboto80016Dark,
                        ),
                        Text(
                          '${signalList.length} Results',
                          style: TextFontStyle.headlineRoboto60011Secondary,
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(14.h),
                  ]),
                ),
              ),
              if (isLoading)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (errorMessage != null)
                SliverToBoxAdapter(
                  child: _SignalsMessage(
                    icon: Icons.cloud_off_outlined,
                    message: errorMessage,
                    actionLabel: 'Retry',
                    onAction: loadSignals,
                  ),
                )
              else if (signalList.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _SignalsMessage(
                    icon: Icons.query_stats_rounded,
                    message: hasLoaded
                        ? 'No signals found for the selected pairs and date range.'
                        : 'Select currency pairs and a date range, then load signals.',
                  ),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                          SignalCardWidget(signal: signalList[index]),
                      childCount: signalList.length,
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}

class _SignalsMessage extends StatelessWidget {
  const _SignalsMessage({
    required this.icon,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 24.h),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 36.r, color: const Color(0xFF64748B)),
            UIHelper.verticalSpace(10.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextFontStyle.headlineRoboto40013Secondary,
            ),
            if (actionLabel != null && onAction != null)
              TextButton(onPressed: onAction, child: Text(actionLabel!)),
          ],
        ),
      ),
    );
  }
}
