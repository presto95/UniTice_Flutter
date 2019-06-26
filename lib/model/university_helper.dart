import 'package:unitice/model/scrap_model/cnu.dart';
import 'package:unitice/model/scrap_model/seoultech.dart';
import 'package:unitice/model/university.dart';
import 'package:unitice/model/university_scrap_type.dart';

class UniversityHelper {
  static List<String> universityNames =
      University.values.map((university) => getName(university)).toList();

  static String getName(University university) {
    switch (university) {
      case University.kaist:
        return "KAIST";
        break;
      case University.kcu:
        return "KC대학교";
        break;
      case University.kangnam:
        return "강남대학교";
        break;
      case University.kangwon:
        return "강원대학교";
        break;
      case University.knu:
        return "경북대학교";
        break;
      case University.gsnu:
        return "경상대학교";
        break;
      case University.ks:
        return "경성대학교";
        break;
      case University.khu:
        return "경희대학교";
        break;
      case University.korea:
        return "고려대학교";
        break;
      case University.kw:
        return "광운대학교";
        break;
      case University.kookmin:
        return "국민대학교";
        break;
      case University.daejin:
        return "대진대학교";
        break;
      case University.duksung:
        return "덕성여자대학교";
        break;
      case University.dongguk:
        return "동국대학교";
        break;
      case University.dongduk:
        return "동덕여자대학교";
        break;
      case University.dsu:
        return "동신대학교";
        break;
      case University.mju:
        return "명지대학교";
        break;
      case University.mokpo:
        return "목포대학교";
        break;
      case University.pknu:
        return "부경대학교";
        break;
      case University.pusan:
        return "부산대학교";
        break;
      case University.syu:
        return "삼육대학교";
        break;
      case University.skuniv:
        return "서경대학교";
        break;
      case University.seoultech:
        return "서울과학기술대학교";
        break;
      case University.snue:
        return "서울교육대학교";
        break;
      case University.snu:
        return "서울대학교";
        break;
      case University.swu:
        return "서울여자대학교";
        break;
      case University.skhu:
        return "성공회대학교";
        break;
      case University.sungkyul:
        return "성결대학교";
        break;
      case University.skku:
        return "성균관대학교";
        break;
      case University.sungshin:
        return "성신여자대학교";
        break;
      case University.sejong:
        return "세종대학교";
        break;
      case University.sehan:
        return "세한대학교";
        break;
      case University.sookmyung:
        return "숙명여자대학교";
        break;
      case University.woosuk:
        return "우석대학교";
        break;
      case University.ewha:
        return "이화여자대학교";
        break;
      case University.jnu:
        return "전남대학교";
        break;
      case University.jbnu:
        return "전북대학교";
        break;
      case University.jejunu:
        return "제주대학교";
        break;
      case University.chongshin:
        return "총신대학교";
        break;
      case University.cnu:
        return "충남대학교";
        break;
      case University.chungbuk:
        return "충북대학교";
        break;
      case University.kpu:
        return "한국산업기술대학교";
        break;
      case University.karts:
        return "한국예술종합학교";
        break;
      case University.hufs:
        return "한국외국어대학교";
        break;
      case University.hansung:
        return "한성대학교";
        break;
      case University.hanyang:
        return "한양대학교";
        break;
      case University.hongik:
        return "홍익대학교";
        break;
      default:
        return "";
        break;
    }
  }

  static University getUniversity(String university) {
    switch (university) {
      case "KAIST":
        break;
      case "KC대학교":
        break;
      case "강남대학교":
        break;
      case "강원대학교":
        break;
      case "경북대학교":
        break;
      case "경상대학교":
        break;
      case "경성대학교":
        break;
      case "경희대학교":
        break;
      case "고려대학교":
        break;
      case "광운대학교":
        break;
      case "국민대학교":
        break;
      case "대진대학교":
        break;
      case "덕성여자대학교":
        break;
      case "동국대학교":
        break;
      case "동덕여자대학교":
        break;
      case "동신대학교":
        break;
      case "명지대학교":
        break;
      case "목포대학교":
        break;
      case "부경대학교":
        break;
      case "부산대학교":
        break;
      case "삼육대학교":
        break;
      case "서경대학교":
        break;
      case "서울과학기술대학교":
        return University.seoultech;
        break;
      case "서울교육대학교":
        break;
      case "서울대학교":
        break;
      case "서울여자대학교":
        break;
      case "성공회대학교":
        break;
      case "성결대학교":
        break;
      case "성균관대학교":
        break;
      case "성신여자대학교":
        break;
      case "세종대학교":
        break;
      case "세한대학교":
        break;
      case "숙명여자대학교":
        break;
      case "우석대학교":
        break;
      case "이화여자대학교":
        break;
      case "전남대학교":
        break;
      case "전북대학교":
        break;
      case "제주대학교":
        break;
      case "총신대학교":
        break;
      case "충남대학교":
        return University.cnu;
        break;
      case "충북대학교":
        break;
      case "한국산업기술대학교":
        break;
      case "한국예술종합학교":
        break;
      case "한국외국어대학교":
        break;
      case "한성대학교":
        break;
      case "한양대학교":
        break;
      case "홍익대학교":
        break;
      default:
        break;
    }
    return null;
  }

  static UniversityScrapType getScrapModel(University university) {
    switch (university) {
      case University.kaist:
        // TODO: Handle this case.
        break;
      case University.kcu:
        // TODO: Handle this case.
        break;
      case University.kangnam:
        // TODO: Handle this case.
        break;
      case University.kangwon:
        // TODO: Handle this case.
        break;
      case University.knu:
        // TODO: Handle this case.
        break;
      case University.gsnu:
        // TODO: Handle this case.
        break;
      case University.ks:
        // TODO: Handle this case.
        break;
      case University.khu:
        // TODO: Handle this case.
        break;
      case University.korea:
        // TODO: Handle this case.
        break;
      case University.kw:
        // TODO: Handle this case.
        break;
      case University.kookmin:
        // TODO: Handle this case.
        break;
      case University.daejin:
        // TODO: Handle this case.
        break;
      case University.duksung:
        // TODO: Handle this case.
        break;
      case University.dongguk:
        // TODO: Handle this case.
        break;
      case University.dongduk:
        // TODO: Handle this case.
        break;
      case University.dsu:
        // TODO: Handle this case.
        break;
      case University.mju:
        // TODO: Handle this case.
        break;
      case University.mokpo:
        // TODO: Handle this case.
        break;
      case University.pknu:
        // TODO: Handle this case.
        break;
      case University.pusan:
        // TODO: Handle this case.
        break;
      case University.syu:
        // TODO: Handle this case.
        break;
      case University.skuniv:
        // TODO: Handle this case.
        break;
      case University.seoultech:
        return Seoultech();
        break;
      case University.snue:
        // TODO: Handle this case.
        break;
      case University.snu:
        // TODO: Handle this case.
        break;
      case University.swu:
        // TODO: Handle this case.
        break;
      case University.skhu:
        // TODO: Handle this case.
        break;
      case University.sungkyul:
        // TODO: Handle this case.
        break;
      case University.skku:
        // TODO: Handle this case.
        break;
      case University.sungshin:
        // TODO: Handle this case.
        break;
      case University.sejong:
        // TODO: Handle this case.
        break;
      case University.sehan:
        // TODO: Handle this case.
        break;
      case University.sookmyung:
        // TODO: Handle this case.
        break;
      case University.woosuk:
        // TODO: Handle this case.
        break;
      case University.ewha:
        // TODO: Handle this case.
        break;
      case University.jnu:
        // TODO: Handle this case.
        break;
      case University.jbnu:
        // TODO: Handle this case.
        break;
      case University.jejunu:
        // TODO: Handle this case.
        break;
      case University.chongshin:
        // TODO: Handle this case.
        break;
      case University.cnu:
        return Cnu();
        break;
      case University.chungbuk:
        // TODO: Handle this case.
        break;
      case University.kpu:
        // TODO: Handle this case.
        break;
      case University.karts:
        // TODO: Handle this case.
        break;
      case University.hufs:
        // TODO: Handle this case.
        break;
      case University.hansung:
        // TODO: Handle this case.
        break;
      case University.hanyang:
        // TODO: Handle this case.
        break;
      case University.hongik:
        // TODO: Handle this case.
        break;
    }
    return null;
  }
}
