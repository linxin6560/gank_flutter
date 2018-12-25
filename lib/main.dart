import 'package:flutter/material.dart';
import 'package:gank_flutter/ui/tab_page/fuli_list_page.dart';
import 'package:gank_flutter/ui/tab_page/article_list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Gank'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  static List<String> _tabTitles = ['福利', 'Android', 'iOS', '前端', '休息视频', '拓展资源', '全部'];
  TabController _tabController;
  List<Widget> _pageList = [];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: _tabTitles.length, vsync: this);
    for (var title in _tabTitles) {
      Widget child;
      if (title == _tabTitles[0]) {
        child = WelfarePage(title);
      } else {
        child = ArticleListPage(title);
      }
      _pageList.add(child);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            controller: _tabController,
            tabs: _tabTitles.map((String title) {
              return new Tab(text: title);
            }).toList()),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _pageList,
      ),
    );
  }
}
