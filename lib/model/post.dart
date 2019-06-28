import 'package:meta/meta.dart';

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

  Post.fromMap(Map<String, dynamic> map)
      : this.number = map["number"],
        this.title = map["title"],
        this.date = map["date"],
        this.link = map["link"],
        this.note = map["note"],
        this.isNotice = map["isNotice"] == 1 ? true : false;

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
