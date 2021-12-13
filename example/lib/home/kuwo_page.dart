import 'package:flutter/material.dart';
import 'package:music_api/api/kuwo/kuwo.dart';

class KuwoPage extends StatefulWidget {
  const KuwoPage({Key? key}) : super(key: key);

  @override
  _KuwoPageState createState() => _KuwoPageState();
}

class _KuwoPageState extends State<KuwoPage> with AutomaticKeepAliveClientMixin {
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
                      KuWo?.banner().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('专辑详情'),
                    onTap: () {
                      KuWo?.albumInfo(albumId: "14365066").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌单标签'),
                    onTap: () {
                      KuWo?.playListTag().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌单列表'),
                    onTap: () {
                      KuWo?.playList(tagId: "1848").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌单详情'),
                    onTap: () {
                      KuWo?.playListInfo(id: "3282329134").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('榜单列表'),
                    onTap: () {
                      KuWo?.bangList().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('榜单详情'),
                    onTap: () {
                      KuWo?.bangInfo(id: "93").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌手列表'),
                    onTap: () {
                      KuWo?.artistList().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌手详情'),
                    onTap: () {
                      KuWo?.artistInfo(artistId: "336").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌手单曲'),
                    onTap: () {
                      KuWo?.artistMusic(artistId: "336").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌手专辑'),
                    onTap: () {
                      KuWo?.artistAlbum(artistId: "336").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌手MV'),
                    onTap: () {
                      KuWo?.artistMv(artistId: "336").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('MV推荐，最新MV'),
                    onTap: () {
                      KuWo?.mvList().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌曲，MV播放地址'),
                    onTap: () {
                      KuWo?.playUrl(mid: "202943307", type: "music").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌曲信息'),
                    onTap: () {
                      KuWo?.musicInfo(mid: "142655450").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌词'),
                    onTap: () {
                      KuWo?.musicLrc(musicId: "142655450").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('搜索热词'),
                    onTap: () {
                      KuWo?.hotSearch().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('搜索单曲'),
                    onTap: () {
                      KuWo?.searchMusic(key: "周杰伦").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('搜索专辑'),
                    onTap: () {
                      KuWo?.searchAlbum(key: "周杰伦").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('搜索MV'),
                    onTap: () {
                      KuWo?.searchMv(key: "周杰伦").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('搜索歌单'),
                    onTap: () {
                      KuWo?.searchPlayList(key: "周杰伦").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('搜索歌手'),
                    onTap: () {
                      KuWo?.searchArtist(key: "周杰伦").then(onData).catchError(onError);
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
