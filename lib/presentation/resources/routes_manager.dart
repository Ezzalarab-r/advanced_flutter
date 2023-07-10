import 'package:flutter/material.dart';

import '../../app/di.dart';
import '../forgot_password/forgot_password_v.dart';
import '../login/login_v.dart';
import '../main/main_view.dart';
import '../onboarding/on_boarding_v.dart';
import '../register/register_v.dart';
import '../splash/splash_v.dart';
import '../store_details/store_details_v.dart';
import 'strings_manager.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/on_boarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgot_password";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/store_details";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashV());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingV());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginV());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterV());
      case Routes.forgotPasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgotPasswordV());
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRoute:
        initStoreDetails();
        return MaterialPageRoute(builder: (_) => const StoreDetailsV());
      default:
        return unHandeledRoute();
    }
  }

  static Route<dynamic> unHandeledRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
