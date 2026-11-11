import 'dart:io';

import 'package:aitek_task/features/auth/presentation/login_screen.dart';
import 'package:aitek_task/features/profile/presentation/profile_screen.dart';
import 'package:aitek_task/features/signals/presentation/signals_screen.dart';
import 'package:aitek_task/navigation_screen.dart';
import 'package:flutter/cupertino.dart';

final class Routes {
  static final Routes _routes = Routes._internal();
  Routes._internal();
  static Routes get instance => _routes;

  static const String loadingScreen = '/Loading';
  static const String loginScreen = '/LoginScreen';
  static const String profileScreen = '/ProfileScreen';
  static const String navigationScreen = '/NavigationScreen';
  static const String signalsScreen = '/SignalsScreen';
}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();
  RouteGenerator._internal();
  static RouteGenerator get instance => _routeGenerator;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case Routes.loadingScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(widget: const Loading(), settings: settings)
      //       : CupertinoPageRoute(builder: (context) => const Loading());

      case Routes.loginScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const LoginScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const LoginScreen());

      case Routes.profileScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ProfileScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const ProfileScreen());

      case Routes.navigationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const NavigationScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const NavigationScreen(),
              );

      case Routes.signalsScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const SignalsScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const SignalsScreen());

      // case Routes.onBoardingScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: const OnBoardingScreen(),
      //           settings: settings,
      //         )
      //       : CupertinoPageRoute(
      //           builder: (context) => const OnBoardingScreen(),
      //         );

      default:
        return null;
    }
  }
}

//  weenAnimationBuilder(
//   child: Widget,
//   tween: Tween<double>(begin: 0, end: 1),
//   duration: Duration(milliseconds: 1000),
//   curve: Curves.bounceIn,
//   builder: (BuildContext context, double _val, Widget child) {
//     return Opacity(
//       opacity: _val,
//       child: Padding(
//         padding: EdgeInsets.only(top: _val * 50),
//         child: child
//       ),
//     );
//   },
// );

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({required this.widget, required this.settings})
    : super(
        settings: settings,
        reverseTransitionDuration: const Duration(milliseconds: 1),
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return widget;
            },
        transitionDuration: const Duration(milliseconds: 1),
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(
                opacity: CurvedAnimation(parent: animation, curve: Curves.ease),
                child: child,
              );
            },
      );
}

class ScreenTitle extends StatelessWidget {
  final Widget widget;

  const ScreenTitle({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: .5, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      builder: (context, value, child) {
        return Opacity(opacity: value, child: child);
      },
      child: widget,
    );
  }
}
