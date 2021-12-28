import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:music_api/api/baidu/baidu.dart';

class BaiduPage extends StatefulWidget {
  const BaiduPage({Key? key}) : super(key: key);

  @override
  _BaiduPageState createState() => _BaiduPageState();
}

class _BaiduPageState extends State<BaiduPage> with AutomaticKeepAliveClientMixin {
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
                    title: const Text('开屏广告(可能为空)'),
                    onTap: () {
                      Baidu?.openScreen().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('首页'),
                    onTap: () {
                      Baidu?.index().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('专辑列表(最新专辑)'),
                    onTap: () {
                      Baidu?.albumList().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('专辑详情'),
                    onTap: () {
                      Baidu?.albumInfo(albumAssetCode: "P10003979544").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌曲列表(新歌推荐)'),
                    onTap: () {
                      Baidu?.songList().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌曲详情'),
                    onTap: () {
                      Baidu?.songInfo(tsId: "T10062508184").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌曲下载'),
                    onTap: () {
                      Baidu?.songDownload(tsId: "T10062508184").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌手列表'),
                    onTap: () {
                      Baidu?.artistList().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌手信息'),
                    onTap: () {
                      Baidu?.artistInfo(artistCode: "A10047720").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌手歌曲'),
                    onTap: () {
                      Baidu?.artistSong(artistCode: "A10047720").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌手专辑'),
                    onTap: () {
                      Baidu?.artistAlbum(artistCode: "A10047720").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌手视频'),
                    onTap: () {
                      Baidu?.artistVideo(artistCode: "A10047720").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('搜索'),
                    onTap: () {
                      Baidu?.search(word: "薛之谦").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('搜索热词'),
                    onTap: () {
                      Baidu?.searchSug(word: "薛之谦").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('榜单类型'),
                    onTap: () {
                      Baidu?.rankType().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('榜单歌曲列表'),
                    onTap: () {
                      Baidu?.rankList(bdid: "257851").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌单分类'),
                    onTap: () {
                      Baidu?.playListType().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌单列表'),
                    onTap: () {
                      Baidu?.playList(subCateId: "2368").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌单详情'),
                    onTap: () {
                      Baidu?.playListInfo(id: '285994').then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('视频列表'),
                    onTap: () {
                      Baidu?.videoList().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('视频详情'),
                    onTap: () {
                      Baidu?.videoInfo(assetCode: 'V10000002698').then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('视频推荐'),
                    onTap: () {
                      Baidu?.videoRecommend().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('视频下载'),
                    onTap: () {
                      Baidu?.videoDownload(assetCode: 'V10000002698').then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('短信验证码'),
                    onTap: () {
                      Baidu?.sendSms(phone: '15612345678').then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('登录'),
                    onTap: () {
                      Baidu?.login(phone: '15612345678', code: "7223").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('账户信息'),
                    onTap: () {
                      Baidu?.accountInfo(cookie: [Cookie("auth", "NjVhNTMzM2QyZWEyZTlhOTI5OTJiMjZiNWE2YTkwMjY=")]).then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('签到'),
                    onTap: () {
                      Baidu?.signIn(cookie: [Cookie("auth", "NjVhNTMzM2QyZWEyZTlhOTI5OTJiMjZiNWE2YTkwMjY=")]).then(onData).catchError(onError);
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

  void onData(value) {
    setState(() {
      result = value.body.toString();
    });
  }

  void onError(e) {
    setState(() {
      result = e.toString();
    });
  }
}
