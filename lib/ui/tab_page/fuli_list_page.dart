import 'package:cached_network_image/cached_network_image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:gank_flutter/api/api.dart';
import 'package:gank_flutter/bean/fuli_item.dart';
import 'package:gank_flutter/helper/list_data_loader.dart';
import 'package:gank_flutter/ui/detail/image_detail_page.dart';

@immutable
class WelfarePage extends StatefulWidget {
  final String _tabName;

  WelfarePage(this._tabName);

  @override
  State<StatefulWidget> createState() => _WelfareState();
}

class _WelfareState extends State<WelfarePage> with AutomaticKeepAliveClientMixin, LoadCallback<FuliItem> {
  List<FuliItem> _items = [];
  ListDataLoader<FuliItem> _dataLoader;


  _WelfareState(){
    print("new _WelfareState");
  }

  @override
  void initState() {
    super.initState();
    _dataLoader = ListDataLoader(this, _items);
    _dataLoader.loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Container(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: SmartRefresher(
          enablePullUp: true,
          enablePullDown: false,
          onRefresh: _dataLoader.refresh,
          controller: _dataLoader.refreshController,
          child: GridView.builder(
            itemCount: _items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (BuildContext context, int index) {
              FuliItem item = _items[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => ImageDetailPage(item.url, item.who)));
                },
                child: Container(
                  color: Colors.grey[200],
                  child: Hero(
                    tag: item.url,
                    child: CachedNetworkImage(
                      imageUrl: item.url,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
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
  Future<List<FuliItem>> request(int page) {
    return getFuliListData(widget._tabName, page);
  }
}
