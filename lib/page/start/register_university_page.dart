import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:unitice/helper/start_ui_helper.dart';
import 'package:unitice/model/register_model.dart';
import 'package:unitice/model/university_helper.dart';
import 'package:unitice/widget/start_button.dart';

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
              onPressed: _makeEmailForm,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUniversityListView() {
    final items = UniversityHelper.universityNames;
    return Flexible(
      child: Container(
        child: CupertinoPicker.builder(
          useMagnifier: true,
          magnification: 1.2,
          backgroundColor: Colors.transparent,
          itemExtent: 44,
          childCount: items.length,
          itemBuilder: (context, row) {
            return Center(
              child: Text(
                items[row],
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            );
          },
          onSelectedItemChanged: (row) {
            RegisterModel.shared.university = items[row];
          },
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

  void _makeEmailForm() {
    final email = Email(
                  subject: "[다연결] 우리 학교가 목록에 없어요.",
                  recipients: const ["yoohan95@gmail.com"],
                );
                FlutterEmailSender.send(email).then((_) {});
  }
}
