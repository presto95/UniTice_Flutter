import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unitice/service/scrap_service.dart';
import 'package:unitice/widget/app_bar_title.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String universityName = "";

  @override
  void initState() {
    super.initState();
    _setUniversityName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBarTitle(universityName),
        actions: _buildAppBarActions(context),
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

  Future _setUniversityName() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      universityName = preferences.getString("university");
    });
  }
}
