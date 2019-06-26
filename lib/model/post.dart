import 'package:meta/meta.dart';

/// 게시물을 나타낸 모델.
class Post {
  final int number;
  final String title;
  final String date;
  final String link;
  final String note;
  final bool isNotice;

  Post({
    @required this.number,
    @required this.title,
    @required this.date,
    @required this.link,
    @required this.isNotice,
    this.note = "",
  });

  Post.fromMap(Map<String, dynamic> jsonObject)
      : this.number = jsonObject["number"],
        this.title = jsonObject["title"],
        this.date = jsonObject["date"],
        this.link = jsonObject["link"],
        this.note = jsonObject["note"],
        this.isNotice = jsonObject["isNotice"] == 1 ? true : false;

  Map<String, dynamic> toMap() {
    return {
      "number": number,
      "title": title,
      "date": date,
      "link": link,
      "note": note,
      "isNotice": isNotice ? 1 : 0,
    };
  }
}
