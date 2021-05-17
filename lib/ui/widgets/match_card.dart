import 'package:flutter/material.dart';
import 'package:innosoft/data_providers/models/Match.dart';
import 'package:innosoft/resources/Assets.dart';
import 'package:innosoft/ui/widgets/team_icon.dart';

class MatchCard extends StatelessWidget {
  final Match match;

  MatchCard({this.match});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TeamIcon(
          team: match.homeTeam,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                match.matchTime,
                style: Assets.titles,
              ),
              Text(
                match.matchDate,
                style: Assets.subTitles,
              ),
            ],
          ),
        ),
        TeamIcon(
          team: match.homeTeam,
        ),
      ],
    );
  }
}
