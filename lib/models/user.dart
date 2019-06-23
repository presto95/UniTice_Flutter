import 'package:meta/meta.dart';
import 'package:unitice/models/post.dart';

class User {
  final String university;

  final List<String> keywords;

  final List<Post> bookmarks;

  User(
      {@required this.university,
      this.keywords = const <String>[],
      this.bookmarks = const <Post>[]});
}
