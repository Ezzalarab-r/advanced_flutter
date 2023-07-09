import 'package:flutter/material.dart';

import '../../resources/strings_manager.dart';

class SettingsV extends StatefulWidget {
  const SettingsV({super.key});

  @override
  State<SettingsV> createState() => _SettingsVState();
}

class _SettingsVState extends State<SettingsV> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppStrings.settings),
    );
  }
}
