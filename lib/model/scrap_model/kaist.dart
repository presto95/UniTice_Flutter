import 'package:unitice/model/category.dart';
import 'package:unitice/model/post.dart';
import 'package:unitice/model/university_scrap_type.dart';
import 'package:unitice/service/scrap_service.dart';

class Kaist implements UniversityScrapType {
  @override
  String baseUrl = "https://www.kaist.ac.kr/_prog/_board/";

  @override
  List<Category> categories = [
    Category(id: "kaist_event", description: "알림사항"),
    Category(id: "kaist_students", description: "학사공지"),
    Category(id: "kr_events", description: "행사 안내"),
  ];

  @override
  String name = "KAIST";

  @override
  String unnecessaryQueryString = "index.php?";

  @override
  String getCategoryQueryString(Category category) {
    return "&code=${category.id}";
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
  Future<List<Post>> requestPosts(Category category, int page,
      [String query = ""]) async {
    List<Post> posts = [];
    final url = getPageUrl(category, page, query);
    final document = await ScrapService.instance.request(url);
    final rows = document.querySelectorAll("tbody > tr > td");
    final links = document.querySelectorAll("tbody > tr > td.title > a[href]");
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
        isNotice: isNotice,
      );
      posts.add(post);
    }
    return posts;
  }
}
