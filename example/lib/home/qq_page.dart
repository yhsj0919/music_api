import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music_api/api/qq/qq.dart';
import 'package:music_api/utils/answer.dart';

class QQPage extends StatefulWidget {
  const QQPage({Key? key}) : super(key: key);

  @override
  _QQPageState createState() => _QQPageState();
}

class _QQPageState extends State<QQPage> with AutomaticKeepAliveClientMixin {
  String result = "";
  String qrsig = "";
  String qr = "";
  List<Cookie> cookie = [];

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
        children: [ Container(
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
          qr.isNotEmpty?
          Image.memory(
            base64Decode(qr),
            //防止重绘
            gaplessPlayback: true,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ):Container(),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 40),
                children: [
                  ListTile(
                    title: const Text('登陆二维码'),
                    onTap: () {
                      QQ.loginQr().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('二维码校验'),
                    onTap: () {
                      QQ.loginQrCheck(qrsig: qrsig, cookie: cookie).then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('首页'),
                    onTap: () {
                      QQ.home().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('Banner'),
                    onTap: () {
                      QQ.banner().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('新专辑、新碟'),
                    onTap: () {
                      QQ.albumNew().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('专辑歌曲'),
                    onTap: () {
                      QQ.albumSong(albumMid: "003cu5bo2QImjv").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('专辑信息'),
                    onTap: () {
                      QQ.albumInfo(albumMid: "003cu5bo2QImjv").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('MV推荐'),
                    onTap: () {
                      QQ.mvRec().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('MV列表'),
                    onTap: () {
                      QQ.mvList().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('MV信息'),
                    onTap: () {
                      QQ.mvInfo(vid: "q0034sb9eru").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('MV播放地址'),
                    onTap: () {
                      QQ.mvUrl(vid: "a0041iztbq1").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌单列表'),
                    onTap: () {
                      QQ.playlist().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('热门歌单'),
                    onTap: () {
                      QQ.playlistHot().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('根据tag获取歌单'),
                    onTap: () {
                      QQ.playlistByTag(tag: 3317).then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌单详情'),
                    onTap: () {
                      QQ.playlistInfo(id: 8251015081).then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('全部歌单分类'),
                    onTap: () {
                      QQ.playlistTag().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('电台列表'),
                    onTap: () {
                      QQ.radioList().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('电台详情'),
                    onTap: () {
                      QQ.radioInfo(id: 99).then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('热门搜索'),
                    onTap: () {
                      QQ.searchHot().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('搜索建议'),
                    onTap: () {
                      QQ.searchSuggest(keyWord: "周杰伦").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('搜索'),
                    onTap: () {
                      QQ.search(keyWord: "周杰伦").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌手列表'),
                    onTap: () {
                      QQ.singerList().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌手详情'),
                    onTap: () {
                      QQ.singerInfo(singerMid: "0025NhlN2yWrP4").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌手单曲'),
                    onTap: () {
                      QQ.singerSong(singerMid: "0025NhlN2yWrP4").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌手专辑'),
                    onTap: () {
                      QQ.singerAlbum(singerMid: "0025NhlN2yWrP4").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌手MV'),
                    onTap: () {
                      QQ.singerMV(singerMid: "0025NhlN2yWrP4").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('相似歌手'),
                    onTap: () {
                      QQ.singerSimilar(singerMid: "0025NhlN2yWrP4").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('新歌首发'),
                    onTap: () {
                      QQ.songNew().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌曲信息'),
                    onTap: () {
                      QQ.songInfo(songMid: "001zMQr71F1Qo8", songId: 718477).then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌词'),
                    onTap: () {
                      QQ.songLyric(songMid: "001zMQr71F1Qo8", songId: 718477).then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌词2'),
                    onTap: () {
                      QQ.songLyric2(songMid: "001zMQr71F1Qo8", songId: 718477).then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌曲相关MV'),
                    onTap: () {
                      QQ.songMv(songMid: "001zMQr71F1Qo8").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌曲相关歌单'),
                    onTap: () {
                      QQ.songPlayList(songId: 718477).then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌曲试听地址'),
                    onTap: () {
                      QQ.songListen(songMid: "001zMQr71F1Qo8", mediaMid: "0024jrso28p8VA").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌曲下载'),
                    onTap: () {
                      QQ.songDownload(songMid: "001zMQr71F1Qo8", mediaMid: "0024jrso28p8VA").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('榜单列表'),
                    onTap: () {
                      QQ.rankList().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('榜单详情'),
                    onTap: () {
                      QQ.rankInfo(topId: 201).then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('mv榜单,榜单是MV的时候用这个'),
                    onTap: () {
                      QQ.mvRank().then(onData).catchError(onError);
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

      if (value.data["qrsig"] != null) {
        qrsig = value.data["qrsig"].toString();
      }

      if (value.data["qr"] != null) {
        qr = value.data["qr"].toString();
      }
      if (value.cookie.isNotEmpty) {
        cookie = value.cookie;
      }

      print(result);
      // print(cookie);
      // print(value.data["qrsig"]);
    });
  }

  void onError(e) {
    print(e);
    setState(() {
      result = e.toString();
    });
  }
}
