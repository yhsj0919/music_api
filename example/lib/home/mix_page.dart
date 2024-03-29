import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_api/api/mix/mix_music.dart';
import 'package:music_api/utils/answer.dart';

class MixPage extends StatefulWidget {
  const MixPage({Key? key}) : super(key: key);

  @override
  _MixPageState createState() => _MixPageState();
}

class _MixPageState extends State<MixPage> with AutomaticKeepAliveClientMixin {
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
                    title: const Text('Banner'),
                    onTap: () {
                      MixMusic.banner().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌单推荐'),
                    onTap: () {
                      MixMusic.playlistRec().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('新碟上架'),
                    onTap: () {
                      MixMusic.albumNew().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('新歌推荐'),
                    onTap: () {
                      MixMusic.songNew().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('匹配音乐播放地址'),
                    onTap: () {
                      MixMusic.matchMusic(name: "火星人来过", artist: "薛之谦").then(onData).catchError(onError);
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
