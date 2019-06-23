import "package:flutter/material.dart";
import 'package:unitice/helper/start_ui_helper.dart';
import 'package:unitice/widgets/start_button.dart';

class RegisterKeywordPage extends StatelessWidget with StartUiHelper {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            _buildPageInformationTexts(),
            Flexible(
              child: ListView(
                children: <Widget>[
                  Text("키워드"),
                ],
              ),
            ),
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
        buildTitleText("키워드 등록"),
        SizedBox(height: 8),
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
              onPressed: () =>
                  Navigator.of(context).pushNamed("/start/confirm"),
            ),
          ),
        ],
      ),
    );
  }
}
