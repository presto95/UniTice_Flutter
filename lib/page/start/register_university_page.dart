import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:unitice/helper/start_ui_helper.dart';
import 'package:unitice/widgets/start_button.dart';

class RegisterUniversityPage extends StatelessWidget with StartUiHelper {
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
            _buildUniversityListView(),
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
        buildTitleText("학교 선택"),
        SizedBox(height: 8),
        buildSubtitleText("공지를 받아볼 학교를 선택해 주세요."),
        Row(
          children: <Widget>[
            buildSubtitleText("우리 학교가 목록에 없나요?"),
            FlatButton(
              child: Text("우리에게 알려주세요!"),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUniversityListView() {
    return Flexible(
      child: Container(
        child: CupertinoPicker.builder(
          backgroundColor: Colors.transparent,
          itemExtent: 44,
          childCount: 50,
          itemBuilder: (context, row) {
            return Center(child: Text("학교"));
          },
          onSelectedItemChanged: (row) {},
        ),
      ),
    );
  }

  Widget _buildButtonsContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: StartButton(
              type: StartButtonType.confirm,
              onPressed: () =>
                  Navigator.of(context).pushNamed("/start/registerKeyword"),
            ),
          ),
        ],
      ),
    );
  }
}
