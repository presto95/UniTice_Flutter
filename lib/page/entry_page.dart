import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

class EntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _presentMainPage(context);
    return Container();
  }

  void _presentMainPage(BuildContext context) async {
    final preferences = await SharedPreferences.getInstance();
    if (preferences.getString("university") != null) {
      Navigator.of(context).pushReplacementNamed("/main");
    } else {
      Navigator.of(context).pushReplacementNamed("/start/registerUniversity");
    }
  }
}
