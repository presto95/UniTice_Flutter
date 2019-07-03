import 'package:unitice/model/scrap_model/cnu.dart';
import 'package:unitice/model/scrap_model/kaist.dart';
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
      case University.kcu:
        return "KC대학교";
      case University.kangnam:
        return "강남대학교";
      case University.kangwon:
        return "강원대학교";
      case University.knu:
        return "경북대학교";
      case University.gsnu:
        return "경상대학교";
      case University.ks:
        return "경성대학교";
      case University.khu:
        return "경희대학교";
      case University.korea:
        return "고려대학교";
      case University.kw:
        return "광운대학교";
      case University.kookmin:
        return "국민대학교";
      case University.daejin:
        return "대진대학교";
      case University.duksung:
        return "덕성여자대학교";
      case University.dongguk:
        return "동국대학교";
      case University.dongduk:
        return "동덕여자대학교";
      case University.dsu:
        return "동신대학교";
      case University.mju:
        return "명지대학교";
      case University.mokpo:
        return "목포대학교";
      case University.pknu:
        return "부경대학교";
      case University.pusan:
        return "부산대학교";
      case University.syu:
        return "삼육대학교";
      case University.skuniv:
        return "서경대학교";
      case University.seoultech:
        return "서울과학기술대학교";
      case University.snue:
        return "서울교육대학교";
      case University.snu:
        return "서울대학교";
      case University.swu:
        return "서울여자대학교";
      case University.skhu:
        return "성공회대학교";
      case University.sungkyul:
        return "성결대학교";
      case University.skku:
        return "성균관대학교";
      case University.sungshin:
        return "성신여자대학교";
      case University.sejong:
        return "세종대학교";
      case University.sehan:
        return "세한대학교";
      case University.sookmyung:
        return "숙명여자대학교";
      case University.woosuk:
        return "우석대학교";
      case University.ewha:
        return "이화여자대학교";
      case University.jnu:
        return "전남대학교";
      case University.jbnu:
        return "전북대학교";
      case University.jejunu:
        return "제주대학교";
      case University.chongshin:
        return "총신대학교";
      case University.cnu:
        return "충남대학교";
      case University.chungbuk:
        return "충북대학교";
      case University.kpu:
        return "한국산업기술대학교";
      case University.karts:
        return "한국예술종합학교";
      case University.hufs:
        return "한국외국어대학교";
      case University.hansung:
        return "한성대학교";
      case University.hanyang:
        return "한양대학교";
      case University.hongik:
        return "홍익대학교";
      default:
        return null;
    }
  }

  static University getUniversity(String university) {
    switch (university) {
      case "KAIST":
        return University.kaist;
      case "KC대학교":
        return University.kcu;
      case "강남대학교":
        return University.kangnam;
      case "강원대학교":
        return University.kangwon;
      case "경북대학교":
        return University.knu;
      case "경상대학교":
        return University.gsnu;
      case "경성대학교":
        return University.ks;
      case "경희대학교":
        return University.khu;
      case "고려대학교":
        return University.korea;
      case "광운대학교":
        return University.kw;
      case "국민대학교":
        return University.kookmin;
      case "대진대학교":
        return University.daejin;
      case "덕성여자대학교":
        return University.duksung;
      case "동국대학교":
        return University.dongguk;
      case "동덕여자대학교":
        return University.dongduk;
      case "동신대학교":
        return University.dsu;
      case "명지대학교":
        return University.mju;
      case "목포대학교":
        return University.mokpo;
      case "부경대학교":
        return University.pknu;
      case "부산대학교":
        return University.pusan;
      case "삼육대학교":
        return University.syu;
      case "서경대학교":
        return University.skuniv;
      case "서울과학기술대학교":
        return University.seoultech;
      case "서울교육대학교":
        return University.snue;
      case "서울대학교":
        return University.snu;
      case "서울여자대학교":
        return University.swu;
      case "성공회대학교":
        return University.skhu;
      case "성결대학교":
        return University.sungkyul;
      case "성균관대학교":
        return University.skku;
      case "성신여자대학교":
        return University.sungshin;
      case "세종대학교":
        return University.sejong;
      case "세한대학교":
        return University.sehan;
      case "숙명여자대학교":
        return University.sookmyung;
      case "우석대학교":
        return University.woosuk;
      case "이화여자대학교":
        return University.ewha;
      case "전남대학교":
        return University.jnu;
      case "전북대학교":
        return University.jbnu;
      case "제주대학교":
        return University.jejunu;
      case "총신대학교":
        return University.chongshin;
      case "충남대학교":
        return University.cnu;
      case "충북대학교":
        return University.chungbuk;
      case "한국산업기술대학교":
        return University.kpu;
      case "한국예술종합학교":
        return University.karts;
      case "한국외국어대학교":
        return University.hufs;
      case "한성대학교":
        return University.hansung;
      case "한양대학교":
        return University.hanyang;
      case "홍익대학교":
        return University.hongik;
      default:
        return null;
    }
  }

  static UniversityScrapType getScrapModel(University university) {
    switch (university) {
      case University.kaist:
        return Kaist();
      case University.kcu:
        break;
      case University.kangnam:
        break;
      case University.kangwon:
        break;
      case University.knu:
        break;
      case University.gsnu:
        break;
      case University.ks:
        break;
      case University.khu:
        break;
      case University.korea:
        break;
      case University.kw:
        break;
      case University.kookmin:
        break;
      case University.daejin:
        break;
      case University.duksung:
        break;
      case University.dongguk:
        break;
      case University.dongduk:
        break;
      case University.dsu:
        break;
      case University.mju:
        break;
      case University.mokpo:
        break;
      case University.pknu:
        break;
      case University.pusan:
        break;
      case University.syu:
        break;
      case University.skuniv:
        break;
      case University.seoultech:
        return Seoultech();
      case University.snue:
        break;
      case University.snu:
        break;
      case University.swu:
        break;
      case University.skhu:
        break;
      case University.sungkyul:
        break;
      case University.skku:
        break;
      case University.sungshin:
        break;
      case University.sejong:
        break;
      case University.sehan:
        break;
      case University.sookmyung:
        break;
      case University.woosuk:
        break;
      case University.ewha:
        break;
      case University.jnu:
        break;
      case University.jbnu:
        break;
      case University.jejunu:
        break;
      case University.chongshin:
        break;
      case University.cnu:
        return Cnu();
      case University.chungbuk:
        break;
      case University.kpu:
        break;
      case University.karts:
        break;
      case University.hufs:
        break;
      case University.hansung:
        break;
      case University.hanyang:
        break;
      case University.hongik:
        break;
      default:
        return null;
    }
  }
}
