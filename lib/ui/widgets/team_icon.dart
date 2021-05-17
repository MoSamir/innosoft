import 'package:flutter/material.dart';
import 'package:innosoft/data_providers/models/Team.dart';
import 'package:innosoft/resources/Assets.dart';

class TeamIcon extends StatelessWidget {
  final Team team;

  TeamIcon({this.team});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: [
        Image.asset(
          team.teamLogo,
          height: 50,
          width: 50,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          team.teamName,
          style: Assets.headlines,
        )
      ],
    );
  }
}
