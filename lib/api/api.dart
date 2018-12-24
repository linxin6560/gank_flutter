import 'package:http/http.dart';
import 'dart:convert';
import 'package:gank_flutter/bean/fuli_item.dart';
import 'package:gank_flutter/bean/article_item.dart';

///获取tab的列表数据
Future<dynamic> getTabListData(String tabName, int page) async {
  String category;
  if (tabName == '全部') {
    category = 'all';
  } else {
    category = tabName;
  }

  String url = "http://gank.io/api/data/$category/20/$page";
  Response response = await get(url);
  dynamic body = json.decode(response.body);
  print('body->$body');
  return body;
}

///获取福利列表
Future<List<FuliItem>> getFuliListData(String tabName, int page) async {
  dynamic body = await getTabListData(tabName, page);
  return FuliItem.parseList(body);
}

///获取文章列表
Future<List<ArticleItem>> getArticleListData(String tabName, int page) async {
  dynamic body = await getTabListData(tabName, page);
  return ArticleItem.parseList(body);
}
