import "package:flutter/material.dart";

class AppBarTitle extends StatelessWidget {
  final String title;

  AppBarTitle({this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
