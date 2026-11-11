import 'package:aitek_task/assets_helper/app_colors.dart';
import 'package:aitek_task/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountTopCardWidget extends StatelessWidget {
  final String accountLoginNumber;
  const AccountTopCardWidget({super.key, required this.accountLoginNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0B1F45), Color(0xFF174EA6), Color(0xFF2563EB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.16),
            blurRadius: 18.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet_outlined,
                color: Colors.white70,
                size: 21.r,
              ),
              SizedBox(width: 8.w),
              Text(
                'TRADING ACCOUNT',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                  color: Colors.white70,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 6.r,
                      width: 6.r,
                      decoration: const BoxDecoration(
                        color: Color(0xFF16A34A),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      'Connected',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF166534),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(24.h),
          Text(
            'Account Login',
            style: TextStyle(fontSize: 12.sp, color: Colors.white70),
          ),
          UIHelper.verticalSpace(6.h),
          Row(
            children: [
              Text(
                accountLoginNumber,
                style: TextStyle(
                  fontSize: 27.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(width: 10.w),
              Icon(
                Icons.verified_rounded,
                color: const Color(0xFF93C5FD),
                size: 20.r,
              ),
            ],
          ),
          UIHelper.verticalSpace(22.h),
          Divider(color: Colors.white.withValues(alpha: 0.2)),
          UIHelper.verticalSpace(12.h),
          Row(
            children: [
              Icon(Icons.security_rounded, color: Colors.white70, size: 17.r),
              UIHelper.horizontalSpace(7.w),
              Expanded(
                child: Text(
                  'Your trading account is securely connected.',
                  style: TextStyle(fontSize: 11.sp, color: Colors.white70),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
