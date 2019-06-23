import 'package:meta/meta.dart';
import 'package:unitice/model/post.dart';

class User {
  /// 현재 선택된 대학교.
  final String university;

  /// 현재 등록된 키워드.
  final List<String> keywords;

  /// 현재 저장된 북마크.
  final List<Post> bookmarks;

  User(
      {@required this.university,
      this.keywords = const <String>[],
      this.bookmarks = const <Post>[]});
}
