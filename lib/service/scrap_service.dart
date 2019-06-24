import "package:http/http.dart" as http;
import "package:html/parser.dart";
import "package:html/dom.dart";

class ScrapService {
  static ScrapService shared = ScrapService();

  Future<Document> request(String url) async {
    final response = await http.get(url);
    final document = parse(response.body);
    return document;
  }
}
