import 'package:unitice/model/category.dart';
import 'package:unitice/model/post.dart';

/// 대학교 파싱 모델을 추상화한 인터페이스.
abstract class UniversityType {
  /// 학교 이름.
  String name;

  /// 카테고리.
  List<Category> categories;

  /// Base URL.
  String baseUrl;

  /// 파싱에 필요하지만 무의미한 정보를 담는 불필요한 쿼리 스트링.
  String unnecessaryQueryString;

  /// 스크랩할 페이지 URL 구하기.
  String getPageUrl(Category category, int page, String query);

  /// 웹 뷰로 띄울 게시물 URL 구하기.
  String getPostUrl(Category category, String link);

  /// 게시물 가져오기.
  Future<List<Post>> requestPosts(Category category, int page, String query);

  /// 카테고리와 관련된 쿼리 스트링 구하기.
  String getCategoryQueryString(Category category);

  /// 페이지 번호와 관련된 쿼리 스트링 구하기.
  String getPageQueryString(int page);

  /// 검색 문자열과 관련된 쿼리 스트링 구하기.
  String getSearchQueryString(String query);
}