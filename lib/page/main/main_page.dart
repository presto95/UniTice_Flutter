import "package:flutter/material.dart";
import 'package:unitice/main.dart';
import 'package:unitice/model/university_helper.dart';
import 'package:unitice/model/university_scrap_type.dart';
import 'package:unitice/model/user.dart';
import 'package:unitice/page/main/search_page.dart';
import 'package:unitice/widget/app_bar_title_text.dart';
import 'package:unitice/widget/post_list_view.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with RouteAware {
  UniversityScrapType _universityScrapModel;
  String _universityName;
  List<String> _keywords = [];

  @override
  void initState() {
    super.initState();
    _setUniversity();
    _setKeywords();
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
        appBar: _buildAppBar(),
        body: _buildTabBarView(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    routeObserver.unsubscribe(this);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    _setUniversity();
    _setKeywords();
  }

  Widget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: AppBarTitleText(_universityName),
      bottom: TabBar(
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.label,
        isScrollable: true,
        tabs: _universityScrapModel.categories
            .map((category) => Tab(text: category.description))
            .toList(),
      ),
      actions: _buildAppBarActions(context),
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
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SearchPage(_universityScrapModel),
            )),
      ),
      IconButton(
        icon: Icon(Icons.bookmark),
        onPressed: () => Navigator.of(context).pushNamed("/bookmark"),
      ),
    ];
  }

  Widget _buildTabBarView() {
    final postListViews = _universityScrapModel.categories
        .map((category) =>
            PostListView(_universityScrapModel, category, _keywords))
        .toList();
    return TabBarView(
      children: postListViews,
    );
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

  void _setKeywords() async {
    final keywords = await User.keywords;
    setState(() {
      _keywords = keywords;
    });
  }
}
