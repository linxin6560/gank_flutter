import 'dart:async';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';

class ListDataLoader<T> {
  List<T> _dataList;
  LoadCallback<T> _callback;
  int _page = 1;
  RefreshController refreshController = RefreshController();

  ListDataLoader(this._callback, this._dataList);

  ///刷新，or，加载更多
  void refresh() async {
    _page = 1;
    loadData();
  }

  ///加载数据
  void loadData() async {
    print("loadData $_callback");
    List<T> list = await _callback.request(_page);
    print("loadData size:${list.length}");
    _callback.updateState(() {
      if (_page == 1) {
        try {
          _dataList.clear();
          _dataList.addAll(list);
          refreshController.refreshCompleted();
        } catch (e) {
          refreshController.refreshFailed();
        }
      } else {
        try {
          _dataList.addAll(list);
          refreshController.loadComplete();
        } catch (e) {
          refreshController.loadFailed();
        }
      }
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
