import "package:flutter/material.dart";

class DismissibleBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          _buildBackground(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      padding: const EdgeInsets.only(right: 32),
      child: Text(
        "삭제",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    );
  }
}
