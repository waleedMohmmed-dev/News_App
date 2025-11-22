import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:news_app_practice/core/constants/networking/app_constants.dart';
import 'package:news_app_practice/core/constants/networking/dio_helper.dart';

import 'package:news_app_practice/core/futures/routing/router_generation_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  // ?init dio
  DioHelper.intiDio();
  runApp(
    EasyLocalization(
      startLocale: Locale(AppConstants.lang),
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations', // Path to translation files
      fallbackLocale: Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ! important to use ScreenUtilInit
    return MaterialApp.router(
      routerConfig: RouterGenerationConfig.goRouter,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Flutter Demo',
    );
  }
}
