import 'dart:developer';

import 'package:aitek_task/assets_helper/app_colors.dart';
import 'package:aitek_task/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:provider/provider.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'constants/app_constants.dart';
import 'constants/custome_theme.dart';
import 'helpers/all_routes.dart';
import 'helpers/di.dart';
import 'helpers/helper_methods.dart';
import 'helpers/language.dart';
import 'helpers/navigation_service.dart';
import 'helpers/register_provider.dart';
import 'networks/dio/dio.dart';

// Future<void> backgroundHandler(RemoteMessage message) async {}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  diSetup();
  await setInitValue();
  initiInternetChecker();
  DioSingleton.instance.create();
  try {
    await FlutterDisplayMode.setHighRefreshRate();
  } catch (e) {
    log('Error setting high refresh rate: $e');
  }
  runApp(const MyApp());
  // runApp(
  //   DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    rotation();
    return SafeArea(
      top: false,
      child: MultiProvider(
        providers: providers,
        child: AnimateIfVisibleWrapper(
          showItemInterval: const Duration(milliseconds: 150),
          child: PopScope(
            canPop: false,
            onPopInvokedWithResult: (bool didPop, dynamic result) async {
              showMaterialDialog(context);
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                return const UtillScreenMobile();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class UtillScreenMobile extends StatelessWidget {
  const UtillScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    String language = appData.read(kKeyLanguage) ?? kKeyBangla;
    String countryCode =
        appData.read(kKeyCountryCode) ?? countriesCode[kKeyBangla]!;

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, dynamic result) async {
            showMaterialDialog(context);
          },
          child: GetMaterialApp(
            showPerformanceOverlay: false,
            theme: ThemeData(
              primarySwatch: CustomTheme.kToDark,
              useMaterial3: false,
              scaffoldBackgroundColor: AppColors.backgroundAppColor,
            ),
            debugShowCheckedModeBanner: false,
            translations: LocalString(),
            locale: Locale(language, countryCode),
            builder: (context, widget) {
              return MediaQuery(data: MediaQuery.of(context), child: widget!);
            },
            navigatorKey: NavigationService.navigatorKey,
            onGenerateRoute: RouteGenerator.generateRoute,
            // home: const Loading(),
            home: const Loading(),
          ),
        );
      },
    );
  }
}
