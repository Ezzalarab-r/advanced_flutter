import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../../data/data_sources/local_ds.dart';
import '../../resources/colors_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';
import '../../resources/strings_manager.dart';

class SettingsV extends StatefulWidget {
  const SettingsV({super.key});

  @override
  State<SettingsV> createState() => _SettingsVState();
}

class _SettingsVState extends State<SettingsV> {
  final AppPrefs _appPrefs = gi<AppPrefs>();
  final LocalDS _localDS = gi<LocalDS>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(AppPadding.p8),
        children: [
          ListTile(
            leading: const Icon(
              Icons.translate_outlined,
              color: ColorManager.primary,
            ),
            title: Text(
              AppStrings.changeLanguage,
              style: Theme.of(context).textTheme.bodyLarge,
            ).tr(),
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: ColorManager.primary,
            ),
            onTap: () {
              _changeLanguage();
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.groups_outlined,
              color: ColorManager.primary,
            ),
            title: Text(
              AppStrings.contactUs.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: ColorManager.primary,
            ),
            onTap: () {
              _contactUs();
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.share_outlined,
              color: ColorManager.primary,
            ),
            title: Text(
              AppStrings.inviteYourFriends.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: ColorManager.primary,
            ),
            onTap: () {
              _inviteFriends();
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_outlined,
              color: ColorManager.primary,
            ),
            title: Text(
              AppStrings.logout.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              _logout();
            },
          ),
        ],
      ),
    );
  }

  void _changeLanguage() {
    _appPrefs.changeAppLang();
    Phoenix.rebirth(context);
  }

  void _contactUs() {}

  void _inviteFriends() {}

  void _logout() {
    _appPrefs.setIsLogOut();
    _localDS.clearCache();
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}
