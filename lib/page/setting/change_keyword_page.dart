import "package:flutter/material.dart";
import 'package:unitice/widget/app_bar_title.dart';

class ChangeKeywordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChangeKeywordPageState();
}

class _ChangeKeywordPageState extends State<ChangeKeywordPage> {
  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle("키워드 설정"),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      labelText: "키워드 입력",
                    ),
                  ),
                ),
                Container(
                  child: FlatButton(
                    child: Text("등록"),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[],
              ),
            )
          ],
        ),
      ),
    );
  }
}
