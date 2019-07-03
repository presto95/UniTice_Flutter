import "package:flutter/material.dart";
import 'package:unitice/common/keyword_register_mode.dart';
import 'package:unitice/widget/app_bar_title_text.dart';
import 'package:unitice/widget/keyword_registerer.dart';

class ChangeKeywordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: AppBarTitleText("키워드 설정"),
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: KeywordRegisterer(
            mode: KeywordRegisterMode.change,
          ),
        ),
      ),
    );
  }
}
