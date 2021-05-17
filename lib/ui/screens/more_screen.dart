import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:innosoft/resources/Assets.dart';
import 'package:innosoft/resources/LocalKeys.dart';
import 'package:innosoft/ui/screens/landing_screen.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Assets.darkBlueColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Image.asset(Assets.appbarLogo),
                    ),
                    getRow((LocalKeys.CLUB_GUID).tr(), Colors.white, () {}),
                    getRow((LocalKeys.PITCHES_GUID).tr(), Colors.white, () {}),
                    getRow(
                        (LocalKeys.WHO_ARE_US).tr(), Colors.redAccent, () {}),
                    getRow((LocalKeys.REGULATIONS).tr(), Colors.greenAccent,
                        () {}),
                    getRow((LocalKeys.COMMITTEES).tr(), Colors.blue, () {}),
                    getRow((LocalKeys.CONTACT_US).tr(), Colors.white, () {}),
                    getRow((LocalKeys.SHARE_APP).tr(), Colors.redAccent, () {}),
                    getRow(
                        (LocalKeys.SUBSCRIBE).tr(), Colors.greenAccent, () {}),
                    getRow((LocalKeys.LANGUAGE).tr(), Colors.greenAccent, () {
                      if (EasyLocalization.of(context).locale.languageCode ==
                          "en") {
                        EasyLocalization.of(context).setLocale(Locale("ar"));
                      } else {
                        EasyLocalization.of(context).setLocale(Locale("en"));
                      }
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => LandingScreen()),
                          (route) => false);
                    }),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    getButtonIcon(Assets.fbIcon, () {}),
                    getButtonIcon(Assets.twitterIcon, () {}),
                    getButtonIcon(Assets.instgramIcon, () {}),
                    getButtonIcon(Assets.linkedinIcon, () {}),
                    getButtonIcon(Assets.youtubeIcon, () {}),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getRow(String text, Color color, Function onClick) {
    return GestureDetector(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 4,
              color: color,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getButtonIcon(String assetPath, Function onClick) {
    return GestureDetector(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          assetPath,
          width: 30,
          height: 30,
        ),
      ),
    );
  }
}
