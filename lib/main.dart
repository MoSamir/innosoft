import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:innosoft/resources/Assets.dart';
import 'package:innosoft/ui/screens/landing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        useOnlyLangCode: true,
        saveLocale: true,
        path: 'assets/lang',
        // <-- change the path of the translation files
        fallbackLocale: Locale('ar'),
        startLocale: Locale('ar'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            bottomAppBarColor: Assets.darkBlueColor,
            fontFamily: Assets.fontAJanaat),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: LandingScreen());
  }
}
