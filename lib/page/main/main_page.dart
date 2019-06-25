import "package:flutter/material.dart";
import 'package:unitice/main.dart';
import 'package:unitice/model/user.dart';
import 'package:unitice/widget/app_bar_title.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with RouteAware {
  String universityName = "";
  List<String> keywords = [];

  // Life Cycle

  @override
  void initState() {
    super.initState();
    _setUniversityName();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
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

  @override
  void dispose() {
    super.dispose();
    routeObserver.unsubscribe(this);
  }

  // Route Observing

  @override
  void didPopNext() {
    // TODO: 학교 변경 / 게시물 다시 불러오기 등 초기화 작업
    _setUniversityName();
    _setKeywords();
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

  void _setUniversityName() async {
    final universityName = await User.university;
    setState(() {
      this.universityName = universityName;
    });
  }

  Future _setKeywords() async {
    final keywords = await User.keywords;
    setState(() {
      this.keywords = keywords;
    });
  }
}
