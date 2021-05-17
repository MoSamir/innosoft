import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:innosoft/resources/Assets.dart';
import 'package:innosoft/resources/LocalKeys.dart';
import 'package:innosoft/ui/screens/media_center_screen.dart';
import 'package:innosoft/ui/screens/more_screen.dart';
import 'package:innosoft/ui/screens/soon_screen.dart';
import 'package:innosoft/ui/screens/users_screen.dart';

import 'home_screen.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  List<BottomNavigationBarItem> _bottomNavigationBarItems = [];
  List<Widget> _screens = [];
  int activeTab = 0;

  @override
  void initState() {
    super.initState();
    initializeBottomNavigationBarItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        showSelectedLabels: true,
        currentIndex: activeTab,
        onTap: (int index) {
          setState(() {
            activeTab = index;
          });
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
        backgroundColor: Assets.darkBlueColor,
        items: _bottomNavigationBarItems,
      ),
      body: _screens[activeTab],
    );
  }

  void initializeBottomNavigationBarItems() {
    _bottomNavigationBarItems.add(BottomNavigationBarItem(
      backgroundColor: Assets.darkBlueColor,
      icon: ImageIcon(AssetImage(Assets.homeIcon)),
      label: (LocalKeys.BOTTOM_BAR_HOME).tr(),
    ));
    _screens.add(HomeScreen());

    _bottomNavigationBarItems.add(BottomNavigationBarItem(
      backgroundColor: Assets.darkBlueColor,
      icon: ImageIcon(AssetImage(Assets.leagueStandingIcon)),
      label: (LocalKeys.BOTTOM_BAR_LEAGUE_STANDING).tr(),
    ));
    _screens.add(UsersScreen());

    _bottomNavigationBarItems.add(BottomNavigationBarItem(
      backgroundColor: Assets.darkBlueColor,
      icon: ImageIcon(AssetImage(Assets.mediaCenterIcon)),
      label: (LocalKeys.BOTTOM_BAR_MEDIA_CENTER).tr(),
    ));
    _screens.add(MediaCenterScreen());

    _bottomNavigationBarItems.add(BottomNavigationBarItem(
      backgroundColor: Assets.darkBlueColor,
      icon: ImageIcon(AssetImage(Assets.statisticsIcon)),
      label: (LocalKeys.BOTTOM_BAR_STATISTICS).tr(),
    ));
    _screens.add(SoonScreen());

    _bottomNavigationBarItems.add(BottomNavigationBarItem(
      backgroundColor: Assets.darkBlueColor,
      icon: ImageIcon(AssetImage(Assets.moreIcon)),
      label: (LocalKeys.BOTTOM_BAR_MORE).tr(),
    ));
    _screens.add(MoreScreen());
  }
}
