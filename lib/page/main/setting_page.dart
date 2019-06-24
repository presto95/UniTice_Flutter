import "package:flutter/material.dart";
import "package:flutter_email_sender/flutter_email_sender.dart";
import 'package:unitice/widget/app_bar_title.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle("설정"),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              _buildFirstSection(),
              Divider(),
              _buildSecondSection(context),
              Divider(),
              _buildThirdSection(),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFirstSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title: Text("상단 고정 게시물 접기"),
          trailing: Switch(
            value: false,
            onChanged: (isOn) {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text("상단 고정 게시물이 펼쳐진 / 접혀진 상태입니다."),
        ),
      ],
    );
  }

  Widget _buildSecondSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildListTileWithDisclosureIndicator(
            title: "학교 변경",
            onTap: () =>
                Navigator.of(context).pushNamed("/setting/changeUniversity")),
        _buildListTileWithDisclosureIndicator(
            title: "키워드 설정",
            onTap: () =>
                Navigator.of(context).pushNamed("/setting/changeKeyword")),
        _buildListTileWithDisclosureIndicator(
          title: "알림 설정",
          onTap: () {},
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text("알림이 활성화 / 비활성화되어 있습니다."),
        ),
      ],
    );
  }

  Widget _buildThirdSection() {
    return Column(
      children: <Widget>[
        _buildListTileWithDisclosureIndicator(
          title: "문의하기",
          onTap: _makeEmailForm,
        ),
        _buildListTileWithDisclosureIndicator(
          title: "앱 평가하기",
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildListTileWithDisclosureIndicator(
      {String title, void Function() onTap}) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.navigate_next),
      onTap: onTap,
    );
  }

  void _makeEmailForm() {
    final email = Email(
      recipients: const ["yoohan95@gmail.com"],
    );
    FlutterEmailSender.send(email).then((_) {});
  }
}
