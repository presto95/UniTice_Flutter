import "package:flutter/material.dart";
import 'package:unitice/widget/app_bar_title.dart';

class BookmarkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle("북마크"),
      ),
      body: _buildListView(),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, row) {
        return ListTile(
          title: Text("title"),
          subtitle: Text("subtitle"),
        );
      },
    );
  }
}
