import 'package:aitek_task/features/auth/presentation/login_screen.dart';
import 'package:aitek_task/helpers/helper_methods.dart';
import 'package:aitek_task/navigation_screen.dart';
import 'package:aitek_task/networks/api_acess.dart';
import 'package:flutter/material.dart';

import 'constants/app_constants.dart';
import 'helpers/di.dart';
import 'welcome_screen.dart';

final class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

final class _LoadingState extends State<Loading> {
  bool _isLoading = true;
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    try {
      await setInitValue();

      final bool isLoggedIn = appData.read(kKeyIsLoggedIn) ?? false;

      if (isLoggedIn) {
        _isAuthenticated = await authenticationRXObj.restoreSessionRX();
      }
    } catch (error) {
      debugPrint('Initial loading error: $error');
      _isAuthenticated = false;
    }

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const WelcomeScreen();
    }

    // First-time user
    // if (appData.read(kKeyIsFirstTime) == true) {
    //   return const OnBoardingScreen();
    // }

    // Logged-in or exploring user
    if (_isAuthenticated || appData.read(kKeyIsExploring) == true) {
      return const NavigationScreen();
    }

    // Not logged in
    return const LoginScreen();
  }
}
