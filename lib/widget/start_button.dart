import "package:flutter/material.dart";
import 'package:unitice/common/start_button_type.dart';

class StartButton extends StatelessWidget {
  final StartButtonType type;
  final VoidCallback onPressed;

  StartButton({@required this.type, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final text = type == StartButtonType.confirm ? "확인" : "뒤로";
    final borderColor =
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
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
