import "package:flutter/material.dart";
import "package:flutter_email_sender/flutter_email_sender.dart";
import 'package:unitice/widget/app_bar_title.dart';
import 'package:unitice/widget/notice_visibility_list_tile.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(title: "설정"),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              NoticeVisibilityListTile(),
              Divider(),
              _buildSecondSection(context),
              Divider(),
              _buildThirdSection(),
              Divider(),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSecondSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildListTileWithDisclosureIndicator("학교 변경",
            () => Navigator.of(context).pushNamed("/setting/changeUniversity")),
        _buildListTileWithDisclosureIndicator("키워드 설정",
            () => Navigator.of(context).pushNamed("/setting/changeKeyword")),
        _buildListTileWithDisclosureIndicator(
          "알림 설정",
          () {},
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            "알림이 활성화 / 비활성화되어 있습니다.",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildThirdSection() {
    return Column(
      children: <Widget>[
        _buildListTileWithDisclosureIndicator(
          "문의하기",
          _makeEmailForm,
        ),
        _buildListTileWithDisclosureIndicator(
          "앱 평가하기",
          () {},
        ),
      ],
    );
  }

  Widget _buildListTileWithDisclosureIndicator(
      String title, void Function() onTap) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.navigate_next),
      onTap: onTap,
    );
  }

  void _makeEmailForm() {
    final email = Email(recipients: const ["yoohan95@gmail.com"]);
    FlutterEmailSender.send(email).then((_) {}).catchError((error) {});
  }
}
