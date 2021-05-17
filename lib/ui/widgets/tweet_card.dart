import 'package:flutter/material.dart';
import 'package:innosoft/data_providers/models/Tweet.dart';
import 'package:innosoft/resources/Assets.dart';

class TweetCard extends StatelessWidget {
  final Tweet tweet;

  const TweetCard({this.tweet});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                Assets.appbarLogo,
                width: 50,
                height: 50,
              ),
              Column(
                children: [
                  Text(
                    tweet.tweetOwner,
                    style: Assets.headlines,
                  ),
                  Text(
                    '@${tweet.leagueName}',
                    style: Assets.subTitles,
                  ),
                ],
              ),
            ],
          ),
          Text(
            tweet.tweetBody,
            style: Assets.subTitles,
          ),
        ],
      ),
    );
  }
}
