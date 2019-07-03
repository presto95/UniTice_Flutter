import "package:http/http.dart" as http;
import "package:html/parser.dart";
import "package:html/dom.dart";

class ScrapService {
  static ScrapService instance = ScrapService();

  Future<Document> request(String url) async {
    try {
      final response = await http.get(url);
      final document = parse(response.body);
      return document;
    } catch (error) {
      throw error;
    }
  }
}
