import 'package:aitek_task/assets_helper/app_colors.dart';
import 'package:aitek_task/common_widget/custom_app_bar_widget.dart';
import 'package:aitek_task/common_widget/custom_button.dart';
import 'package:aitek_task/constants/text_font_style.dart';
import 'package:aitek_task/features/auth/presentation/login_screen.dart';
import 'package:aitek_task/features/profile/data/rx.dart';
import 'package:aitek_task/features/profile/model/profile_model.dart';
import 'package:aitek_task/features/profile/presentation/widgets/logout_dialog_widget.dart';
import 'package:aitek_task/features/profile/presentation/widgets/profile_header_section_widget.dart';
import 'package:aitek_task/features/profile/presentation/widgets/profile_info_card_widget.dart';
import 'package:aitek_task/features/profile/presentation/widgets/profile_info_container_widget.dart';
import 'package:aitek_task/features/profile/presentation/widgets/profile_info_item_widget.dart';
import 'package:aitek_task/helpers/ui_helpers.dart';
import 'package:aitek_task/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileRX _profileRX;
  bool _isLoggingOut = false;

  @override
  void initState() {
    super.initState();
    _profileRX = Get.put(ProfileRX());
    _profileRX.getProfile();
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
      body: Obx(() {
        final profile = _profileRX.profileModel.value ?? ProfileModel.fallback;

        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_profileRX.errorMessage.value != null)
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _profileRX.errorMessage.value!,
                            style: TextFontStyle.headlineRoboto40012Secondary
                                .copyWith(color: AppColors.logoutRedColor),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: _profileRX.getProfile,
                          icon: const Icon(Icons.refresh_rounded),
                          label: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ProfileInfoContainerWidget(
                  name: profile.name,
                  login: profile.login,
                  status: profile.status,
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
                      value: profile.name,
                    ),
                    ProfileInfoItemWidget(
                      icon: Icons.phone_outlined,
                      title: 'Phone Number',
                      value: profile.phone ?? 'Not available',
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
                      value: profile.login,
                    ),
                    ProfileInfoItemWidget(
                      icon: Icons.account_balance_wallet_outlined,
                      title: 'Account Type',
                      value: profile.accountType,
                    ),
                    ProfileInfoItemWidget(
                      icon: Icons.verified_user_outlined,
                      title: 'Account Status',
                      value: profile.status,
                      valueColor: const Color(0xFF16A34A),
                    ),
                  ],
                ),

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
        );
      }),
    );
  }
}
