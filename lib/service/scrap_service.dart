import "dart:convert";
import "package:http/http.dart" as http;
import "package:html/parser.dart";
import "package:html/dom.dart";

class ScrapService {

  void initiate() async {
    try {
      final response = await http.get('https://www.seoultech.ac.kr/service/info/matters/?bidx=6112&bnum=6112&allboard=true&size=5');
      print(response.body);
      final document = parse(response.body);
      final links = document.querySelectorAll("div.wrap_list > tr.body_tr > td");
      print("--------------");
      links.forEach((link) {
        print(link.text);
      });
      //print(links);
    } catch (error) {
      print(error);
    }
  }
}