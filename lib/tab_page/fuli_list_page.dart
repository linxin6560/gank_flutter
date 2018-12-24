import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gank_flutter/api/api.dart';
import 'package:gank_flutter/bean/fuli_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:gank_flutter/helper/list_data_loader.dart';

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

  @override
  void initState() {
    super.initState();
    _dataLoader = ListDataLoader(this,  _items);
    _dataLoader.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Padding(
          padding: EdgeInsets.all(5),
          child: SmartRefresher(
            enablePullUp: false,
            enablePullDown: true,
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
              itemBuilder: (BuildContext context, int index) => new Container(
                    color: Colors.grey[200],
                    child: CachedNetworkImage(
                      imageUrl: _items[index].url,
                      fit: BoxFit.cover,
                    ),
                  ),
            ),
          )),
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
