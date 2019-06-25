import 'package:meta/meta.dart';

/// 게시물을 나타낸 모델.
class Post {
  /// 게시물 번호.
  final int number;

  /// 게시물 제목.
  final String title;

  /// 게시물 게시 날짜.
  final String date;

  /// 게시물 세부 링크.
  final String link;

  /// 게시물 기타 정보.
  final String note;

  /// 공지사항인지 아닌지.
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
      : this.number = int.parse(jsonObject["number"]),
        this.title = jsonObject["title"],
        this.date = jsonObject["date"],
        this.link = jsonObject["link"],
        this.note = jsonObject["note"],
        this.isNotice = jsonObject["isNotice"];

  Map<String, dynamic> toMap() {
    return {
      "number": number,
      "title": title,
      "date": date,
      "link": link,
      "note": note,
      "isNotice": isNotice,
    };
  }
}
