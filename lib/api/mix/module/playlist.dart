part of '../mix_music.dart';

///歌单推荐
Future<Answer> _playlistRec({List<MusicSite> site = allSite}) async {
  var value = await Future.wait(site.map((e) {
    switch (e) {
      case MusicSite.KuWo:
        return KuWo.playListRec();
      case MusicSite.MiGu:
        return MiGu.playListNewWeb();
      case MusicSite.KuGou:
        return KuGou.playList();
      case MusicSite.Baidu:
        return Baidu.playlistRec();
      case MusicSite.Netease:
        return Netease.personalized(size: 10);
      case MusicSite.QQ:
        return QQ.playlistHot();
      default:
        return Future.value(const Answer(site: MusicSite.None, code: 200));
    }
  }).toList());

  try {
    var datas = value
        .map((e) {
          switch (e.site) {
            case MusicSite.KuWo:
              try {
                var datas = (e.data["data"]?["list"] as List?)
                    ?.map((e) => {
                          "site": MusicSite.KuWo.name,
                          "id": e["id"],
                          "pic": e["img"],
                          "title": e["name"],
                          "listenCount": e["listencnt"],
                        })
                    .where((element) => element["id"] != null)
                    .toList();
                return {"site": MusicSite.KuWo.name, "data": datas ?? []};
              } catch (e) {
                return {"site": MusicSite.KuWo.name, "data": []};
              }
            case MusicSite.MiGu:
              try {
                var datas = ((e.data["data"] as List?)?.first?["items"] as List?)
                    ?.map((e) => {
                          "site": MusicSite.MiGu.name,
                          "id": e["id"],
                          "pic": "https:${e["image"]}",
                          "title": e["title"],
                          "listenCount": e["playTimes"],
                        })
                    .where((element) => element["id"] != null)
                    .toList();
                return {"site": MusicSite.MiGu.name, "data": datas ?? []};
              } catch (e) {
                return {"site": MusicSite.MiGu.name, "data": []};
              }
            case MusicSite.KuGou:
              try {
                var datas = (e.data["plist"]?["list"]?["info"] as List?)
                    ?.map((e) => {
                          "site": MusicSite.KuGou.name,
                          "id": e["specialid"],
                          "pic": e["imgurl"].toString().replaceAll("{size}", "400"),
                          "title": e["specialname"],
                          "subTitle": e["intro"],
                          "listenCount": e["playcount"],
                        })
                    .where((element) => element["id"] != null)
                    .toList()
                    .sublist(0, 10);
                return {"site": MusicSite.KuGou.name, "data": datas ?? []};
              } catch (e) {
                return {"site": MusicSite.KuGou.name, "data": []};
              }
            case MusicSite.Baidu:
              try {
                var datas = (e.data["data"]?["result"] as List?)
                    ?.map((e) => {
                          "site": MusicSite.Baidu.name,
                          "id": e["id"],
                          "pic": "${e["pic"]}@w_200,h_200",
                          "title": e["title"],
                          "subTitle": e["desc"],
                        })
                    .where((element) => element["id"] != null)
                    .toList();
                return {"site": MusicSite.Baidu.name, "data": datas ?? []};
              } catch (e) {
                return {"site": MusicSite.Baidu.name, "data": []};
              }
            case MusicSite.Netease:
              try {
                var datas = (e.data["result"] as List?)
                    ?.map((e) => {
                          "site": MusicSite.Netease.name,
                          "id": e["id"],
                          "pic": "${e["picUrl"]}?imageView=1&thumbnail=300x0",
                          "title": e["name"],
                          "subTitle": e["copywriter"],
                          "listenCount": e["playCount"],
                        })
                    .where((element) => element["id"] != null)
                    .toList();
                return {"site": MusicSite.Netease.name, "data": datas ?? []};
              } catch (e) {
                return {"site": MusicSite.Netease.name, "data": []};
              }
            case MusicSite.QQ:
              try {
                var datas = (e.data["hotRecommend"]?["data"]?["v_hot"] as List?)
                    ?.map((e) => {
                          "site": MusicSite.QQ.name,
                          "id": e["content_id"],
                          "pic": e["cover"],
                          "title": e["title"],
                          "listenCount": e["listen_num"],
                        })
                    .where((element) => element["id"] != null)
                    .toList();
                return {"site": MusicSite.QQ.name, "data": datas ?? []};
              } catch (e) {
                return {"site": MusicSite.QQ.name, "data": []};
              }
            default:
              return {};
          }
        })
        .where((element) => element.isNotEmpty)
        .toList();
    return Answer(site: MusicSite.Mix, data: datas);
  } catch (e) {
    if (kDebugMode) {
      print("歌曲列表异常：" + e.toString());
    }
    return const Answer(site: MusicSite.Mix, data: []);
  }
}

///歌单详情
Future<Answer> _playlistInfo({required String id, required String siteName}) async {
  var site = MusicSite.values.firstWhere((element) => element.name == siteName);

  Future<Answer> playListInfo;

  switch (site) {
    case MusicSite.KuWo:
      playListInfo = KuWo.playListInfoAll(id: id);
      break;
    case MusicSite.MiGu:
      playListInfo = MiGu.playListInfo(id: id);
      break;
    case MusicSite.KuGou:
      playListInfo = KuGou.playListInfoAll(id: id);
      break;
    case MusicSite.Baidu:
      playListInfo = Baidu.playListInfo(id: id, size: 500);
      break;
    case MusicSite.Netease:
      playListInfo = Netease.playlistTrackAll(id: id);
      break;
    case MusicSite.QQ:
      playListInfo = QQ.playlistInfo(id: int.parse(id));
      break;
    default:
      return Future.value(const Answer(site: MusicSite.None, code: 200));
  }
  var data = (await playListInfo).data;
  Map playlist;

  switch (site) {
    case MusicSite.KuWo:
      try {
        playlist = PlayList(
          site: MusicSite.KuWo,
          id: data["id"],
          pic: data["img"],
          title: data["name"],
          desc: data["intro"],
          songCount: data["total"],
          songs: (data["musicList"] as List?)
              ?.map(
                (e) => Song(
                  site: MusicSite.KuWo,
                  id: e["musicrid"],
                  pic: e["pic"],
                  title: e["name"],
                  subTitle: e["artist"],
                  artist: [Artist(id: e["artistid"], name: e["artist"])],
                  album: Album(site: MusicSite.KuWo, id: e["albumid"], title: e["album"], pic: e["albumpic"]),
                ),
              )
              .toList(),
        );
      } catch (e) {
        return Answer(site: MusicSite.Mix, code: 500, msg: "${MusicSite.KuWo.name}:${e.toString()}");
      }
      break;
    case MusicSite.MiGu:
      try {
        var info = data["data"];
        playlist = PlayList(
          site: MusicSite.MiGu,
          id: info["musicListId"],
          pic: info["imgItem"]["img"],
          title: info["title"],
          desc: info["summary"],
          songCount: info["musicNum"],
          songs: (info["musicList"] as List?)
              ?.map(
                (e) => Song(
                  site: MusicSite.MiGu,
                  id: e["songId"],
                  contentId: e["contentId"],
                  pic: "http://d.musicapp.migu.cn${e["img1"]}",
                  title: e["songName"],
                  subTitle: (e["singerList"] as List?)?.map((e) => e["name"]).join(","),
                  artist: (e["singerList"] as List?)?.map((e) => Artist(id: e["id"], name: e["name"], pic: "http://d.musicapp.migu.cn${e["img"]}")).toList(),
                  album: Album(site: MusicSite.MiGu, id: e["albumId"], title: e["album"], pic: "http://d.musicapp.migu.cn${e["img1"]}"),
                ),
              )
              .toList(),
        );
      } catch (e) {
        return Answer(site: MusicSite.Mix, code: 500, msg: "${MusicSite.MiGu.name}:${e.toString()}");
      }
      break;
    case MusicSite.KuGou:
      try {
        playlist = PlayList(
            site: MusicSite.KuGou,
            id: data["specialid"],
            pic: "${data["imgurl"]}".replaceFirst("{size}", "400"),
            title: data["specialname"],
            desc: data["intro"],
            songCount: data["songcount"],
            songs: (data["songs"] as List?)
                ?.map((e) => Song(
                      site: MusicSite.KuGou,
                      id: e?["hash"],
                      albumAudioId: e?["album_audio_id"],
                      pic: e?["img"].toString().replaceFirst("stdmusic", "stdmusic/400").replaceAll("{size}", ""),
                      title: e?["song_name"],
                      subTitle: e?["author_name"],
                      artist: [Artist(id: e?["author_id"], name: e?["author_name"])],
                      url: e?["play_url"],
                      lyric: e?["lyrics"],
                      album: Album(
                          site: MusicSite.KuGou,
                          id: e?["album_id"],
                          title: e?["album_name"],
                          pic: e?["img"].toString().replaceFirst("stdmusic", "stdmusic/400").replaceAll("{size}", "")),
                    ))
                .toList());
      } catch (e) {
        return Answer(site: MusicSite.Mix, code: 500, msg: "${MusicSite.KuGou.name}:${e.toString()}");
      }
      break;
    case MusicSite.Baidu:
      try {
        var info = data["data"];
        playlist = PlayList(
            site: MusicSite.Baidu,
            id: info["id"],
            pic: "${info["pic"]}@w_200,h_200",
            title: info["title"],
            desc: info["desc"],
            songCount: info["trackCount"],
            songs: (info["trackList"] as List?)
                ?.map((e) => Song(
                      site: MusicSite.Baidu,
                      id: e["assetId"],
                      pic: "${e["pic"]}@w_200,h_200",
                      title: e["title"],
                      artist: (e["artist"] as List?)?.map((e) => Artist(id: e["artistCode"], name: e["name"], pic: "${e["pic"]}@w_200,h_200")).toList(),
                      album: Album(site: MusicSite.Baidu, id: e["albumAssetCode"], title: e["albumTitle"], pic: "${e["pic"]}@w_200,h_200"),
                      lyric: e["lyric"],
                      subTitle: (e["artist"] as List?)?.map((e) => e["name"]).join(","),
                    ))
                .toList());
      } catch (e) {
        return Answer(site: MusicSite.Mix, code: 500, msg: "${MusicSite.Baidu.name}:${e.toString()}");
      }
      break;
    case MusicSite.Netease:
      try {
        playlist = PlayList(
            site: MusicSite.Netease,
            id: data["id"],
            pic: "${data["coverImgUrl"]}?imageView=1&thumbnail=300x0",
            title: data["name"],
            desc: data["description"],
            songCount: data["trackCount"],
            songs: (data["songs"] as List?)
                ?.map((e) => Song(
                      site: MusicSite.Netease,
                      id: e["id"],
                      pic: "${e["al"]?["picUrl"]}?imageView=1&thumbnail=300x0",
                      title: e["name"],
                      subTitle: (e["ar"] as List?)?.map((e) => e["name"]).join(","),
                      artist: (e["ar"] as List?)?.map((e) => Artist(id: e["id"], name: e["name"])).toList(),
                      album: Album(site: MusicSite.Netease, id: e["al"]?["id"], title: e["al"]?["name"], pic: "${e["al"]?["picUrl"]}?imageView=1&thumbnail=300x0"),
                    ))
                .toList());
      } catch (e) {
        return Answer(site: MusicSite.Mix, code: 500, msg: "${MusicSite.Netease.name}:${e.toString()}");
      }
      break;
    case MusicSite.QQ:
      try {
        var info = data["playlist"]["data"]["dirinfo"];
        var songs = data["playlist"]["data"]["songlist"] as List?;
        playlist = PlayList(
            site: MusicSite.QQ,
            id: info["id"],
            pic: info["picurl"],
            title: info["title"],
            desc: info["desc"],
            songCount: info["songnum"],
            songs: songs
                ?.map((e) => Song(
                      site: MusicSite.QQ,
                      id: e["id"],
                      mid: e["mid"],
                      mediaId: e["file"]?["media_mid"],
                      pic: "https://y.qq.com/music/photo_new/T002R300x300M000${e["album"]?["pmid"]}.jpg",
                      title: e["name"],
                      subTitle: (e["singer"] as List?)?.map((e) => e["title"]).join(","),
                      artist: (e["singer"] as List?)
                          ?.map((e) => Artist(id: e["mid"], name: e["title"], pic: "https://y.qq.com/music/photo_new/T002R300x300M000${e["mid"]}.jpg"))
                          .toList(),
                      album: Album(
                          site: MusicSite.QQ,
                          id: e["album"]?["mid"],
                          title: e["album"]?["title"],
                          pic: "https://y.qq.com/music/photo_new/T002R300x300M000${e["album"]?["pmid"]}.jpg"),
                    ))
                .toList());
      } catch (e) {
        return Answer(site: MusicSite.Mix, code: 500, msg: "${MusicSite.QQ.name}:${e.toString()}");
      }
      break;
    default:
      return const Answer(site: MusicSite.Mix, code: 500, msg: "未知站点");
  }

  return Answer(site: MusicSite.Mix, data: playlist);
}
