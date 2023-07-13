import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../resources/strings_manager.dart';

class NotificationsV extends StatefulWidget {
  const NotificationsV({super.key});

  @override
  State<NotificationsV> createState() => _NotificationsVState();
}

class _NotificationsVState extends State<NotificationsV> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text(AppStrings.notifications).tr(),
    );
  }
}
