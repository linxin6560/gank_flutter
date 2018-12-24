import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:gank_flutter/api/api.dart';
import 'package:gank_flutter/bean/article_item.dart';
import 'package:gank_flutter/helper/list_data_loader.dart';

@immutable
class ArticleListPage extends StatefulWidget {
  final String _tabName;

  ArticleListPage(this._tabName);

  @override
  State<StatefulWidget> createState() {
    return new _ArticleListState();
  }
}

class _ArticleListState extends State<ArticleListPage> with AutomaticKeepAliveClientMixin, LoadCallback<ArticleItem> {
  List<ArticleItem> _items = [];
  ListDataLoader<ArticleItem> _dataLoader;

  @override
  void initState() {
    super.initState();
    _dataLoader = new ListDataLoader(this, _items);
    _dataLoader.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Padding(
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
                return new Card(
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
                );
              }),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void updateState(f) {
    setState(f);
  }

  @override
  Future<List<ArticleItem>> request(int page) {
    return getArticleListData(widget._tabName, page);
  }
}
