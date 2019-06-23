import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';

class RegisterUniversityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "학교 선택",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "공지를 받아볼 학교를 선택해 주세요.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "우리 학교가 목록에 없나요?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    FlatButton(
                      child: Text(
                        "우리에게 알려주세요!",
                      ),
                      onPressed: () {},
                    )
                  ],
                )
              ],
            ),
            Flexible(
              child: Container(
                child: CupertinoPicker.builder(
                  itemExtent: 30,
                  childCount: 50,
                  itemBuilder: (context, row) {
                    return Text("학교");
                  },
                  onSelectedItemChanged: (row) {},
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 16,
                right: 16,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: FlatButton(
                        child: Text(
                          "확인",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed("/start/registerKeyword");
                        },
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
