import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';

class ListDataLoader<T> {
    List<T> _dataList;
    LoadCallback<T> _callback;
    int _page = 1;
    RefreshController refreshController;

    ListDataLoader(this._callback, this._dataList) {
        refreshController = RefreshController();
    }

    ///刷新，or，加载更多
    void refresh(bool up) async {
        if (up) {
            _page = 1;
        } else {
            _page++;
        }
        loadData();
    }

    ///加载数据
    void loadData() async {
        Future<List<T>> future = _callback.request(_page);
        future.then((list) {
            _callback.updateState(() {
                if (_page == 1) {
                    _dataList.clear();
                }
                _dataList.addAll(list);
                refreshController.sendBack(_page == 1, RefreshStatus.idle);
            });
        }).catchError(() {
            refreshController.sendBack(_page == 1, RefreshStatus.failed);
        });
    }
}

///回调
abstract class LoadCallback<T> {
    ///发送请求
    Future<List<T>> request(int page);
    ///刷新状态
    void updateState(VoidCallback f);
}
