import 'package:meta/meta.dart';

/// 게시물을 나타낸 모델.
class Post {
  // Property

  /// 게시물 식별자.
  final String id;

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

  // Constructor

  Post(
      {@required this.id,
      @required this.number,
      @required this.title,
      @required this.date,
      @required this.link,
      this.note = ""});
}
