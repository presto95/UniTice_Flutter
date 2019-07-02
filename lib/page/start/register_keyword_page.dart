import "package:flutter/material.dart";
import 'package:unitice/helper/start_ui_helper.dart';
import 'package:unitice/model/register_model.dart';
import 'package:unitice/widget/dismissible_background.dart';
import 'package:unitice/widget/start_button.dart';

class RegisterKeywordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterKeywordPageState();
}

class _RegisterKeywordPageState extends State<RegisterKeywordPage>
    with StartUiHelper {
  final _textEditingController = TextEditingController();
  List<String> _keywords = [];
  String _currentKeyword = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 40),
              _buildPageInformationTexts(),
              SizedBox(height: 16),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Builder(
                      builder: (context) => _buildTextFieldRow(context),
                    ),
                    _buildKeywordsList()
                  ],
                ),
              ),
              _buildButtonsContainer(context),
            ],
          ),
        ),
      ),
    );
  }

  // UI

  Widget _buildPageInformationTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildTitleText("키워드 등록"),
        SizedBox(height: 16),
        buildSubtitleText("관심 있는 키워드를 등록하세요."),
        buildSubtitleText("최대 3개까지 등록할 수 있습니다."),
      ],
    );
  }

  Widget _buildTextFieldRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: TextField(
            controller: _textEditingController,
            autofocus: true,
            decoration: InputDecoration(labelText: "키워드 입력"),
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
            onDismissed: (_) {
              setState(() {
                _keywords.remove(keyword);
              });
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

  Widget _buildButtonsContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        children: <Widget>[
          StartButton(
            type: StartButtonType.back,
            onPressed: () => Navigator.of(context).pop(),
          ),
          SizedBox(width: 16),
          Expanded(
            child: StartButton(
              type: StartButtonType.confirm,
              onPressed: () {
                RegisterModel.instance.keywords = _keywords;
                Navigator.of(context).pushNamed("/start/confirm");
              },
            ),
          ),
        ],
      ),
    );
  }

  // Non-UI

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
