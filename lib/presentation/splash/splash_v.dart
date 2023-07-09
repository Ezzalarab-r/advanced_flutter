import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/app_preferences.dart';
import '../../app/di.dart';
import '../resources/assets_manager.dart';
import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';
import '../resources/routes_manager.dart';

class SplashV extends StatefulWidget {
  const SplashV({super.key});

  @override
  State<SplashV> createState() => _SplashVState();
}

class _SplashVState extends State<SplashV> {
  Timer? _timer;
  final AppPreferences _appPreferences = gi<AppPreferences>();

  _startDelay() {
    _timer = Timer(
      const Duration(seconds: ViewConstants.splashDelay),
      _goNext,
    );
  }

  _goNext() async {
    _appPreferences.getIsLoggedIn().then((isLoggedIn) async {
      if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
      } else {
        _appPreferences.getIsOnBoardingViewed().then((isOnBoardingViewed) {
          if (isOnBoardingViewed) {
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          } else {
            Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: SvgPicture.asset(
          ImagesAssets.python,
          height: 200,
          width: 200,
          color: ColorManager.primary,
        ),
      ),
    );
  }
}
