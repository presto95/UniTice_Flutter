import 'dart:io';

import "package:flutter/material.dart";
import 'package:unitice/main.dart';
import 'package:unitice/model/bookmark_provider.dart';
import 'package:unitice/model/category.dart';
import 'package:unitice/model/post.dart';
import 'package:unitice/model/university_scrap_type.dart';
import 'package:unitice/model/user.dart';
import 'package:unitice/page/main/post_web_view_page.dart';
import "package:url_launcher/url_launcher.dart";
import "package:highlight_text/highlight_text.dart";

class PostListView extends StatefulWidget {
  final UniversityScrapType universityModel;
  final Category category;
  final List<String> keywords;

  PostListView(this.universityModel, this.category, this.keywords);

  @override
  State<StatefulWidget> createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> with RouteAware {
  final _scrollController = ScrollController();
  Map<String, HighlightedWord> _words = {};
  bool _isLoading = false;
  bool _isNoticeVisible = false;
  List<Post> _noticePosts = [];
  List<Post> _standardPosts = [];
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _getHighlightedWords();
    _requestPosts(isInRefresh: false);
    _setNoticeVisibility();
    _scrollController.addListener(() {
      _addInfiniteScrollBehavior();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        RefreshIndicator(
          child: _buildPostListView(),
          onRefresh: () {
            return _requestPosts(isInRefresh: true);
          },
        ),
        _isLoading ? Center(child: CircularProgressIndicator()) : Container(),
      ],
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
    setState(() {
      _noticePosts = [];
      _standardPosts = [];
    });
    _getHighlightedWords();
    _requestPosts(isInRefresh: true);
    _setNoticeVisibility();
  }

  Widget _buildPostListView() {
    final noticePostsLength = _noticePosts.length;
    final standardPostsLength = _standardPosts.length;
    return ListView.builder(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: _isNoticeVisible
          ? noticePostsLength + standardPostsLength + 2
          : standardPostsLength + 1,
      itemBuilder: (context, row) {
        if (row == 0) {
          return _buildNoticeHeader();
        }
        if (_isNoticeVisible && row == noticePostsLength + 1) {
          return _buildBorder();
        }
        final post = _decidePost(row);
        return _buildPostListTile(context, post);
      },
    );
  }

  Widget _buildPostListTile(BuildContext context, Post post) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(post.title),
          subtitle: Text(
              post.note.isEmpty ? post.date : post.date + " | " + post.note),
          onTap: () async {
            final url =
                widget.universityModel.getPostUrl(widget.category, post.link);
            await _saveBookmark(post);
            _launchUrl(url);
          },
        ),
        Divider(height: 0),
      ],
    );
  }

  void _launchUrl(String url) async {
    if (Platform.isIOS) {
      if (await canLaunch(url)) {
        await launch(url);
      }
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PostWebViewPage(url),
      ));
    }
  }

  Widget _buildNoticeHeader() {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      color: Theme.of(context).primaryColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(
              "공지사항",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              _isNoticeVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            ),
            color: Colors.white,
            onPressed: () {
              setState(() {
                final newState = !_isNoticeVisible;
                setState(() {
                  _isNoticeVisible = newState;
                });
              });
            },
          )
        ],
      ),
    );
  }

  Widget _buildBorder() {
    return SizedBox(
      height: 5,
      child: Container(
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  void _addInfiniteScrollBehavior() {
    if (Platform.isIOS) {
      if (_scrollController.offset >
              _scrollController.position.maxScrollExtent + 20 &&
          !_isLoading) {
        _requestPosts(isInRefresh: false);
      }
    } else {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        _requestPosts(isInRefresh: false);
      }
    }
  }

  Post _decidePost(int row) {
    if (_isNoticeVisible) {
      if (row <= _noticePosts.length) {
        return _noticePosts[row - 1];
      } else if (row >= _noticePosts.length + 2) {
        return _standardPosts[row - _noticePosts.length - 2];
      }
    } else {
      return _standardPosts[row - 1];
    }
    return null;
  }

  void _setNoticeVisibility() async {
    final isVisible = await User.isNoticeVisible;
    setState(() {
      _isNoticeVisible = isVisible ?? false;
    });
  }

  void _getHighlightedWords() {
    final keywords = widget.keywords;
    keywords.forEach((keyword) {
      _words[keyword] = HighlightedWord(
        textStyle: TextStyle(color: Colors.red),
        onTap: null,
      );
    });
  }

  Future<void> _requestPosts({bool isInRefresh}) async {
    setState(() {
      _isLoading = true;
    });
    if (isInRefresh) {
      _page = 1;
    }
    final posts =
        await widget.universityModel.requestPosts(widget.category, _page);
    _page += 1;
    final noticePosts = posts.where((post) => post.isNotice);
    final standardPosts = posts.where((post) => !post.isNotice);
    if (!mounted) {
      return;
    }
    setState(() {
      if (isInRefresh) {
        if (_noticePosts.toString() != noticePosts.toList().toString()) {
          _noticePosts = noticePosts.toList();
        }
        _standardPosts = standardPosts.toList();
      } else {
        if (_noticePosts.toString() != noticePosts.toList().toString()) {
          _noticePosts.addAll(noticePosts);
        }
        _standardPosts.addAll(standardPosts);
      }
      _isLoading = false;
    });
  }

  Future<void> _saveBookmark(Post post) async {
    final provider = BookmarkProvider();
    await provider.open();
    final bookmarks = await provider.readAll() ?? [];
    final url = widget.universityModel.getPostUrl(widget.category, post.link);
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
