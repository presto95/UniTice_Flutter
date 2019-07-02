import "package:flutter/material.dart";
import 'package:unitice/model/user.dart';
import 'package:unitice/widget/app_bar_title_text.dart';
import 'package:unitice/widget/dismissible_background.dart';

class ChangeKeywordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChangeKeywordPageState();
}

class _ChangeKeywordPageState extends State<ChangeKeywordPage> {
  final _textEditingController = TextEditingController();
  List<String> _keywords = [];
  String _currentKeyword = "";

  @override
  void initState() {
    super.initState();
    _fetchKeywords();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: AppBarTitleText("키워드 설정"),
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
                    Builder(
                      builder: (context) => _buildTextFieldRow(context),
                    ),
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
    return Row(
      children: <Widget>[
        Flexible(
          child: TextField(
            controller: _textEditingController,
            autofocus: true,
            decoration: InputDecoration(hintText: "키워드 입력"),
            keyboardType: TextInputType.text,
            onChanged: (text) => _currentKeyword = text,
            onSubmitted: (text) {
              _registerKeyword(context, text);
              _initializeTextField();
            },
          ),
        ),
        SizedBox(width: 8),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _registerKeyword(context, _currentKeyword);
            _initializeTextField();
          },
        ),
      ],
    );
  }

  Widget _buildKeywordsList() {
    if (_keywords.isEmpty) {
      return Expanded(child: Center(child: Text("등록된 키워드가 없습니다.")));
    }
    final registeredKeywords = _keywords.map((keyword) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Dismissible(
            key: Key(keyword),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildKeywordContainer(keyword),
              ],
            ),
            background: DismissibleBackground(),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                setState(() {
                  _keywords.remove(keyword);
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

  Widget _buildKeywordContainer(String keyword) {
    return Container(
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
    );
  }

  Future<void> _fetchKeywords() async {
    final keywords = await User.keywords;
    setState(() {
      _keywords = keywords;
    });
  }

  void _registerKeyword(BuildContext context, String keyword) {
    final trimmedText = keyword.trim();
    if (trimmedText.isEmpty) {
      return;
    }
    if (_keywords.contains(trimmedText)) {
      _showSnackBar(context, "키워드가 중복되었습니다.");
      return;
    }
    if (_keywords.length >= 3) {
      _showSnackBar(context, "3개 이상 등록할 수 없습니다.");
      return;
    }
    if (!_keywords.contains(trimmedText)) {
      User.setKeywords(_keywords);
      setState(() {
        _keywords.add(trimmedText);
      });
    }
  }

  void _showSnackBar(BuildContext context, String title) {
    final snackBar = SnackBar(
      content: Text(title),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _initializeTextField() {
    _currentKeyword = "";
    _textEditingController.text = null;
  }
}
