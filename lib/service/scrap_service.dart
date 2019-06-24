import "dart:convert";
import "package:http/http.dart" as http;
import "package:html/parser.dart";
import "package:html/dom.dart";

class ScrapService {

  void initiate() async {
    try {
      final response = await http.get('http://www.seoultech.ac.kr/service/info/notice/');
      print(response);
    } catch (error) {
      print(error);
    }
  }
}