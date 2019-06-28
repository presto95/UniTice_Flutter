import "package:flutter/material.dart";

class AppBarTitleText extends StatelessWidget {
  final String title;

  AppBarTitleText(this.title);

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
