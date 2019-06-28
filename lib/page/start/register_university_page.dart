import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:unitice/helper/start_ui_helper.dart';
import 'package:unitice/model/register_model.dart';
import 'package:unitice/model/university_helper.dart';
import 'package:unitice/widget/start_button.dart';
import 'package:unitice/widget/university_picker.dart';

class RegisterUniversityPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterUniversityPageState();
}

class _RegisterUniversityPageState extends State<RegisterUniversityPage>
    with StartUiHelper {
  String _selectedUniversity;

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
            _buildUniversityPickerView(),
            Builder(builder: (context) => _buildButtonsContainer(context)),
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

  Widget _buildUniversityPickerView() {
    final items = UniversityHelper.universityNames;
    return Flexible(
      child: UniversityPicker(
        universityNames: items,
        onSelectedUniversityChanged: (name) => _selectedUniversity = name,
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
              onPressed: () => _registerUniversity(context),
            ),
          ),
        ],
      ),
    );
  }

  void _registerUniversity(BuildContext context) {
    if (_selectedUniversity == null) {
      final snackBar = SnackBar(
        content: Text("학교를 선택하세요."),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      RegisterModel.shared.university = _selectedUniversity;
      Navigator.of(context).pushNamed("/start/registerKeyword");
    }
  }

  void _makeEmailForm() {
    final email = Email(
      subject: "[다연결] 우리 학교가 목록에 없어요.",
      recipients: const ["yoohan95@gmail.com"],
    );
    FlutterEmailSender.send(email);
  }
}
