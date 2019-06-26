import "package:flutter/material.dart";
import 'package:unitice/model/bookmark_provider.dart';
import 'package:unitice/model/post.dart';
import 'package:unitice/page/main/post_web_view_page.dart';
import 'package:unitice/widget/app_bar_title.dart';
import 'package:unitice/widget/dismissible_background.dart';

class BookmarkPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  List<Post> _posts = [];

  @override
  void initState() {
    super.initState();
    _fetchBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(title: "북마크"),
      ),
      body: _posts.isEmpty ? _buildEmptyContainer() : _buildListView(),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (context, row) {
        final post = _posts[row];
        return Column(
          children: <Widget>[
            Dismissible(
              key: Key(post.title),
              child: ListTile(
                title: Text(post.title),
                subtitle: Text(post.date),
                onTap: () {
                  final url = post.link;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PostWebViewPage(url)));
                },
              ),
              background: DismissibleBackground(),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  final provider = BookmarkProvider();
                  await provider.open();
                  await provider.deleteByTitle(post.title);
                  await provider.close();
                  setState(() {
                    _posts.remove(post);
                  });
                }
              },
            ),
            Divider(height: 0),
          ],
        );
      },
    );
  }

  Widget _buildEmptyContainer() {
    return Center(child: Text("저장된 북마크가 없습니다."));
  }

  void _fetchBookmarks() async {
    final provider = BookmarkProvider();
    await provider.open();
    final posts = await provider.readAll();
    setState(() {
      _posts = posts ?? [];
    });
  }
}
