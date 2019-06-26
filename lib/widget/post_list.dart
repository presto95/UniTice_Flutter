import "package:flutter/material.dart";
import 'package:unitice/model/bookmark_provider.dart';
import 'package:unitice/model/category.dart';
import 'package:unitice/model/post.dart';
import 'package:unitice/model/university_scrap_type.dart';
import 'package:unitice/page/main/post_web_view_page.dart';

class PostList extends StatefulWidget {
  final UniversityScrapType universityModel;
  final Category category;

  PostList(this.universityModel, this.category);

  @override
  State<StatefulWidget> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  List<Post> _posts = [];
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _requestPosts();
  }

  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();
    return FutureBuilder(
      future: _requestPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return RefreshIndicator(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _posts.length,
              itemBuilder: (context, row) {
                final post = _posts[row];
                return Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.date),
                      onTap: () async {
                        // TODO: 북마크에 저장
                        final provider = BookmarkProvider();
                        await provider.open();
                        final url = widget.universityModel
                            .getPostUrl(widget.category, post.link);
                        final bookmark = Post(
                            number: post.number,
                            title: post.title,
                            date: post.date,
                            link: url,
                            note: post.note,
                            isNotice: post.isNotice);
                        await provider.insert(bookmark);
                        await provider.close();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PostWebViewPage(url)));
                      },
                    ),
                    Divider(height: 0),
                  ],
                );
              },
            ),
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

  Future<void> _requestPosts() async {
    final posts =
        await widget.universityModel.requestPosts(widget.category, _page, "");
    _page += 1;
    if (mounted) {
      _posts = posts;
    }
  }
}
