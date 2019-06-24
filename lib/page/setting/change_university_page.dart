import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:unitice/model/university_helper.dart';
import 'package:unitice/widget/app_bar_title.dart';

class ChangeUniversityPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChangeUniversityPageState();
}

class _ChangeUniversityPageState extends State<ChangeUniversityPage> {
  String selectedUniversity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle("학교 변경"),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            _buildUniversityPickerView(),
            _buildWarningText(),
            Builder(builder: (context) => _buildButtonContainer(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildUniversityPickerView() {
    final items = UniversityHelper.universityNames;
    return Flexible(
      child: CupertinoPicker.builder(
        backgroundColor: Colors.transparent,
        useMagnifier: true,
        magnification: 1.5,
        itemExtent: 44,
        childCount: items.length,
        itemBuilder: (context, row) => _buildPickerViewItem(items[row]),
        onSelectedItemChanged: (row) {
          selectedUniversity = items[row];
        },
      ),
    );
  }

  Widget _buildPickerViewItem(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _buildWarningText() {
    return Text(
      "학교 변경시 저장된 키워드 및 북마크 정보가 초기화됩니다.",
      style: TextStyle(
        color: Colors.red,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
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
              onPressed: () {
                if (selectedUniversity == null) {
                  final snackBar = SnackBar(content: Text("학교를 선택하세요."));
                  Scaffold.of(context).showSnackBar(snackBar);
                } else {
                  // TODO: 키워드 초기화
                  // TODO: 북마크 초기화
                  Navigator.of(context).pop();
                }
              },
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(
            color: Theme.of(context).primaryColor,
            style: BorderStyle.solid,
            width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
