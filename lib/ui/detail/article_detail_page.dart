import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

@immutable
class ArticleDetailPage extends StatefulWidget {
  final String _author;
  final String _url;

  ArticleDetailPage(this._author, this._url);

  @override
  State<StatefulWidget> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetailPage> {
  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      scrollBar: true,
      withZoom: true,
      withLocalStorage: true,
      withLocalUrl: true,
      url: widget._url,
      appBar: AppBar(
        title: Text(widget._author),
      ),
      initialChild: Center(
        child: Text('loading...'),
      ),
    );
  }
}
