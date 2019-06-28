import "package:flutter/material.dart";
import 'package:unitice/model/bookmark_provider.dart';
import 'package:unitice/model/university_helper.dart';
import 'package:unitice/model/user.dart';
import 'package:unitice/widget/app_bar_title_text.dart';
import 'package:unitice/widget/university_picker.dart';

class ChangeUniversityPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChangeUniversityPageState();
}

class _ChangeUniversityPageState extends State<ChangeUniversityPage> {
  String _selectedUniversity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitleText("학교 변경"),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            _buildUniversityPickerView(),
            _buildWarningText(),
            Builder(
              builder: (context) => _buildButtonContainer(context),
            ),
          ],
        ),
      ),
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

  Widget _buildWarningText() {
    return FittedBox(
      child: Text(
        "학교 변경시 저장된 키워드 및 북마크 정보가 초기화됩니다.",
        style: TextStyle(
          color: Colors.red,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      fit: BoxFit.contain,
    );
  }

  Widget _buildButtonContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              child: Text(
                "확인",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () => _changeUniversity(context),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          style: BorderStyle.solid,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  void _changeUniversity(BuildContext context) {
    if (_selectedUniversity == null) {
      final snackBar = SnackBar(
        content: Text("학교를 선택하세요."),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      _removeBookmarks();
      User.setKeywords([]);
      User.setUniversity(_selectedUniversity);
      Navigator.of(context).pop();
    }
  }

  void _removeBookmarks() async {
    final provider = BookmarkProvider();
    await provider.open();
    await provider.deleteAll();
    await provider.close();
  }
}
