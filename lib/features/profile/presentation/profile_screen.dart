import 'dart:developer';

import 'package:aitek_task/assets_helper/app_colors.dart';
import 'package:aitek_task/common_widget/custom_app_bar_widget.dart';
import 'package:aitek_task/common_widget/custom_button.dart';
import 'package:aitek_task/constants/app_constants.dart';
import 'package:aitek_task/constants/text_font_style.dart';
import 'package:aitek_task/features/auth/presentation/login_screen.dart';
import 'package:aitek_task/features/profile/data/api.dart';
import 'package:aitek_task/features/profile/model/profile_model.dart';
import 'package:aitek_task/features/profile/presentation/widgets/logout_dialog_widget.dart';
import 'package:aitek_task/features/profile/presentation/widgets/profile_header_section_widget.dart';
import 'package:aitek_task/features/profile/presentation/widgets/profile_info_card_widget.dart';
import 'package:aitek_task/features/profile/presentation/widgets/profile_info_container_widget.dart';
import 'package:aitek_task/features/profile/presentation/widgets/profile_info_item_widget.dart';
import 'package:aitek_task/helpers/di.dart';
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
  ProfileModel _profile = ProfileModel.fallback;
  bool _isLoggingOut = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final login = appData.read(kKeyPeanutLogin)?.toString();
      final token = appData.read(kKeyPeanutToken)?.toString();
      if (login == null || login.isEmpty || token == null || token.isEmpty) {
        throw StateError('Peanut login session is unavailable');
      }

      final profile = await ProfileAPI().getProfile(login: login, token: token);
      if (!mounted) return;

      setState(() => _profile = profile);
    } catch (error) {
      log(
        error is ProfileApiException
            ? 'Profile loading failed: ${error.message}'
            : 'Profile loading failed: ${error.runtimeType}',
      );
    }
  }

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
                name: _profile.name,
                login: _profile.login,
                status: _profile.status,
              ),

              UIHelper.verticalSpace(28.h),

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
                    value: _profile.name,
                  ),
                  ProfileInfoItemWidget(
                    icon: Icons.phone_outlined,
                    title: 'Phone Number',
                    value: _profile.phone,
                  ),
                ],
              ),

              UIHelper.verticalSpace(24.h),

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
                    value: _profile.login,
                  ),
                  ProfileInfoItemWidget(
                    icon: Icons.account_balance_wallet_outlined,
                    title: 'Account Type',
                    value: _profile.accountType,
                  ),
                  ProfileInfoItemWidget(
                    icon: Icons.verified_user_outlined,
                    title: 'Account Status',
                    value: _profile.status,
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
                        style: TextFontStyle.headlineRoboto40012DarkHeight15,
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
