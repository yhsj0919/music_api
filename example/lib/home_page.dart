import 'package:flutter/material.dart';

import 'baidu_page.dart';
import 'my_free_mp3_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
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
              tabs: const [
                Tab(text: 'MyFreeMp3'),
                Tab(text: '百度'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: const [
            MyFreeMp3Page(),
            BaiduPage(),
          ],
        ));
  }
}
