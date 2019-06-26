import "package:flutter/material.dart";
import 'package:unitice/main.dart';
import 'package:unitice/model/post.dart';
import 'package:unitice/model/university_helper.dart';
import 'package:unitice/model/university_scrap_type.dart';
import 'package:unitice/model/user.dart';
import 'package:unitice/widget/app_bar_title.dart';
import 'package:unitice/widget/post_list.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with RouteAware {
  UniversityScrapType _universityScrapModel;
  String _universityName;
  List<String> _keywords = [];
  List<Post> _posts = [];

  // Life Cycle

  @override
  void initState() {
    super.initState();
    _setUniversity();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _universityScrapModel.categories.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: AppBarTitle(title: _universityName),
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            tabs: _universityScrapModel.categories
                .map((category) => Tab(text: category.description))
                .toList(),
          ),
          actions: _buildAppBarActions(context),
        ),
        body: TabBarView(
          children: _universityScrapModel.categories
              .map((category) => PostList(_universityScrapModel, category))
              .toList(),
        ),
      ),
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
    _setUniversity();
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

  void _setUniversity() async {
    final universityName = await User.university;
    final university = UniversityHelper.getUniversity(universityName);
    final scrapModel = UniversityHelper.getScrapModel(university);
    _universityScrapModel = scrapModel;
    setState(() {
      _universityName = universityName;
    });
  }

  Future _setKeywords() async {
    final keywords = await User.keywords;
    setState(() {
      _keywords = keywords;
    });
  }
}
