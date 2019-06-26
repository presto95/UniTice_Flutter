import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import 'package:unitice/page/entry_page.dart';
import 'package:unitice/page/main/main_page.dart';
import 'package:unitice/page/start/register_university_page.dart';
import 'package:unitice/page/main/bookmark_page.dart';
import 'package:unitice/page/main/search_page.dart';
import 'package:unitice/page/main/setting_page.dart';
import 'package:unitice/page/setting/change_keyword_page.dart';
import 'package:unitice/page/setting/change_university_page.dart';
import 'package:unitice/page/start/confirm_page.dart';
import 'package:unitice/page/start/register_keyword_page.dart';

final routeObserver = RouteObserver<PageRoute>();

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Color.fromARGB(255, 186, 59, 62),
      ),
      navigatorObservers: [routeObserver],
      home: EntryPage(),
      routes: {
        "/main": (context) => MainPage(),
        "/setting": (context) => SettingPage(),
        "/search": (context) => SearchPage(),
        "/bookmark": (context) => BookmarkPage(),
        "/start/registerUniversity": (context) => RegisterUniversityPage(),
        "/start/registerKeyword": (context) => RegisterKeywordPage(),
        "/start/confirm": (context) => ConfirmPage(),
        "/setting/changeKeyword": (context) => ChangeKeywordPage(),
        "/setting/changeUniversity": (context) => ChangeUniversityPage(),
      },
    );
  }
}
