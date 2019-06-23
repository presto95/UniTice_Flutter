import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import 'package:unitice/page/main/main_page.dart';
import 'package:unitice/page/start/register_university_page.dart';
import 'package:unitice/pages/main/bookmark_page.dart';
import 'package:unitice/pages/main/search_page.dart';
import 'package:unitice/pages/main/setting_page.dart';
import 'package:unitice/pages/setting/change_keyword_page.dart';
import 'package:unitice/pages/setting/change_university_page.dart';
import 'package:unitice/pages/start/confirm_page.dart';
import 'package:unitice/pages/start/register_keyword_page.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Color.fromARGB(255, 186, 59, 62),
      ),
      routes: {
        "/": (context) => RegisterUniversityPage(),
        "/main": (context) => MainPage(),
        "/setting": (context) => SettingPage(),
        "/search": (context) => SearchPage(),
        "/bookmark": (context) => BookmarkPage(),
        "/start/selectUniversity": (context) => RegisterUniversityPage(),
        "/start/registerKeyword": (context) => RegisterKeywordPage(),
        "/start/confirm": (context) => ConfirmPage(),
        "/setting/changeKeyword": (context) => ChangeKeywordPage(),
        "/setting/changeUniversity": (context) => ChangeUniversityPage(),
      },
    );
  }
}
