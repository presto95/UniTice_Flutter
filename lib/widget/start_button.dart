import "package:flutter/material.dart";

class StartButton extends StatelessWidget {
  final StartButtonType type;
  final VoidCallback onPressed;

  StartButton({this.type, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final String text = type == StartButtonType.confirm ? "확인" : "뒤로";
    final Color borderColor =
        type == StartButtonType.confirm ? Colors.blue : Colors.red;
    return Container(
      child: FlatButton(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: onPressed,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          style: BorderStyle.solid,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

enum StartButtonType { confirm, back }
