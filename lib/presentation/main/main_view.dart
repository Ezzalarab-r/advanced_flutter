import 'package:flutter/material.dart';

import '../../app/app_preferences.dart';
import '../../app/di.dart';
import '../resources/strings_manager.dart';
import '../resources/colors_manager.dart';
import '../resources/values_manager.dart';
import 'home/v/home_v.dart';
import 'notifications/v/notifications_v.dart';
import 'search/v/search_v.dart';
import 'settings/v/settings_v.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final List<Widget> pages = const [
    HomeV(),
    SearchPage(),
    NotificationsV(),
    SettingsV(),
  ];

  final List<String> _titles = const [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notifications,
    AppStrings.settings,
  ];

  String _pageTitle = "Home";
  int _currentPageIndex = 0;

  AppPreferences ap = gi<AppPreferences>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitle,
            style: Theme.of(context).textTheme.bodyMedium), // titleSmall
      ),
      body: pages[_currentPageIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorManager.grey3,
              spreadRadius: AppSize.s1,
              blurRadius: AppSize.s1_5,
            ),
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentPageIndex,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: "home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search_outlined,
              ),
              label: "search",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications_outlined,
              ),
              label: "notifications",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.more_vert_outlined,
              ),
              label: "settings",
            ),
          ],
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentPageIndex = index;
      _pageTitle = _titles[index];
    });
  }
}
