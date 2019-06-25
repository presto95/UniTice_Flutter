import "package:flutter/material.dart";
import 'package:unitice/helper/start_ui_helper.dart';
import 'package:unitice/model/register_model.dart';
import 'package:unitice/model/user.dart';
import 'package:unitice/widget/start_button.dart';

class ConfirmPage extends StatelessWidget with StartUiHelper {
  final university = RegisterModel.shared.university;
  final keywords = RegisterModel.shared.keywords;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 40),
            _buildPageInformationTexts(),
            _buildPresentationContainer(),
            _buildButtonsContainer(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPageInformationTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildTitleText("초기 설정 완료"),
        SizedBox(height: 8),
        buildSubtitleText("등록한 정보를 확인해 주세요."),
        buildSubtitleText("나중에 수정할 수 있습니다."),
      ],
    );
  }

  Widget _buildPresentationContainer() {
    final presentingKeywords = keywords.isEmpty ? "없음" : keywords.toString();
    return Flexible(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                _buildContentTitleText("학교"),
                SizedBox(height: 8),
                _buildContentItemText(university),
              ],
            ),
            Column(
              children: <Widget>[
                _buildContentTitleText("키워드"),
                SizedBox(height: 8),
                _buildContentItemText(presentingKeywords),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentTitleText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildContentItemText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
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
                _saveInitialInfo().then((_) {
                  Navigator.of(context).pushReplacementNamed("/main");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveInitialInfo() async {
    await User.setUniversity(university);
    await User.setKeywords(keywords);
  }
}
