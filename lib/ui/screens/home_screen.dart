import 'package:chewie/chewie.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:innosoft/data_providers/models/Match.dart';
import 'package:innosoft/data_providers/models/PredictionModel.dart';
import 'package:innosoft/data_providers/models/Team.dart';
import 'package:innosoft/data_providers/models/Tweet.dart';
import 'package:innosoft/resources/Assets.dart';
import 'package:innosoft/resources/LocalKeys.dart';
import 'package:innosoft/ui/widgets/PredictionCard.dart';
import 'package:innosoft/ui/widgets/custom_appbar.dart';
import 'package:innosoft/ui/widgets/match_card.dart';
import 'package:innosoft/ui/widgets/tweet_card.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ChewieController chewieController = ChewieController(
    videoPlayerController: VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
    autoPlay: false,
    looping: false,
  );

  List<Match> matches = [];
  List<Tweet> tweets = [];
  List<PredictionModel> predictions = [];

  @override
  void dispose() {
    chewieController.pause();
    chewieController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Assets.homeBackgroundColor,
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            getLatestNewsSection(),
            getUpcomingGames(),
            getLatestTweets(),
            getWinnerSection(),
            getVideosSection(),
            getSponsorsSection(),
          ],
        ),
      ),
    );
  }

  Widget getLatestNewsSection() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text((LocalKeys.LATEST_NEWS).tr()),
              TextButton(
                  onPressed: () {}, child: Text((LocalKeys.SHOW_MORE).tr()))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Image.asset(
              Assets.newsItem_1,
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.fill,
            ),
          ),
          Text(
            'الدوري السعودي',
            style: Assets.subTitles,
          ),
          Text(
            'من الملاعب السعودية إلى منصة التتويج بكأس العالم..',
            style: Assets.headlines,
          )
        ],
      ),
    );
  }

  Widget getUpcomingGames() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text((LocalKeys.UPCOMING_GAMES).tr()),
              TextButton(
                  onPressed: () {}, child: Text((LocalKeys.SHOW_MORE).tr()))
            ],
          ),
        ),
        Container(
          color: Colors.white,
          child: ListView.separated(
            padding: EdgeInsets.all(10),
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey,
            ),
            itemBuilder: (context, index) {
              return MatchCard(match: matches[index]);
            },
            itemCount: matches.length,
            shrinkWrap: true,
          ),
        )
      ],
    );
  }

  Widget getLatestTweets() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text((LocalKeys.LATEST_TWEETS).tr()),
              TextButton(
                  onPressed: () {}, child: Text((LocalKeys.SHOW_MORE).tr()))
            ],
          ),
        ),
        Container(
          color: Colors.white,
          child: ListView.separated(
            padding: EdgeInsets.all(10),
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey,
            ),
            itemBuilder: (context, index) {
              return TweetCard(tweet: tweets[index]);
            },
            itemCount: tweets.length,
            shrinkWrap: true,
          ),
        ),
      ],
    );
  }

  Widget getWinnerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text((LocalKeys.WHO_WINNER).tr()),
        ),
        Container(
          height: 180,
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(vertical: 10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return PredictionCard(prediction: predictions[index]);
              },
              itemCount: predictions.length,
              shrinkWrap: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget getVideosSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text((LocalKeys.VIDEOS_TAB).tr()),
        ),
        Container(
          padding: EdgeInsets.all(10),
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .25,
          child: Chewie(
            controller: chewieController,
          ),
        ),
      ],
    );
  }

  Widget getSponsorsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text((LocalKeys.SPONSORS_TITLE).tr()),
        ),
        Container(
          height: 100,
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(vertical: 10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 70,
                    width: 150,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Center(
                        child: Image.asset(
                          Assets.sponsorImg,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: 5,
              shrinkWrap: true,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    initializeTodayMatches();
    initializeTweets();
    initializePredictions();
  }

  void initializeTodayMatches() {
    matches.add(Match(
        awayTeam: Team(teamLogo: Assets.clubLogo, teamName: 'الاهلي'),
        homeTeam: Team(teamLogo: Assets.clubLogo, teamName: 'الاهلي'),
        matchDate: 'الخميس 15 يوليو',
        matchTime: '22:00'));
    matches.add(Match(
        awayTeam: Team(teamLogo: Assets.clubLogo, teamName: 'الاهلي'),
        homeTeam: Team(teamLogo: Assets.clubLogo, teamName: 'الاهلي'),
        matchDate: 'الخميس 15 يوليو',
        matchTime: '22:00'));
    matches.add(Match(
        awayTeam: Team(teamLogo: Assets.clubLogo, teamName: 'الاهلي'),
        homeTeam: Team(teamLogo: Assets.clubLogo, teamName: 'الاهلي'),
        matchDate: 'الخميس 15 يوليو',
        matchTime: '22:00'));
  }

  void initializeTweets() {
    tweets.add(Tweet(
      leagueName: 'الدوري الرياضي',
      tweetBody:
          'عندما يريد العالم أن ‪يتكلّم ‬ ، فهو يتحدّث بلغة يونيكود. تسجّل الآن لحضور المؤتمر الدولي العاشر ليونيكود (Unicode Conference)، الذي سيعقد في 10-12 آذار 1997 بمدينة مَايِنْتْس، ألمانيا. ',
      tweetOwner: 'account',
    ));
    tweets.add(Tweet(
      leagueName: 'الدوري الرياضي',
      tweetBody:
          'عندما يريد العالم أن ‪يتكلّم ‬ ، فهو يتحدّث بلغة يونيكود. تسجّل الآن لحضور المؤتمر الدولي العاشر ليونيكود (Unicode Conference)، الذي سيعقد في 10-12 آذار 1997 بمدينة مَايِنْتْس، ألمانيا. ',
      tweetOwner: 'account',
    ));
    tweets.add(Tweet(
      leagueName: 'الدوري الرياضي',
      tweetBody:
          'عندما يريد العالم أن ‪يتكلّم ‬ ، فهو يتحدّث بلغة يونيكود. تسجّل الآن لحضور المؤتمر الدولي العاشر ليونيكود (Unicode Conference)، الذي سيعقد في 10-12 آذار 1997 بمدينة مَايِنْتْس، ألمانيا. ',
      tweetOwner: 'account',
    ));
  }

  void initializePredictions() {
    predictions.add(PredictionModel(
        percentage: 30,
        team: Team(teamName: 'الاتحاد', teamLogo: Assets.clubLogo)));
    predictions.add(PredictionModel(
        percentage: 50,
        team: Team(teamName: 'الهلال', teamLogo: Assets.clubLogo)));
    predictions.add(PredictionModel(
        percentage: 20,
        team: Team(teamName: 'النهضه', teamLogo: Assets.clubLogo)));
  }
}
