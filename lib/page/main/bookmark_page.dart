import "package:flutter/material.dart";
import 'package:unitice/model/bookmark_provider.dart';
import 'package:unitice/model/post.dart';
import 'package:unitice/page/main/post_web_view_page.dart';
import 'package:unitice/widget/app_bar_title_text.dart';
import 'package:unitice/widget/dismissible_background.dart';

class BookmarkPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  List<Post> _posts = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitleText("북마크"),
      ),
      body: Stack(
        children: <Widget>[
          _buildContents(),
          _isLoading ? CircularProgressIndicator() : Container(),
        ],
      ),
    );
  }

  Widget _buildContents() {
    if (_isLoading) {
      return Container();
    }
    if (_posts.isEmpty) {
      return _buildEmptyContainerWithText();
    }
    return _buildBookmarkListView();
  }

  Widget _buildBookmarkListView() {
    return ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (context, row) {
        final post = _posts[row];
        return Column(
          children: <Widget>[
            Dismissible(
              key: Key(post.title),
              child: _buildBookmarkListTile(context, post),
              background: DismissibleBackground(),
              direction: DismissDirection.endToStart,
              onDismissed: (_) => _removeBookmark(post),
            ),
            Divider(height: 0),
          ],
        );
      },
    );
  }

  Widget _buildBookmarkListTile(BuildContext context, Post post) {
    final url = post.link;
    return ListTile(
      title: Text(post.title),
      subtitle: Text(post.date),
      onTap: () => _pushWebViewPage(context, url),
    );
  }

  Widget _buildEmptyContainerWithText() {
    return Center(
      child: Text("저장된 북마크가 없습니다."),
    );
  }

  void _fetchBookmarks() async {
    final provider = BookmarkProvider();
    await provider.open();
    final posts = await provider.readAll();
    await provider.close();
    setState(() {
      _posts = posts ?? [];
    });
  }

  void _removeBookmark(Post post) async {
    final provider = BookmarkProvider();
    await provider.open();
    await provider.deleteByTitle(post.title);
    await provider.close();
    setState(() {
      _posts.remove(post);
    });
  }

  void _pushWebViewPage(BuildContext context, String url) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PostWebViewPage(url),
    ));
  }
}
