import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:music_api/api/migu/migu.dart';

class MiGuPage extends StatefulWidget {
  const MiGuPage({Key? key}) : super(key: key);

  @override
  _MiGuPageState createState() => _MiGuPageState();
}

class _MiGuPageState extends State<MiGuPage> with AutomaticKeepAliveClientMixin {
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
                      MiGu.banner().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('新碟上架Web'),
                    onTap: () {
                      MiGu.albumNewWeb().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('新碟类型'),
                    onTap: () {
                      MiGu.albumNewType().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('新碟上架'),
                    onTap: () {
                      MiGu.albumNew(columnId: "15279065").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('专辑歌曲'),
                    onTap: () {
                      MiGu.albumSong(albumId: '1136495459', type: "2003").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('专辑歌曲2'),
                    onTap: () {
                      MiGu.albumSong2(albumId: '1136495459').then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('专辑信息'),
                    onTap: () {
                      MiGu.albumInfo(albumId: '1136495459', type: "2003").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('专辑信息2'),
                    onTap: () {
                      MiGu.albumInfo2(albumId: '1136495459').then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('MV信息'),
                    onTap: () {
                      MiGu.mvInfo(mvId: "600906000000337596").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('MV播放地址,上面接口返回的'),
                    onTap: () {
                      MiGu.mvPlayUrl(
                        contentId: "600906000000337596",
                        mvCopyrightId: "600846Y0958",
                        format: "050012",
                        size: "90945275",
                        url:
                            "/PmeXt%2FJkph%2FGY9oGZIn%2BrnuIohQqAlHDNzPQW3eR0XClFjPwu50LmEzWRhw28uE7R5cJktVMTOzJXeMAMD4s6%2FHoohaZwztCZeX0%2F8V4SgKvOe9CTKEabthWaTmi1bnRY1CkU%2BF8w6Q7n9bzYo3zMsjcjimuJF%2BDSkO6UYVjmzWz97CQL6%2By771Gjr1Q0FfaBkhsIIPbf8bdbEaaJDQB2Q%3D%3D/600846Y0958033950.mp4?ec=2&flag=+&F=050012",
                      ).then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('MV推荐'),
                    onTap: () {
                      MiGu.mvRec(mvId: "600906000000337596").then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                      title: const Text('歌单推荐(web)'),
                      onTap: () {
                        MiGu.playListNewWeb().then(onData).catchError(onError);
                      }),
                  ListTile(
                      title: const Text('歌单热门标签'),
                      onTap: () {
                        MiGu.playListHotTag().then(onData).catchError(onError);
                      }),
                  ListTile(
                      title: const Text('歌单热门推荐(歌单最顶上的几个)'),
                      onTap: () {
                        MiGu.playListRec().then(onData).catchError(onError);
                      }),
                  ListTile(
                      title: const Text('歌单标签'),
                      onTap: () {
                        MiGu.playListTagList().then(onData).catchError(onError);
                      }),
                  ListTile(
                      title: const Text('歌单(根据标签ID获取)'),
                      onTap: () {
                        MiGu.playList(tagId: "1003449727").then(onData).catchError(onError);
                      }),
                  ListTile(
                      title: const Text('歌单信息'),
                      onTap: () {
                        MiGu.playListInfo(id: '169018447').then(onData).catchError(onError);
                      }),
                  ListTile(
                      title: const Text('歌单歌曲'),
                      onTap: () {
                        MiGu.playListSong(id: '169018447').then(onData).catchError(onError);
                      }),
                  ListTile(
                      title: const Text('歌单播放量'),
                      onTap: () {
                        MiGu.playListPlayNum(contentIds: ['169018447'], contentTypes: ['2021']).then(onData).catchError(onError);
                      }),
                  ListTile(
                      title: const Text('新歌(web)'),
                      onTap: () {
                        MiGu.songNewWeb().then(onData).catchError(onError);
                      }),
                  ListTile(
                      title: const Text('新歌类型'),
                      onTap: () {
                        MiGu.songNewType().then(onData).catchError(onError);
                      }),
                  ListTile(
                      title: const Text('新歌列表'),
                      onTap: () {
                        MiGu.songNew(columnId: "15279290").then(onData).catchError(onError);
                      }),
                  ListTile(
                      title: const Text('播放地址'),
                      onTap: () {
                        MiGu.playUrl(songId: "1140285302", toneFlag: "PQ").then(onData).catchError(onError);
                      }),
                  ListTile(
                      title: const Text('播放地址2(根据contentId获取播放地址，支持更多格式，更少限制)'),
                      onTap: () {
                        MiGu.playUrl2(contentId: "600919000009210681", toneFlag: "HQ").then(onData).catchError(onError);
                      }),
                  ListTile(
                      title: const Text('榜单'),
                      onTap: () {
                        MiGu.rankList().then(onData).catchError(onError);
                      }),
                  ListTile(
                      title: const Text('榜单详情'),
                      onTap: () {
                        MiGu.rankInfo(rankId: "27553319").then(onData).catchError(onError);
                      }),
                  ListTile(
                      title: const Text('歌手Tabs，这个返回值写死了，没走接口'),
                      onTap: () {
                        MiGu.singerTabs().then(onData).catchError(onError);
                      }),
                  ListTile(
                      title: const Text('歌手列表'),
                      onTap: () {
                        MiGu.singer(tab: "huayu-nan").then(onData).catchError(onError);
                      }),
                  ListTile(
                      title: const Text('歌手信息'),
                      onTap: () {
                        MiGu.singerInfo(id: "112").then(onData).catchError(onError);
                      }),
                  ListTile(
                      title: const Text('歌手单曲'),
                      onTap: () {
                        MiGu.singerSongs(id: "112").then(onData).catchError(onError);
                      }),
                  ListTile(
                      title: const Text('歌手专辑'),
                      onTap: () {
                        MiGu.singerAlbum(id: "112").then(onData).catchError(onError);
                      }),
                  ListTile(
                      title: const Text('歌手Mv'),
                      onTap: () {
                        MiGu.singerMv(id: "112").then(onData).catchError(onError);
                      }),
                  ListTile(
                      title: const Text('搜索热词'),
                      onTap: () {
                        MiGu.searchHotWord().then(onData).catchError(onError);
                      }),
                  ListTile(
                      title: const Text('搜索'),
                      onTap: () {
                        MiGu.search(keyWord: "薛之谦").then(onData).catchError(onError);
                      }),
                  ListTile(
                      title: const Text('搜索建议'),
                      onTap: () {
                        MiGu.searchSuggest(keyword: "薛之谦").then(onData).catchError(onError);
                      }),
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
      result = json.encode(value.data);
      if (kDebugMode) {
        print(result);
      }
    });
  }

  void onError(e) {
    setState(() {
      result = e.toString();
    });
  }
}
