class NewsModel {
  String imagePath, leagueName, title, date;

  NewsModel({this.imagePath, this.leagueName, this.title, this.date});

  static NewsModel fromJson(Map<String, dynamic> singleNewsItemMap) {
    return NewsModel();
  }
}
