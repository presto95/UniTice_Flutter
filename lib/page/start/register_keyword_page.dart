import "package:flutter/material.dart";
import 'package:unitice/common/keyword_register_mode.dart';
import 'package:unitice/common/start_button_type.dart';
import 'package:unitice/helper/start_ui_helper.dart';
import 'package:unitice/widget/keyword_registerer.dart';
import 'package:unitice/widget/start_button.dart';

class RegisterKeywordPage extends StatelessWidget with StartUiHelper {
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
                child: KeywordRegisterer(
                  mode: KeywordRegisterMode.register,
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
                Navigator.of(context).pushNamed("/start/confirm");
              },
            ),
          ),
        ],
      ),
    );
  }
}
