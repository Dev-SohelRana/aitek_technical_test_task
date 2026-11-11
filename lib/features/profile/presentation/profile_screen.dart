import 'package:aitek_task/assets_helper/app_colors.dart';
import 'package:aitek_task/common_widget/custom_app_bar_widget.dart';
import 'package:aitek_task/features/profile/presentation/widgets/profile_header_section_widget.dart';
import 'package:aitek_task/features/profile/presentation/widgets/profile_info_card_widget.dart';
import 'package:aitek_task/features/profile/presentation/widgets/profile_info_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // static const Color primaryColor = Color(0xFF2563EB);
  // static const Color darkColor = Color(0xFF0B1F45);
  // static const Color backgroundColor = Color(0xFFF6F8FC);

  // Temporary profile data
  // Replace with API response data later.
  final String login = '20234561';
  final String name = 'Sohel Rana';
  final String email = 'sohel@example.com';
  final String phone = '+880 1XXX-XXXXXX';
  final String accountType = 'Trading Account';
  final String status = 'Active';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      appBar: CustomAppBar(showLeadingIcon: false, title: 'My Profile'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= PROFILE HEADER =================

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24.r),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0B1F45), Color(0xFF2563EB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 76.r,
                      width: 76.r,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.person_rounded,
                        size: 42.r,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 16.h),

                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 6.h),

                    Text(
                      'Login ID: $login',
                      style: TextStyle(fontSize: 14.sp, color: Colors.white70),
                    ),

                    SizedBox(height: 16.h),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 7.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCFCE7),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 7.r,
                            width: 7.r,
                            decoration: const BoxDecoration(
                              color: Color(0xFF16A34A),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 7.w),
                          Text(
                            status,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF166534),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 28.h),

              // ================= PERSONAL INFORMATION =================
              ProfileHeaderSectionWidget(
                title: 'Personal Information',
                icon: Icons.person_outline_rounded,
              ),

              SizedBox(height: 14.h),

              ProfileInfoCardWidget(
                children: [
                  ProfileInfoItemWidget(
                    icon: Icons.person_outline_rounded,
                    title: 'Full Name',
                    value: name,
                  ),

                  ProfileInfoItemWidget(
                    icon: Icons.email_outlined,
                    title: 'Email Address',
                    value: email,
                  ),

                  ProfileInfoItemWidget(
                    icon: Icons.phone_outlined,
                    title: 'Phone Number',
                    value: phone,
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // ================= ACCOUNT INFORMATION =================
              ProfileHeaderSectionWidget(
                title: 'Account Information',
                icon: Icons.account_balance_outlined,
              ),

              SizedBox(height: 14.h),

              ProfileInfoCardWidget(
                children: [
                  ProfileInfoItemWidget(
                    icon: Icons.badge_outlined,
                    title: 'Account Login',
                    value: login,
                  ),

                  ProfileInfoItemWidget(
                    icon: Icons.account_balance_wallet_outlined,
                    title: 'Account Type',
                    value: accountType,
                  ),

                  ProfileInfoItemWidget(
                    icon: Icons.verified_user_outlined,
                    title: 'Account Status',
                    value: status,
                    valueColor: const Color(0xFF16A34A),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // ================= SECURITY INFO =================
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
                      Icons.shield_rounded,
                      color: AppColors.primaryColor,
                      size: 28.r,
                    ),

                    SizedBox(width: 12.w),

                    Expanded(
                      child: Text(
                        'Your account information is securely managed.',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.darkTextColor,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
