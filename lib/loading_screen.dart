import 'package:aitek_task/features/auth/presentation/login_screen.dart';
import 'package:flutter/material.dart';

import 'constants/app_constants.dart';
import 'helpers/di.dart';
import 'networks/dio/dio.dart';
import 'welcome_screen.dart';

// final class Loading extends StatefulWidget {
//   const Loading({super.key});

//   @override
//   State<Loading> createState() => _LoadingState();
// }

// class _LoadingState extends State<Loading> {
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     loadInitialData();
//   }

//   Future<void> loadInitialData() async {
//     /// Update dio token if logged in
//     if (appData.read(kKeyIsLoggedIn) == true) {
//       String token = appData.read(kKeyAccessToken);
//       DioSingleton.instance.update(token);
//     }

//     await setInitValue();

//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return const WelcomeScreen();
//     }

//     /// ✅ FIRST TIME → OnBoarding (only once)
//     if (appData.read(kKeyIsFirstTime) == true) {
//       return const OnBoardingScreen();
//     }

//     /// ✅ AFTER ONBOARDING
//     if (appData.read(kKeyIsLoggedIn) == true ||
//         appData.read(kKeyIsExploring) == true) {
//       return const NavigationScreen();
//     }

//     /// ✅ NOT LOGGED IN
//     return const LoginScreen();
//   }
// }
final class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _isLoading = true;

  @override
  void initState() {
    loadInitialData();
    super.initState();
  }

  Future<void> loadInitialData() async {
    if (appData.read(kKeyIsLoggedIn)) {
      String token = appData.read(kKeyAccessToken);
      DioSingleton.instance.update(token);
      //await getProfileRXOBJ.getProfile();
    }
    // await getCurrencyRXOBJ.getCurrency();
    // await initializeNotifications();
    //  LocalNotificationService.initialize();
    // LocalNotificationService.getToken();
    // DateTime time = DateTime.now().add(const Duration(minutes: 2));
    // await schedulePrayerNotifications(time);

    // await schedulePrayerNotifications();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const WelcomeScreen();
    } else {
      return const LoginScreen();
      // return appData.read(kKeyIsLoggedIn) || appData.read(kKeyIsExploring)
      //     ? const NavigationScreen()
      //     : const LoginScreen();

      // return appData.read(kKeyIsFirstTime)
      //     ? const OnBoardingScreen()
      //     : appData.read(kKeyIsLoggedIn)
      //     ? const NavigationScreen()
      //     : const LoginScreen();
    }
  }
}
