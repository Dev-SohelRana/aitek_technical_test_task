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

// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     Text(
//       'Quick Access',
//       style: TextStyle(
//         fontSize: 18.sp,
//         fontWeight: FontWeight.w800,
//         color: AppColors.darkTextColor,
//       ),
//     ),
//   ],
// ),
// UIHelper.verticalSpace(14.h),
// Row(
//   children: [
//     Expanded(
//       child: GestureDetector(
//         onTap: () {
//           NavigationService.navigateTo(Routes.signalsScreen);
//         },
//         child: Container(
//           padding: EdgeInsets.all(16.r),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(18.r),
//             border: Border.all(color: const Color(0xFFE8EDF5)),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: 45.r,
//                 width: 45.r,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFEFF6FF),
//                   borderRadius: BorderRadius.circular(13.r),
//                 ),
//                 child: Icon(
//                   Icons.candlestick_chart_rounded,
//                   color: AppColors.primaryColor,
//                   size: 25.r,
//                 ),
//               ),

//               UIHelper.verticalSpace(14.h),

//               Text(
//                 'Signals Archive',
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w700,
//                   color: AppColors.darkTextColor,
//                 ),
//               ),

//               UIHelper.verticalSpace(5.h),

//               Text(
//                 'Explore trading signals',
//                 style: TextStyle(
//                   fontSize: 11.sp,
//                   color: AppColors.secondaryTextColor,
//                 ),
//               ),

//               UIHelper.verticalSpace(12.h),

//               Icon(
//                 Icons.arrow_forward_rounded,
//                 color: AppColors.primaryColor,
//                 size: 19.r,
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),

//     UIHelper.horizontalSpace(12.w),

//     Expanded(
//       child: GestureDetector(
//         // onTap: () {
//         //   Get.to(
//         //     () => const PromoScreen(),
//         //     transition: Transition.rightToLeft,
//         //   );
//         // },
//         child: Container(
//           padding: EdgeInsets.all(16.r),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(18.r),
//             border: Border.all(color: const Color(0xFFE8EDF5)),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: 45.r,
//                 width: 45.r,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFFFF7ED),
//                   borderRadius: BorderRadius.circular(13.r),
//                 ),
//                 child: Icon(
//                   Icons.campaign_rounded,
//                   color: const Color(0xFFF59E0B),
//                   size: 25.r,
//                 ),
//               ),

//               UIHelper.verticalSpace(14.h),

//               Text(
//                 'Promo Materials',
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w700,
//                   color: AppColors.darkTextColor,
//                 ),
//               ),

//               UIHelper.verticalSpace(5.h),

//               Text(
//                 'Explore latest promotions',
//                 style: TextStyle(
//                   fontSize: 11.sp,
//                   color: AppColors.secondaryTextColor,
//                 ),
//               ),

//               UIHelper.verticalSpace(12.h),

//               Icon(
//                 Icons.arrow_forward_rounded,
//                 color: const Color(0xFFF59E0B),
//                 size: 19.r,
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   ],
// ),

// UIHelper.verticalSpace(28.h),
