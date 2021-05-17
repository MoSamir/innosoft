import 'package:flutter/material.dart';
import 'package:innosoft/data_providers/models/Team.dart';
import 'package:innosoft/resources/Assets.dart';

class TeamIcon extends StatelessWidget {
  final Team team;

  TeamIcon({this.team});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.horizontal,
      children: [
        Image.asset(
          team.teamLogo,
          height: 50,
          width: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            team.teamName,
            textAlign: TextAlign.center,
            style: Assets.headlines,
          ),
        )
      ],
    );
  }
}
