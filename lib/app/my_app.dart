import 'package:advanced_flutter/app/app_prefs.dart';
import 'package:advanced_flutter/app/di.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../presentation/resources/routes_manager.dart';
import '../presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  const MyApp._internal();

  static const MyApp instance = MyApp._internal(); // factory

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppPrefs _appPrefs = gi<AppPrefs>();

  didChangeDependencies() {
    _appPrefs.getLocale().then((locale) => context.setLocale(locale));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: getAppTheme(),
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
    );
  }
}
