import "package:flutter/material.dart";
import 'package:unitice/model/user.dart';
import 'package:unitice/widget/app_bar_title.dart';

class ChangeKeywordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChangeKeywordPageState();
}

class _ChangeKeywordPageState extends State<ChangeKeywordPage> {
  List<String> keywords;
  String currentKeyword;

  @override
  void initState() {
    super.initState();
    keywords = [];
    currentKeyword = "";
    _fetchKeywords();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: AppBarTitle("키워드 설정"),
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Builder(builder: (context) => _buildTextFieldRow(context)),
                    _buildKeywordsList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldRow(BuildContext context) {
    final textEditingController = TextEditingController();
    return Row(
      children: <Widget>[
        Flexible(
          child: TextField(
            controller: textEditingController,
            autofocus: true,
            decoration: InputDecoration(
              labelText: "키워드 입력",
            ),
            keyboardType: TextInputType.text,
            onChanged: (text) => currentKeyword = text,
            onSubmitted: (text) {
              _registerKeyword(context, text);
              currentKeyword = "";
              textEditingController.text = null;
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColor,
              style: BorderStyle.solid,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: FlatButton(
            child: Text("등록"),
            onPressed: () {
              _registerKeyword(context, currentKeyword);
              currentKeyword = "";
              textEditingController.text = null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildKeywordsList() {
    final registeredKeywords = keywords.map((keyword) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Dismissible(
            key: Key(keyword),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    keyword,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            background: Container(
              color: Colors.red,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Container(
                    padding: EdgeInsets.only(right: 32),
                    child: Text(
                      "삭제",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                setState(() {
                  keywords.remove(keyword);
                });
              }
            },
          ),
          SizedBox(height: 16),
        ],
      );
    }).toList();
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: registeredKeywords,
        ),
      ),
    );
  }

  void _fetchKeywords() async {
    final keywords = await User.keywords;
    setState(() {
      this.keywords = keywords;
    });
  }

  void _registerKeyword(BuildContext context, String keyword) async {
    final trimmedText = keyword.trim();
    if (trimmedText.isEmpty) {
      return;
    }
    if (keywords.contains(trimmedText)) {
      final snackBar = SnackBar(content: Text("키워드가 중복되었습니다."));
      Scaffold.of(context).showSnackBar(snackBar);
      return;
    }
    if (keywords.length >= 3) {
      final snackBar = SnackBar(content: Text("3개 이상 등록할 수 없습니다."));
      Scaffold.of(context).showSnackBar(snackBar);
      return;
    }
    if (!keywords.contains(trimmedText)) {
      setState(() {
        keywords.add(trimmedText);
      });
      await User.setKeywords(keywords);
    }
  }
}
