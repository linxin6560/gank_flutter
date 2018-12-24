class ArticleItem{
    String id;
    String createdAt;
    String desc;
    String publishedAt;
    String source;
    String type;
    String url;
    String who;

    @override
    String toString() {
        return 'ArticleItem{id: $id, createdAt: $createdAt, desc: $desc, publishedAt: $publishedAt, source: $source, type: $type, url: $url, who: $who}';
    }

    static List<ArticleItem> parseList(dynamic body) {
        dynamic results = body["results"];
        List<ArticleItem> list = [];
        for (var item in results) {
            list.add(fromJson(item));
        }
        return list;
    }

    static ArticleItem fromJson(dynamic json) {
        ArticleItem item = new ArticleItem();
        item.id = json["_id"];
        item.createdAt = json["createdAt"];
        item.desc = json["desc"];
        item.publishedAt = json["publishedAt"];
        item.source = json["source"];
        item.type = json["type"];
        item.url = json["url"];
        item.who = json["who"];
        return item;
    }
}