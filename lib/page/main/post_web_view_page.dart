import "package:flutter/material.dart";
import 'package:unitice/widget/app_bar_title.dart';
import "package:webview_flutter/webview_flutter.dart";

class PostWebViewPage extends StatefulWidget {
  final String url;

  PostWebViewPage(this.url);

  @override
  State<StatefulWidget> createState() => _PostWebViewPageState();
}

class _PostWebViewPageState extends State<PostWebViewPage> {
  bool _isLoading = true;
  WebView _webView;

  @override
  void initState() {
    super.initState();
    _webView = WebView(
      initialUrl: widget.url,
      onPageFinished: (_) {
        setState(() {
          _isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(title: "게시물"),
      ),
      body: Stack(
        children: <Widget>[
          _webView,
          _buildProgressIndicator(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Container();
  }
}
