import 'package:flutter/material.dart';
import 'package:music_api_example/home/kuwo_page.dart';

import 'baidu_page.dart';
import 'my_free_mp3_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController? tabController;

  var pages = {
    "MyFreeMp3": const MyFreeMp3Page(),
    "百度": const BaiduPage(),
    "酷我": const KuwoPage(),
  };

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: pages.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("API测试"),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 50),
            child: TabBar(
              isScrollable: true,
              controller: tabController,
              tabs: pages.keys.map((e) => Tab(text: e)).toList(),
            ),
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: pages.values.toList(),
        ));
  }
}
