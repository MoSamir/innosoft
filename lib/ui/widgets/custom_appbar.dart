import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:innosoft/resources/Assets.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isTransparent;

  final TabBar tabBar;

  CustomAppbar({this.tabBar, this.isTransparent = false});

  Widget build(BuildContext context) {
    BoxDecoration decoration = BoxDecoration(color: Colors.transparent);
    if ((isTransparent ?? false) == false)
      decoration = BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(Assets.appbarBackground),
        ),
      );

    return Container(
        decoration: decoration,
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          bottom: tabBar ??
              PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: Container(),
              ),
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(tabBar == null ? 100 : 80);
}
