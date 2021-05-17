import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:innosoft/data_providers/models/NewsModel.dart';
import 'package:innosoft/resources/Assets.dart';
import 'package:innosoft/resources/LocalKeys.dart';
import 'package:innosoft/ui/screens/news_item_details_screen.dart';
import 'package:innosoft/ui/widgets/custom_appbar.dart';
import 'package:innosoft/ui/widgets/news_card.dart';

class MediaCenterScreen extends StatefulWidget {
  @override
  _MediaCenterScreenState createState() => _MediaCenterScreenState();
}

class _MediaCenterScreenState extends State<MediaCenterScreen>
    with SingleTickerProviderStateMixin {
  List<NewsModel> news = [];
  TabController tabController;

  @override
  void initState() {
    super.initState();
    initNewsList();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tabBar: TabBar(
          controller: tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 2,
          tabs: [
            Text((LocalKeys.NEWS_TAB).tr()),
            Text((LocalKeys.VIDEOS_TAB).tr()),
          ],
        ),
        isTransparent: false,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemCount: news.length,
        itemBuilder: (context, index) => NewsCard(
          newsModel: news[index],
          onCardClick: onCardClicked,
        ),
        shrinkWrap: true,
      ),
    );
  }

  void initNewsList() {
    news.add(NewsModel(
      date: 'يوليو 2018 8',
      leagueName: 'دوري الرياض',
      title: 'من الملاعب السعودية إلى منصة التتويج بكأس العالم..',
      imagePath: Assets.newsItem_1,
    ));
    news.add(NewsModel(
      date: 'يوليو 2018 8',
      leagueName: 'دوري الرياض',
      title: 'من الملاعب السعودية إلى منصة التتويج بكأس العالم..',
      imagePath: Assets.newsItem_2,
    ));
    news.add(NewsModel(
      date: 'يوليو 2018 8',
      leagueName: 'دوري الرياض',
      title: 'من الملاعب السعودية إلى منصة التتويج بكأس العالم..',
      imagePath: Assets.newsItem_3,
    ));
    news.add(NewsModel(
      date: 'يوليو 2018 8',
      leagueName: 'دوري الرياض',
      title: 'من الملاعب السعودية إلى منصة التتويج بكأس العالم..',
      imagePath: Assets.newsItem_3,
    ));
    news.add(NewsModel(
      date: 'يوليو 2018 8',
      leagueName: 'دوري الرياض',
      title: 'من الملاعب السعودية إلى منصة التتويج بكأس العالم..',
      imagePath: Assets.newsItem_2,
    ));
    news.add(NewsModel(
      date: 'يوليو 2018 8',
      leagueName: 'دوري الرياض',
      title: 'من الملاعب السعودية إلى منصة التتويج بكأس العالم..',
      imagePath: Assets.newsItem_1,
    ));
  }

  onCardClicked(NewsModel newsModel) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NewsItemDetailsScreen(
              newsModel: newsModel,
            )));
  }
}
