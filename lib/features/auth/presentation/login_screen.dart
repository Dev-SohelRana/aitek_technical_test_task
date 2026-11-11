import 'package:aitek_task/common_widget/custom_button.dart';
import 'package:aitek_task/common_widget/custom_text_form_field.dart';
import 'package:aitek_task/features/auth/presentation/widgets/login_welcome_section_widget.dart';
import 'package:aitek_task/features/auth/presentation/widgets/remember_me_row_widget.dart';
import 'package:aitek_task/features/auth/presentation/widgets/secuirity_info_widget.dart';
import 'package:aitek_task/helpers/all_routes.dart';
import 'package:aitek_task/helpers/navigation_service.dart';
import 'package:aitek_task/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  Future<void> _handleLogin() async {
    if (!formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);

    // TODO: Integrate Peanut & Partner authentication APIs.
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login API integration is pending.')),
    );
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
                              keyboardType: TextInputType.text,
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
                              onTap: () => _handleLogin(),
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
                                ? SizedBox(
                                    height: 22.r,
                                    width: 22.r,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: AppColors.cFFFFFF,
                                    ),
                                  )
                                : CustomButton(
                                    onTap: _handleLogin,
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
