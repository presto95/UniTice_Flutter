import "package:flutter/material.dart";
import 'package:unitice/model/user.dart';

class NoticeVisibilityListTile extends StatefulWidget {
  @override
  _NoticeVisibilityListTileState createState() =>
      _NoticeVisibilityListTileState();
}

class _NoticeVisibilityListTileState extends State<NoticeVisibilityListTile> {
  bool _isNoticeVisible = false;
  String get _visibilityDescription =>
      "공지사항이 ${_isNoticeVisible ? "펼쳐진" : "접혀진"} 상태입니다.";

  @override
  void initState() {
    super.initState();
    _setNoticeVisibility();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildListTile(),
        _buildVisibilityDescriptionText(),
      ],
    );
  }

  Widget _buildListTile() {
    return ListTile(
      title: const Text("공지사항 펼치기"),
      trailing: Switch(
        value: _isNoticeVisible,
        onChanged: (isOn) {
          User.setNoticeVisibility(isOn);
          setState(() {
            _isNoticeVisible = isOn;
          });
        },
      ),
    );
  }

  Widget _buildVisibilityDescriptionText() {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        _visibilityDescription,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 13,
        ),
      ),
    );
  }

  void _setNoticeVisibility() async {
    final isVisible = await User.isNoticeVisible;
    setState(() {
      _isNoticeVisible = isVisible ?? false;
    });
  }
}
