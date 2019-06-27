import "package:flutter/material.dart";
import 'package:unitice/main.dart';
import 'package:unitice/model/bookmark_provider.dart';
import 'package:unitice/model/category.dart';
import 'package:unitice/model/post.dart';
import 'package:unitice/model/university_scrap_type.dart';
import 'package:unitice/model/user.dart';
import 'package:unitice/page/main/post_web_view_page.dart';

class PostList extends StatefulWidget {
  final UniversityScrapType universityModel;
  final Category category;
  final List<String> keywords;

  PostList(this.universityModel, this.category, this.keywords);

  @override
  State<StatefulWidget> createState() => _PostListState();
}

class _PostListState extends State<PostList> with RouteAware {
  bool _isNoticeVisible = false;
  List<Post> _posts = [];
  int _page;

  @override
  void initState() {
    super.initState();
    _page = 1;
    _requestPosts();
    _setNoticeVisibility();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _requestPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return RefreshIndicator(
            child: _buildPostList(),
            onRefresh: () {
              _page = 1;
              return _requestPosts();
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
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
    // 상태 초기화
    _page = 1;
    _requestPosts();
    _setNoticeVisibility();
  }

  Widget _buildPostList() {
    final _scrollController = ScrollController();
    final noticePosts = _posts.where((post) => post.isNotice).toList();
    final standardPosts = _posts.where((post) => !post.isNotice).toList();
    final noticePostsLength = noticePosts.length;
    final standardPostsLength = standardPosts.length;
    return ListView.builder(
      controller: _scrollController,
      itemCount:
          _isNoticeVisible ? _posts.length + 2 : standardPosts.length + 1,
      itemBuilder: (context, row) {
        if (row == 0) {
          return Container(
            padding: EdgeInsets.only(left: 16),
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
                  icon: Icon(_isNoticeVisible
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down),
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
        if (_isNoticeVisible && row == noticePostsLength + 1) {
          return SizedBox(
            height: 5,
            child: Container(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
        final post =
            _decidePost(noticePosts, standardPosts, row, _isNoticeVisible);
        return Column(
          children: <Widget>[
            ListTile(
              title: Text(post.title),
              subtitle: Text(post.date),
              onTap: () async {
                final url = widget.universityModel
                    .getPostUrl(widget.category, post.link);
                await _saveBookmark(post);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PostWebViewPage(url)));
              },
            ),
            Divider(height: 0),
          ],
        );
      },
    );
  }

  Post _decidePost(List<Post> noticePosts, List<Post> standardPosts, int row,
      bool isNoticeVisible) {
    if (isNoticeVisible) {
      if (row <= noticePosts.length) {
        return noticePosts[row - 1];
      } else if (row >= noticePosts.length + 2) {
        return standardPosts[row - noticePosts.length - 2];
      }
    } else {
      return standardPosts[row - 1];
    }
    return null;
  }

  void _setNoticeVisibility() async {
    final isVisible = await User.isNoticeVisible;
    print(isVisible);
    setState(() {
      _isNoticeVisible = isVisible ?? false;
    });
  }

  Future<void> _requestPosts() async {
    final posts =
        await widget.universityModel.requestPosts(widget.category, _page, "");
    _page += 1;
    if (mounted) {
      _posts = posts;
    }
  }

  Future<void> _saveBookmark(Post post) async {
    final provider = BookmarkProvider();
    await provider.open();
    final url = widget.universityModel.getPostUrl(widget.category, post.link);
    final bookmark = Post(
      number: post.number,
      title: post.title,
      date: post.date,
      link: url,
      note: post.note,
      isNotice: post.isNotice,
    );
    await provider.insert(bookmark);
    await provider.close();
  }
}
