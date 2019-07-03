import "package:flutter/material.dart";
import 'package:unitice/model/user.dart';

class EntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _presentMainPage(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
      ),
    );
  }

  void _presentMainPage(BuildContext context) async {
    final university = await User.university;
    if (university != null) {
      Navigator.of(context).pushReplacementNamed("/main");
    } else {
      Navigator.of(context).pushReplacementNamed("/start/registerUniversity");
    }
  }
}
