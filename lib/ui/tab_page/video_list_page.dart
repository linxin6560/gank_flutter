import 'package:flutter/material.dart';
import 'package:gank_flutter/api/api.dart' as Api;
import 'package:gank_flutter/bean/article_item.dart';
import 'package:gank_flutter/helper/list_data_loader.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

@immutable
class VideoListPage extends StatefulWidget {
  final String _tabName;

  VideoListPage(this._tabName);

  @override
  State<StatefulWidget> createState()=>_VideoListState();
}

class _VideoListState extends State<VideoListPage> with LoadCallback<ArticleItem>{

  List<ArticleItem> _items = [];
  ListDataLoader _dataLoader;

  @override
  void initState() {
    super.initState();
    _dataLoader = new ListDataLoader(this, _items);
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.all(5),
      child: SmartRefresher(
        enablePullDown: false,
        enablePullUp: true,
        controller: _dataLoader.refreshController,
        onRefresh: _dataLoader.refresh,
        child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (BuildContext context, int index) {
                  ArticleItem item = _items[index];
                  String publishedAt = item.publishedAt.split("T")[0];
                  print('video -> $item');
                  return GestureDetector(
                          child: new Card(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(item.desc),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        item.who,
                                        style: TextStyle(color: Colors.grey, fontSize: 12),
                                      ),
                                      Text(
                                        publishedAt,
                                        style: TextStyle(color: Colors.grey, fontSize: 12),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
//                            Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleDetailPage(item.who, item.url)));
                          });
                }),
      ),
    );
  }

  @override
  Future<List<ArticleItem>> request(int page) {
    return Api.getArticleListData(widget._tabName, page);
  }

  @override
  void updateState(f) {
    setState(f);
  }
}