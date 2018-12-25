import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

@immutable
class ImageDetailPage extends StatefulWidget {
  final String _imageUrl;
  final String _author;

  ImageDetailPage(this._imageUrl, this._author);

  @override
  State<StatefulWidget> createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetailPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(widget._author),
      ),
      body: Center(
          child: GestureDetector(
        child: Hero(
          tag: widget._imageUrl,
          child: CachedNetworkImage(imageUrl: widget._imageUrl),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      )),
    );
  }
}
