import 'package:unitice/model/category.dart';
import 'package:unitice/model/post.dart';
import 'package:unitice/model/university_scrap_type.dart';
import 'package:unitice/service/scrap_service.dart';

class Cnu implements UniversityScrapType {
  @override
  String baseUrl = "http://plus.cnu.ac.kr/_prog/_board/";

  @override
  List<Category> categories = [
    Category(id: "0701", description: "새소식"),
    Category(id: "0702", description: "학사정보"),
    Category(id: "0704", description: "교육정보"),
    Category(id: "0709", description: "사업단 창업ㆍ교육"),
  ];

  @override
  String name = "충남대학교";

  @override
  String unnecessaryQueryString = "?site_dvs_cd=kr&site_dvs=&ntt_tag=";

  @override
  String getCategoryQueryString(Category category) {
    return "&menu_dvs_cd=${category.id}&code=sub07_${category.id}";
  }

  @override
  String getPageQueryString(int page) {
    return "&GotoPage=$page";
  }

  @override
  String getPageUrl(Category category, int page, String query) {
    return baseUrl +
        unnecessaryQueryString +
        getCategoryQueryString(category) +
        getPageQueryString(page) +
        getSearchQueryString(query);
  }

  @override
  String getPostUrl(Category category, String link) {
    return baseUrl + link;
  }

  @override
  String getSearchQueryString(String query) {
    return "&skey=title&sval=$query";
  }

  @override
  Future<List<Post>> requestPosts(
      Category category, int page, String query) async {
    List<Post> posts = [];
    final url = getPageUrl(category, page, query);
    try {
      final document = await ScrapService.shared.request(url);
      final rows = document.querySelectorAll("tbody > td");
      final links = document.querySelectorAll("tbody > td.title > a[href]");
      final numberOfLinks = links.length;
      for (int index = 0; index < numberOfLinks; ++index) {
        final referenceIndex = index * 6;
        final number = rows[referenceIndex].text.trim();
        final title = rows[referenceIndex + 1].text.trim();
        final date = rows[referenceIndex + 3].text.trim();
        final link = links[index].attributes["href"].trim();
        final isNotice = number.isEmpty ? true : false;
        final post = Post(
            number: number.isEmpty ? 0 : int.parse(number),
            title: title,
            date: date,
            link: link,
            isNotice: isNotice);
        posts.add(post);
      }
      return posts;
    } catch (error) {
      throw error;
    }
  }
}
