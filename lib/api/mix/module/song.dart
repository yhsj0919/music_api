part of '../mix_music.dart';

///新歌
Future<Answer> _songNew({List<MusicSite> site = allSite}) async {
  try {
    var value = await Future.wait(site.map((e) {
      switch (e) {
        case MusicSite.KuWo:
          return KuWo.songNew();
        case MusicSite.MiGu:
          return MiGu.songNewWeb();
        case MusicSite.KuGou:
          return KuGou.musicList();
        case MusicSite.Baidu:
          return Baidu.songList(size: 10);
        case MusicSite.Netease:
          return Netease.songNew();
        case MusicSite.QQ:
          return QQ.songNew();
        default:
          return Future.value(const Answer(site: MusicSite.None, code: 200));
      }
    }).toList());

    var datas = value
        .map((e) {
          switch (e.site) {
            case MusicSite.KuWo:
              var datas = (((e.data["child"] as List?)?.firstWhere((element) => element["type"].toString() == "newmusic_list")?["child"] as List?)?.first?["child"] as List?)
                  ?.map((e) => {
                        "site": MusicSite.KuWo.name,
                        "id": e["data"]?["rid"],
                        "pic": e["data"]?["img"],
                        "title": e["data"]?["name"],
                        "subTitle": e["data"]?["artist"],
                      })
                  .where((element) => element["id"] != null)
                  .toList()
                  .sublist(0, 10);
              return {"site": MusicSite.KuWo.name, "data": datas ?? []};
            case MusicSite.MiGu:
              var datas = ((e.data["data"] as List?)?.last?["items"] as List?)
                  ?.map((e) => {
                        "site": MusicSite.MiGu.name,
                        "id": e["albumId"],
                        "pic": "http:${e["image"]}",
                        "title": e["albumName"],
                        "subTitle": (e["singers"] as List?)?.map((e) => e["singerName"]).join(","),
                      })
                  .where((element) => element["id"] != null)
                  .toList()
                  .sublist(0, 10);
              return {"site": MusicSite.MiGu.name, "data": datas ?? []};
            case MusicSite.KuGou:
              var datas = (e.data["data"] as List?)
                  ?.map((e) => {
                        "site": MusicSite.KuGou.name,
                        "id": e["hash"],
                        "albumAudioId": e["album_audio_id"],
                        "pic": e["album_sizable_cover"].toString().replaceAll("{size}", "400"),
                        "title": e["filename"].toString().split("-")[1],
                        "subTitle": e["filename"].toString().split("-")[0],
                      })
                  .where((element) => element["id"] != null)
                  .toList()
                  .sublist(0, 10);
              return {"site": MusicSite.KuGou.name, "data": datas ?? []};
            case MusicSite.Baidu:
              var datas = (e.data["data"]?["result"] as List?)
                  ?.map((e) => {
                        "site": MusicSite.Baidu.name,
                        "id": e["assetId"],
                        "pic": e["pic"],
                        "title": e["title"],
                        "subTitle": (e["artist"] as List?)?.map((e) => e["name"]).join(","),
                      })
                  .where((element) => element["id"] != null)
                  .toList();
              return {"site": MusicSite.Baidu.name, "data": datas ?? []};
            case MusicSite.Netease:
              var datas = (e.data["data"] as List?)
                  ?.map((e) => {
                        "site": MusicSite.Netease.name,
                        "id": e["id"],
                        "pic": e["album"]?["picUrl"],
                        "title": e["name"],
                        "subTitle": (e["artists"] as List?)?.map((e) => e["name"]).join(","),
                      })
                  .where((element) => element["id"] != null)
                  .toList()
                  .sublist(0, 10);
              return {"site": MusicSite.Netease.name, "data": datas ?? []};
            case MusicSite.QQ:
              var datas = (e.data["newSong"]?["data"]?["songlist"] as List?)
                  ?.map((e) => {
                        "site": MusicSite.QQ.name,
                        "id": e["mid"],
                        "pic": "https://y.qq.com/music/photo_new/T002R300x300M000${e["album"]?["pmid"]}.jpg",
                        "title": e["name"],
                        "subTitle": (e["singer"] as List?)?.map((e) => e["name"]).join(","),
                      })
                  .where((element) => element["id"] != null)
                  .toList()
                  .sublist(0, 10);
              return {"site": MusicSite.QQ.name, "data": datas ?? []};
            default:
              return {};
          }
        })
        .where((element) => element.isNotEmpty)
        .toList();
    return Answer(site: MusicSite.Mix, data: datas);
  } catch (e) {
    print("歌曲列表异常：" + e.toString());
    return const Answer(site: MusicSite.Mix, data: []);
  }
}

///匹配音乐播放地址
Future<Answer> _matchMusic({String? name, String? artist, List<MusicSite> site = allSite}) async {
  var keyWord = "$name $artist";

  try {
    var value = await Future.wait(site.map((e) {
      switch (e) {
        case MusicSite.KuWo:
          return KuWo.searchMusic(keyWord: keyWord, size: 10);
        case MusicSite.MiGu:
          return MiGu.search(keyWord: keyWord, size: 10);
        case MusicSite.MyFreeMp3:
          return MyFreeMp3.search(keyWord: keyWord);
        case MusicSite.KuGou:
          return KuGou.searchSong(keyword: keyWord, size: 10);
        case MusicSite.Baidu:
          return Baidu.search(keyWord: keyWord, type: 1, size: 10);
        case MusicSite.Netease:
          return Netease.search(keyWord: keyWord, size: 10);
        case MusicSite.QQ:
          return QQ.search(keyWord: keyWord, size: 10);
        default:
          return Future.value(const Answer(site: MusicSite.None));
      }
    }));

    var datas = value
        .map((e) {
          switch (e.site) {
            case MusicSite.KuWo:
              return (e.data["data"]?["list"] as List?)
                      ?.map((e) => {
                            "site": MusicSite.KuWo.name,
                            "id": e["rid"],
                            "name": e["name"],
                            "artist": e["artist"],
                          })
                      .firstWhere(
                          (element) =>
                              element["name"].toString().toLowerCase() == name.toString().toLowerCase() &&
                              element["artist"].toString().toLowerCase().contains(artist?.toLowerCase() ?? ""),
                          orElse: () => {}) ??
                  {};
            case MusicSite.MiGu:
              return (e.data["songResultData"]?["result"] as List?)
                      ?.map((e) => {
                            "site": MusicSite.MiGu.name,
                            "id": e["contentId"],
                            "name": e["name"],
                            "artist": (e["artists"] as List?)?.map((e) => e["name"]).join(","),
                          })
                      .firstWhere(
                          (element) =>
                              element["name"].toString().toLowerCase().contains("${name?.toLowerCase()}") &&
                              element["artist"].toString().toLowerCase().contains(artist?.toLowerCase() ?? ""),
                          orElse: () => {}) ??
                  {};

            case MusicSite.MyFreeMp3:
              return (e.data["data"] as List?)
                      ?.map((e) => {
                            "site": MusicSite.MyFreeMp3.name,
                            "id": e["id"],
                            "name": e["name"],
                            "artist": (e["artist"] as List?)?.map((e) => e["name"]).join(","),
                            "url": (e["url"] as List?)?.firstWhere((element) => element["format"] == "HQ")?["url"],
                          })
                      .firstWhere(
                          (element) =>
                              element["name"].toString().toLowerCase() == name.toString().toLowerCase() &&
                              element["artist"].toString().toLowerCase().contains(artist?.toLowerCase() ?? ""),
                          orElse: () => {}) ??
                  {};
            case MusicSite.KuGou:
              return (e.data["data"]?["info"] as List?)
                      ?.map((e) => {
                            "site": MusicSite.KuGou.name,
                            "id": e["hash"],
                            "albumAudioId": e["album_audio_id"],
                            "name": e["songname"],
                            "artist": e["singername"],
                          })
                      .firstWhere(
                          (element) =>
                              element["name"].toString().toLowerCase() == name.toString().toLowerCase() &&
                              element["artist"].toString().toLowerCase().contains(artist?.toLowerCase() ?? ""),
                          orElse: () => {}) ??
                  {};
            case MusicSite.Baidu:
              return (e.data["data"]?["typeTrack"] as List?)
                      ?.map((e) => {
                            "site": MusicSite.Baidu.name,
                            "id": e["TSID"],
                            "name": e["title"],
                            "artist": (e["artist"] as List?)?.map((e) => e["name"]).join(","),
                          })
                      .firstWhere(
                          (element) =>
                              element["name"].toString().toLowerCase() == name.toString().toLowerCase() &&
                              element["artist"].toString().toLowerCase().contains(artist?.toLowerCase() ?? ""),
                          orElse: () => {}) ??
                  {};
            case MusicSite.Netease:
              return (e.data["result"]?["songs"] as List?)
                      ?.map((e) => {
                            "site": MusicSite.Netease.name,
                            "id": e["id"],
                            "name": e["name"],
                            "artist": (e["artists"] as List?)?.map((e) => e["name"]).join(","),
                          })
                      .firstWhere(
                          (element) =>
                              element["name"].toString().toLowerCase() == name.toString().toLowerCase() &&
                              element["artist"].toString().toLowerCase().contains(artist?.toLowerCase() ?? ""),
                          orElse: () => {}) ??
                  {};
            case MusicSite.QQ:
              return (e.data["req"]?["data"]?["body"]?["item_song"] as List?)
                      ?.map((e) => {
                            "site": MusicSite.QQ.name,
                            "id": e["mid"],
                            "mediaId": e["file"]["media_mid"],
                            "name": e["name"].toString(),
                            "artist": (e["singer"] as List?)?.map((e) => e["name"]).join(","),
                          })
                      .firstWhere(
                          (element) =>
                              element["name"].toString().toLowerCase() == name.toString().toLowerCase() &&
                              element["artist"].toString().toLowerCase().contains(artist?.toLowerCase() ?? ""),
                          orElse: () => {}) ??
                  {};
            default:
              return {};
          }
        })
        .where((element) => element != {})
        .toList();

    var urls = await _getUrl(datas);

    print(json.encode(urls));

    return Answer(site: MusicSite.Mix, data: urls);
  } catch (e) {
    print("歌曲列表异常：" + e.toString());
    return const Answer(site: MusicSite.Mix, data: []);
  }
}

///获取各平台的url
Future<List<dynamic>> _getUrl(List<dynamic>? infos) async {
  if (infos == null) {
    return Future.value([]);
  }

  var resp = await Future.wait(infos.map((e) {
    var site = e?["site"];
    if (site == MusicSite.Baidu.name) {
      return Baidu.songInfo(tsId: e["id"]);
    } else if (site == MusicSite.KuGou.name) {
      return KuGou.musicInfo(hash: e["id"], albumAudioId: "${e["albumAudioId"]}");
    } else if (site == MusicSite.KuWo.name) {
      return KuWo.playUrl(rid: "${e["id"]}");
    } else if (site == MusicSite.MiGu.name) {
      return MiGu.playUrl2(contentId: "${e["id"]}");
    } else if (site == MusicSite.Netease.name) {
      return Netease.songUrl(id: "${e["id"]}");
    } else if (site == MusicSite.QQ.name) {
      return QQ.songListen(songMid: e["id"], mediaMid: e["mediaId"]);
    } else if (site == MusicSite.MyFreeMp3.name) {
      return Future.value(Answer(site: MusicSite.MyFreeMp3, data: e ?? {}));
    } else {
      return Future.value(Answer(site: MusicSite.None, data: e ?? {}));
    }
  }));

  var urls = infos
      .map((e) {
        var index = infos.indexOf(e);
        var site = e["site"];
        var data = resp[index].data;
        if (site == MusicSite.Baidu.name) {
          e["url"] = data["data"]["path"];
        } else if (site == MusicSite.KuGou.name) {
          e["url"] = data["data"]["play_url"];
        } else if (site == MusicSite.KuWo.name) {
          e["url"] = data["url"];
        } else if (site == MusicSite.MiGu.name) {
          e["url"] = data["url"];
        } else if (site == MusicSite.Netease.name) {
          e["url"] = (data["data"] as List?)?.first["url"];
        } else if (site == MusicSite.QQ.name) {
          e["url"] =
              data['req_0']['data']["midurlinfo"][0]['purl'] == "" ? null : data['req']["data"]['freeflowsip'][0] + data['req_0']['data']["midurlinfo"][0]['purl'] + '&fromtag=77';
        }
        return e;
      })
      .where((element) => element["url"] != null && element["url"] != "")
      .toList();

  return urls;
}
