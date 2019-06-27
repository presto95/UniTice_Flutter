import 'package:unitice/model/category.dart';
import 'package:unitice/model/post.dart';
import 'package:unitice/model/university_scrap_type.dart';
import 'package:unitice/service/scrap_service.dart';

class Seoultech implements UniversityScrapType {
  @override
  String baseUrl = "https://www.seoultech.ac.kr/service/info/";

  @override
  List<Category> categories = [
    Category(id: "notice", description: "대학공지사항"),
    Category(id: "matters", description: "학사공지"),
    Category(id: "janghak", description: "장학공지"),
    Category(id: "graduate", description: "대학원공지"),
    // Category(id: "bid", description: "대학입찰"),
    // Category(id: "recruite", description: "채용정보"),
    // Category(id: "committee", description: "등록금심의위원회"),
    // Category(id: "budgetcomm", description: "재정위원회"),
  ];

  @override
  String name = "서울과학기술대학교";

  @override
  String unnecessaryQueryString = "";

  @override
  String getCategoryQueryString(Category category) {
    String result = category.id;
    switch (category.id) {
      case "notice":
        result += "/?bidx=4691&bnum=4691&allboard=false&size=9";
        break;
      case "matters":
        result += "/?bidx=6112&bnum=6112&allboard=true&size=5";
        break;
      case "janghak":
        result += "/?bidx=5233&bnum=5233&allboard=true&size=5";
        break;
      case "graduate":
        result += "/?bidx=56589&bnum=56589&allboard=false&size=9";
        break;
      case "bid":
        result += "/?bidx=4694&bnum=4694&allboard=true&size=9";
        break;
      case "recruit":
        result += "/?bidx=3601&bnum=3601&allboard=false&size=10";
        break;
      case "committee":
        result += "/?bidx=3606&bnum=3606&allboard=false&size=15";
        break;
      case "budgetcomm":
        result += "/?bidx=56473&bnum=56473&allboard=false&size=15";
        break;
    }
    return result;
  }

  @override
  String getPageQueryString(int page) {
    return "&page=$page";
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
    return baseUrl + category.id + link;
  }

  @override
  String getSearchQueryString(String query) {
    return "&searchtype=1&searchtext=$query";
  }

  @override
  Future<List<Post>> requestPosts(Category category, int page,
      [String query = ""]) async {
    List<Post> posts = [];
    final url = getPageUrl(category, page, query);
    final document = await ScrapService.shared.request(url);
    final rows = document.querySelectorAll("tr.body_tr > td");
    final links = document.querySelectorAll("td.tit > a[href]");
    final numberOfLinks = links.length;
    for (int index = 0; index < numberOfLinks; ++index) {
      final referenceIndex = index * 6;
      final number = rows[referenceIndex].text.trim();
      final title = rows[referenceIndex + 1].text.trim();
      final date = rows[referenceIndex + 4].text.trim();
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
