import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'app/di.dart';
import 'app/my_app.dart';
import 'presentation/languages/language_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        arabicLocale,
        englishLocale,
      ],
      path: localizationPath,
      child: Phoenix(
        child: const MyApp(),
      ),
    ),
  );
}
