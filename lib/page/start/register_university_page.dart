import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:unitice/common/start_button_type.dart';
import 'package:unitice/helper/start_ui_helper.dart';
import 'package:unitice/model/register_model.dart';
import 'package:unitice/model/university_helper.dart';
import 'package:unitice/widget/start_button.dart';
import 'package:unitice/widget/university_picker.dart';
import "package:url_launcher/url_launcher.dart";

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
            Builder(builder: (context) => _buildPageInformationTexts(context)),
            _buildUniversityPickerView(),
            Builder(builder: (context) => _buildButtonContainer(context)),
          ],
        ),
      ),
    );
  }

  // UI

  Widget _buildPageInformationTexts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildTitleText("학교 선택"),
        SizedBox(height: 16),
        buildSubtitleText("공지를 받아볼 학교를 선택해 주세요."),
        SizedBox(height: 8),
        Row(
          children: <Widget>[
            buildSubtitleText("우리 학교가 목록에 없나요?"),
            SizedBox(width: 8),
            GestureDetector(
              onTap: () => _makeEmailForm(context),
              child: Text(
                "우리에게 알려주세요!",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
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

  Widget _buildButtonContainer(BuildContext context) {
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

  // Non-UI

  void _registerUniversity(BuildContext context) {
    if (_selectedUniversity != null) {
      RegisterModel.instance.university = _selectedUniversity;
      Navigator.of(context).pushNamed("/start/registerKeyword");
    } else {
      final snackBar = SnackBar(
        content: Text("학교를 선택하세요."),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  void _makeEmailForm(BuildContext context) async {
    final url =
        "mailto:" + "yoohan95@gmail.com" + "?subject=[다연결] 우리 학교가 목록에 없어요.";
    final canLaunchMail = await canLaunch(url);
    if (canLaunchMail) {
      await launch(url);
    } else {
      final snackBar = SnackBar(
        content: Text("메일 앱을 열 수 없습니다."),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}
