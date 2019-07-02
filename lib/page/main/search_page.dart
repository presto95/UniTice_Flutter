import 'dart:io';

import "package:flutter/material.dart";
import 'package:unitice/model/bookmark_provider.dart';
import 'package:unitice/model/category.dart';
import 'package:unitice/model/post.dart';
import 'package:unitice/model/university_scrap_type.dart';
import 'package:unitice/page/main/post_web_view_page.dart';
import 'package:unitice/widget/app_bar_title_text.dart';

class SearchPage extends StatefulWidget {
  final UniversityScrapType universityModel;

  List<Category> get categories => universityModel.categories;

  SearchPage(this.universityModel);

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _scrollController = ScrollController();
  Category _selectedCategory;
  String _queryString = "";
  List<Post> _posts = [];
  bool _isLoading = false;
  int _page = 1;

  bool get _canSearch => _selectedCategory != null && _queryString != null;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      FocusScope.of(context).requestFocus(FocusNode());
      _addInfiniteScrollBehavior();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitleText("검색"),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              _buildQueryTextFieldRow(),
              _buildPostListView(),
            ],
          ),
          _isLoading ? Center(child: CircularProgressIndicator()) : Container(),
        ],
      ),
    );
  }

  Widget _buildQueryTextFieldRow() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          _buildCategoryDropDownButton(),
          SizedBox(width: 8),
          _buildQueryTextField(),
          SizedBox(width: 8),
          _buildSearchButton(),
        ],
      ),
    );
  }

  Widget _buildPostListView() {
    return Flexible(
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: _posts.length,
        itemBuilder: (context, row) {
          final post = _posts[row];
          return Column(
            children: <Widget>[
              _buildPostListTile(post),
              Divider(height: 0),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCategoryDropDownButton() {
    final items = widget.universityModel.categories.map((category) {
      return DropdownMenuItem<String>(
        child: Center(
          child: Text(category.description),
        ),
        value: category.description,
      );
    }).toList();
    return DropdownButton(
      value: _selectedCategory?.description,
      hint: Center(
        child: Text("카테고리"),
      ),
      items: items,
      onChanged: (item) {
        final selectedCategory = widget.categories
            .firstWhere((category) => category.description == item);
        setState(() {
          _selectedCategory = selectedCategory;
        });
      },
    );
  }

  Widget _buildQueryTextField() {
    return Expanded(
      child: TextField(
        decoration: InputDecoration(
          hintText: "글 제목",
        ),
        onChanged: (text) {
          setState(() {
            _queryString = text;
          });
        },
      ),
    );
  }

  Widget _buildSearchButton() {
    return FlatButton(
      child: Text("검색"),
      onPressed: () => _canSearch ? _searchPosts(loadsNextPage: false) : null,
    );
  }

  Widget _buildPostListTile(Post post) {
    return ListTile(
      title: Text(post.title),
      subtitle:
          Text(post.note.isEmpty ? post.date : post.date + " | " + post.note),
      onTap: () async {
        final url =
            widget.universityModel.getPostUrl(_selectedCategory, post.link);
        await _saveBookmark(post);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => PostWebViewPage(url)));
      },
    );
  }

  void _addInfiniteScrollBehavior() {
    if (Platform.isIOS) {
      if (_scrollController.offset >
              _scrollController.position.maxScrollExtent + 20 &&
          !_isLoading) {
        _searchPosts(loadsNextPage: true);
      }
    } else {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        _searchPosts(loadsNextPage: true);
      }
    }
  }

  void _searchPosts({@required bool loadsNextPage}) async {
    setState(() {
      _isLoading = true;
    });
    if (!loadsNextPage) {
      _page = 1;
    }
    final posts = await widget.universityModel
        .requestPosts(_selectedCategory, _page, _queryString);
    final standardPosts = posts.where((post) => !post.isNotice);
    _page += 1;
    if (mounted) {
      setState(() {
        if (loadsNextPage) {
          _posts.addAll(standardPosts);
        } else {
          _posts = standardPosts.toList();
        }
        _isLoading = false;
      });
    }
  }

  Future<void> _saveBookmark(Post post) async {
    final provider = BookmarkProvider();
    await provider.open();
    final bookmarks = await provider.readAll() ?? [];
    final url = widget.universityModel.getPostUrl(_selectedCategory, post.link);
    if (bookmarks.where((bookmark) => bookmark.link == url).isEmpty) {
      final bookmark = Post(
        number: post.number,
        title: post.title,
        date: post.date,
        link: url,
        note: post.note,
        isNotice: post.isNotice,
      );
      await provider.insert(bookmark);
    }
    await provider.close();
  }
}
