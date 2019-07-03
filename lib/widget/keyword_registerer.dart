import "package:flutter/material.dart";
import 'package:unitice/common/keyword_register_mode.dart';
import 'package:unitice/model/register_model.dart';
import 'package:unitice/model/user.dart';
import 'package:unitice/widget/dismissible_background.dart';

class KeywordRegisterer extends StatefulWidget {
  final KeywordRegisterMode mode;

  KeywordRegisterer({@required this.mode});

  @override
  KeywordRegistererState createState() => KeywordRegistererState();
}

class KeywordRegistererState extends State<KeywordRegisterer> {
  final _textEditingController = TextEditingController();
  List<String> _keywords = [];
  String _currentKeyword = "";

  @override
  void initState() {
    super.initState();
    _fetchInitialKeywords();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildTextFieldRow(),
              _buildKeywordList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextFieldRow() {
    return Row(
      children: <Widget>[
        Flexible(
          child: TextField(
            controller: _textEditingController,
            autofocus: true,
            decoration: InputDecoration(hintText: "키워드 입력"),
            keyboardType: TextInputType.text,
            onChanged: (text) => _currentKeyword = text,
            onSubmitted: (text) async {
              await _registerKeyword(text);
              _initializeTextField();
            },
          ),
        ),
        SizedBox(width: 8),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () async {
            await _registerKeyword(_currentKeyword);
            _initializeTextField();
          },
        ),
      ],
    );
  }

  Widget _buildKeywordList() {
    if (_keywords.isEmpty) {
      return Expanded(
        child: Center(
          child: Text("등록된 키워드가 없습니다."),
        ),
      );
    }
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: _buildRegisteredKeywords(),
        ),
      ),
    );
  }

  List<Widget> _buildRegisteredKeywords() {
    return _keywords.map((keyword) {
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
            onDismissed: (_) async => _removeKeyword(keyword),
          ),
          SizedBox(height: 16),
        ],
      );
    }).toList();
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

  Future<void> _fetchInitialKeywords() async {
    List<String> keywords;
    switch (widget.mode) {
      case KeywordRegisterMode.register:
        keywords = RegisterModel.instance.keywords ?? [];
        break;
      case KeywordRegisterMode.change:
        keywords = await User.keywords;
        break;
    }
    setState(() {
      _keywords = keywords;
    });
  }

  Future<void> _registerKeyword(String keyword) async {
    final trimmedKeyword = keyword.trim();
    if (trimmedKeyword.isEmpty) {
      return;
    }
    if (_keywords.contains(trimmedKeyword)) {
      _showSnackBar("키워드가 중복되었습니다.");
      return;
    }
    if (_keywords.length >= 3) {
      _showSnackBar("3개 이상 등록할 수 없습니다.");
      return;
    }
    if (!_keywords.contains(trimmedKeyword)) {
      final newKeywords = List<String>.from(_keywords);
      newKeywords.add(trimmedKeyword);
      switch (widget.mode) {
        case KeywordRegisterMode.register:
          RegisterModel.instance.keywords = newKeywords;
          break;
        case KeywordRegisterMode.change:
          await User.setKeywords(newKeywords);
          break;
      }
      setState(() {
        _keywords = newKeywords;
      });
    }
  }

  Future<void> _removeKeyword(String keyword) async {
    final newKeywords = List<String>.from(_keywords);
    newKeywords.remove(keyword);
    switch (widget.mode) {
      case KeywordRegisterMode.register:
        RegisterModel.instance.keywords = newKeywords;
        break;
      case KeywordRegisterMode.change:
        await User.setKeywords(newKeywords);
        break;
    }
    setState(() {
      _keywords = newKeywords;
    });
  }

  void _showSnackBar(String title) {
    final snackBar = SnackBar(
      content: Text(title),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _initializeTextField() {
    _currentKeyword = "";
    _textEditingController.text = "";
  }
}
