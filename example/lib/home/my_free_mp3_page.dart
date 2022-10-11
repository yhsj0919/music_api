import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_api/api/my_free_mp3/my_free_mp3.dart';
import 'package:music_api/utils/answer.dart';

class MyFreeMp3Page extends StatefulWidget {
  const MyFreeMp3Page({Key? key}) : super(key: key);

  @override
  _MyFreeMp3PageState createState() => _MyFreeMp3PageState();
}

class _MyFreeMp3PageState extends State<MyFreeMp3Page> with AutomaticKeepAliveClientMixin {
  String result = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150.0,
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 1),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                child: Text(result, style: const TextStyle(fontSize: 16)),
              ),
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 40),
                children: [
                  ListTile(
                    title: const Text('所有Api'),
                    onTap: () {
                      MyFreeMp3.api("").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('搜索(报错重试即可)'),
                    onTap: () {
                      MyFreeMp3.search(keyWord: "周杰伦").then(onData).catchError(onError);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void onData(Answer value) {
    setState(() {
      result = json.encode(value.data);
      print(result);
    });
  }

  void onError(e) {
    setState(() {
      result = e.toString();
    });
  }
}
