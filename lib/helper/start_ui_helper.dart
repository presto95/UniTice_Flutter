import "package:flutter/material.dart";

mixin StartUiHelper {
  Widget buildTitleText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildSubtitleText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
