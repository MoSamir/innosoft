import 'package:flutter/material.dart';
import 'package:innosoft/data_providers/models/PredictionModel.dart';
import 'package:innosoft/resources/Assets.dart';

class PredictionCard extends StatelessWidget {
  final PredictionModel prediction;

  PredictionCard({this.prediction});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: Column(
        children: [
          Container(
            width: 120,
            height: 100,
            child: Center(
              child: Image.asset(prediction.team.teamLogo),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              prediction.team.teamName,
              style: Assets.headlines,
            ),
          ),
          Text(
            '${prediction.percentage}%',
            style: Assets.subTitles,
          ),
        ],
      ),
    );
  }
}
