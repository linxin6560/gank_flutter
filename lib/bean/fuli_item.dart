class FuliItem {
  String createdAt;
  String publishedAt;
  String url;
  String who;

  @override
  String toString() {
    return '_Item{createdAt: $createdAt, publishedAt: $publishedAt, url: $url, who: $who}';
  }

  static List<FuliItem> parseList(dynamic body) {
    dynamic results = body["results"];
    List<FuliItem> list = [];
    for (var item in results) {
      list.add(fromJson(item));
    }
    return list;
  }

  static FuliItem fromJson(dynamic json) {
    FuliItem item = new FuliItem();
    item.createdAt = json["createdAt"];
    item.publishedAt = json["publishedAt"];
    item.url = json["url"];
    item.who = json["who"];
    return item;
  }
}
