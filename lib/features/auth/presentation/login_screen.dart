import 'package:aitek_task/common_widget/custom_button.dart';
import 'package:aitek_task/common_widget/custom_text_form_field.dart';
import 'package:aitek_task/constants/app_constants.dart';
import 'package:aitek_task/features/auth/presentation/widgets/login_welcome_section_widget.dart';
import 'package:aitek_task/features/auth/presentation/widgets/remember_me_row_widget.dart';
import 'package:aitek_task/features/auth/presentation/widgets/secuirity_info_widget.dart';
import 'package:aitek_task/helpers/all_routes.dart';
import 'package:aitek_task/helpers/di.dart';
import 'package:aitek_task/helpers/navigation_service.dart';
import 'package:aitek_task/helpers/ui_helpers.dart';
import 'package:aitek_task/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aitek_task/helpers/toast.dart';

import '../../../assets_helper/app_colors.dart';
import 'widgets/login_header_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = true;
  bool _isLoading = false;

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginMethod() async {
    if (!formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    setState(() => _isLoading = true);

    try {
      final isSuccess = await authenticationRXObj.authenticationRX(
        login: loginController.text.trim(),
        password: passwordController.text,
      );
      appData.write(kKeyLoginID, loginController.text.trim());

      if (!mounted) return;

      if (isSuccess) {
        ToastUtil.showShortToast('Login successful');

        NavigationService.navigateTo(Routes.navigationScreen);
      } else {
        ToastUtil.showShortToast('Authentication failed');
      }
    } catch (error) {
      if (!mounted) return;

      ToastUtil.showShortToast('Login failed. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  children: [
                    const LoginHeaderWidget(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UIHelper.verticalSpace(30.h),
                            const LoginWelcomeSectionWidget(),
                            UIHelper.verticalSpace(28.h),
                            CustomTextFormField(
                              controller: loginController,
                              hintText: 'Enter your login',
                              prefixIcon: Icon(Icons.person_outline_rounded),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your login';
                                }
                                return null;
                              },
                            ),
                            UIHelper.verticalSpace(16.h),
                            CustomTextFormField(
                              controller: passwordController,
                              hintText: 'Enter your password',
                              prefixIcon: Icon(Icons.lock_outline_rounded),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              obscureText: _obscurePassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.secondaryTextColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              onTap: () => loginMethod(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                            UIHelper.verticalSpace(16.h),
                            RememberMeRowWidget(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() => _rememberMe = value);
                              },
                              onForgotPassword: () {
                                NavigationService.navigateTo(
                                  Routes.navigationScreen,
                                );
                              },
                            ),
                            UIHelper.verticalSpace(28.h),
                            _isLoading
                                ? Center(
                                    child: SizedBox(
                                      height: 22.r,
                                      width: 22.r,
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  )
                                : CustomButton(
                                    onTap: loginMethod,
                                    title: 'Sign In',
                                  ),
                            UIHelper.verticalSpace(24.h),
                            const SecurityInfoWidget(),
                            UIHelper.verticalSpace(24.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
