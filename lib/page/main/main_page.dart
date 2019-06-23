import "package:flutter/material.dart";
import 'package:unitice/widgets/app_bar_title.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle("학교 이름"),
        actions: _buildAppBarActions(context),
        automaticallyImplyLeading: false,
      ),
      body: _buildPostListView(),
    );
  }

  List<Widget> _buildAppBarActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.settings),
        onPressed: () => Navigator.of(context).pushNamed("/setting"),
      ),
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () => Navigator.of(context).pushNamed("/search"),
      ),
      IconButton(
        icon: Icon(Icons.bookmark),
        onPressed: () => Navigator.of(context).pushNamed("/bookmark"),
      ),
    ];
  }

  Widget _buildPostListView() {
    return RefreshIndicator(
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, row) {
          return ListTile(
            title: Text("title"),
            subtitle: Text("subtitle"),
          );
        },
      ),
      onRefresh: () {},
    );
  }
}
