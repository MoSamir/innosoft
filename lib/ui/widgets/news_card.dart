import 'package:flutter/material.dart';
import 'package:innosoft/data_providers/models/NewsModel.dart';
import 'package:innosoft/resources/Assets.dart';

class NewsCard extends StatelessWidget {
  final NewsModel newsModel;

  final Function(NewsModel) onCardClick;

  NewsCard({this.newsModel, this.onCardClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  newsModel.imagePath,
                ),
                fit: BoxFit.fill,
              )),
              child: Align(
                alignment: AlignmentDirectional.bottomStart,
                child: GestureDetector(
                  onTap: () {
                    onCardClick(newsModel);
                    return;
                  },
                  child: Image.asset(Assets.newsCardIcon),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        newsModel.leagueName,
                        style: Assets.titles,
                      ),
                      Text(
                        newsModel.title,
                        maxLines: 2,
                        style: Assets.headlines,
                      ),
                    ],
                  ),
                  Text(newsModel.date, style: Assets.subTitles),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
