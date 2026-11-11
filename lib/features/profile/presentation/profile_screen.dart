import 'package:aitek_task/assets_helper/app_colors.dart';
import 'package:aitek_task/common_widget/custom_app_bar_widget.dart';
import 'package:aitek_task/common_widget/custom_button.dart';
import 'package:aitek_task/features/auth/presentation/login_screen.dart';
import 'package:aitek_task/features/profile/presentation/widgets/logout_dialog_widget.dart';
import 'package:aitek_task/features/profile/presentation/widgets/profile_header_section_widget.dart';
import 'package:aitek_task/features/profile/presentation/widgets/profile_info_card_widget.dart';
import 'package:aitek_task/features/profile/presentation/widgets/profile_info_container_widget.dart';
import 'package:aitek_task/features/profile/presentation/widgets/profile_info_item_widget.dart';
import 'package:aitek_task/helpers/ui_helpers.dart';
import 'package:aitek_task/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Temporary profile data
  // Replace with API response data later.
  final String login = '20234561';
  final String name = 'Sohel Rana';
  final String email = 'sohel@example.com';
  final String phone = '+880 1XXX-XXXXXX';
  final String accountType = 'Trading Account';
  final String status = 'Active';

  bool _isLoggingOut = false;

  Future<void> _logout() async {
    setState(() => _isLoggingOut = true);

    try {
      await authenticationRXObj.logoutRX();

      if (!mounted) return;

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to logout. Please try again.')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoggingOut = false);
      }
    }
  }

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
              ProfileInfoContainerWidget(
                name: name,
                login: login,
                status: status,
              ),

              UIHelper.verticalSpace(28.h),

              // ================= PERSONAL INFORMATION =================
              ProfileHeaderSectionWidget(
                title: 'Personal Information',
                icon: Icons.person_outline_rounded,
              ),

              UIHelper.verticalSpace(14.h),

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

              UIHelper.verticalSpace(24.h),

              // ================= ACCOUNT INFORMATION =================
              ProfileHeaderSectionWidget(
                title: 'Account Information',
                icon: Icons.account_balance_outlined,
              ),

              UIHelper.verticalSpace(14.h),

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

              UIHelper.verticalSpace(24.h),

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
                    UIHelper.horizontalSpace(12.w),
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

              UIHelper.verticalSpace(28.h),

              // ================= LOGOUT BUTTON =================
              CustomButton(
                onTap: () {
                  if (_isLoggingOut) return;
                  showDialog<void>(
                    context: context,
                    builder: (dialogContext) => LogoutDialogWidget(
                      logoutOnTap: () {
                        Navigator.of(dialogContext).pop();
                        _logout();
                      },
                    ),
                  );
                },
                title: _isLoggingOut ? 'Logging out...' : 'Logout',
                fillColor: AppColors.logoutRedColor,
                borderRadius: BorderRadius.circular(14.r),
              ),

              UIHelper.verticalSpace(24.h),
            ],
          ),
        ),
      ),
    );
  }
}
