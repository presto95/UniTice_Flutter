import 'package:unitice/model/category.dart';
import 'package:unitice/model/post.dart';

abstract class UniversityScrapType {
  String name;
  List<Category> categories;
  String baseUrl;
  String unnecessaryQueryString;
  String getPageUrl(Category category, int page, String query);
  String getPostUrl(Category category, String link);
  String getCategoryQueryString(Category category);
  String getPageQueryString(int page);
  String getSearchQueryString(String query);
  Future<List<Post>> requestPosts(Category category, int page, String query);
}
