part of '../mix_music.dart';

///新歌
Future<Answer> _songNew({List<MusicSite> site = allSite}) async {
  try {
    var value = await Future.wait(site.map((e) {
      switch (e) {
        case MusicSite.KuWo:
          return KuWo.songNew();
        case MusicSite.MiGu:
          return MiGu?.songNew(columnId: "15279290");
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
              try {
                var datas = (((e.data["child"] as List?)?.firstWhere((element) => element["type"].toString() == "newmusic_list")?["child"] as List?)?.first?["child"] as List?)
                    ?.map((e) => Song(
                          site: MusicSite.KuWo,
                          id: e["data"]?["rid"],
                          pic: e["data"]?["img"],
                          title: e["data"]?["name"],
                          subTitle: e["data"]?["artist"],
                          artist: [Artist(id: e["data"]?["artistid"], name: e["data"]?["artist"])],
                          album: Album(site: MusicSite.KuWo, id: e["data"]?["albumid"], title: e["data"]?["album"], pic: e["data"]?["img"]),
                        ))
                    .where((element) => element["id"] != null)
                    .toList()
                    .sublist(0, 10);
                return {"site": MusicSite.KuWo.name, "data": datas ?? []};
              } catch (e) {
                return {"site": MusicSite.KuWo.name, "data": []};
              }
            case MusicSite.MiGu:
              try {
                // var datas = ((e.data["data"] as List?)?.firstWhere((element) => element["groupName"] == "华语")?["items"] as List?)
                //     ?.map((e) => {
                //           "site": MusicSite.MiGu.name,
                //           "id": e["copyrightId"],
                //           "pic": "http:${e["image"]}",
                //           "title": e["songName"],
                //           "subTitle": (e["singers"] as List?)?.map((e) => e["singerName"]).join(","),
                //           "artist": (e["singers"] as List?)?.map((e) => {"id": e["singerId"], "name": e["singerName"], "pic": e["image"]}).toList(),
                //           "album": {"id": e["albumId"], "name": e["albumName"], "pic": "http:${e["image"]}"},
                //         })

                var datas = ((e.data["data"]?["contentItemList"] as List?)?.first?["itemList"] as List?)
                    ?.map((e) => Song(
                          site: MusicSite.MiGu,
                          id: e["song"]?["songId"],
                          contentId: e["song"]?["contentId"],
                          pic: "http://d.musicapp.migu.cn${e["song"]?["img1"]}",
                          title: e["song"]?["songName"],
                          subTitle: (e["song"]?["singerList"] as List?)?.map((e) => e["name"]).join(","),
                          artist: (e["song"]?["singerList"] as List?)?.map((e) => Artist(id: e["id"], name: e["name"], pic: "http://d.musicapp.migu.cn${e["img"]}")).toList(),
                          album: Album(site: MusicSite.MiGu, id: e["song"]?["albumId"], title: e["song"]?["album"], pic: "http://d.musicapp.migu.cn${e["song"]?["img1"]}"),
                        ))
                    .where((element) => element["id"] != null)
                    .toList()
                    .sublist(0, 10);
                return {"site": MusicSite.MiGu.name, "data": datas ?? []};
              } catch (e) {
                return {"site": MusicSite.MiGu.name, "data": []};
              }
            case MusicSite.KuGou:
              try {
                var datas = (e.data as List?)
                    ?.map((e) => Song(
                          site: MusicSite.KuGou,
                          id: e["hash"],
                          albumAudioId: e["album_audio_id"],
                          pic: e["img"].toString().replaceFirst("stdmusic", "stdmusic/400").replaceAll("{size}", ""),
                          title: e["song_name"],
                          subTitle: e["author_name"],
                          lyric: e["lyrics"],
                          artist: [Artist(id: e["author_id"], name: e["author_name"])],
                          album: Album(
                              site: MusicSite.KuGou,
                              id: e["album_id"],
                              title: e["album_name"],
                              pic: e["img"].toString().replaceFirst("stdmusic", "stdmusic/400").replaceAll("{size}", "")),
                        ))
                    .where((element) => element["id"] != null)
                    .toList();

                var songs;

                if ((datas?.length ?? 0) > 10) {
                  songs = datas?.sublist(0, 10);
                } else {
                  songs = datas;
                }

                return {"site": MusicSite.KuGou.name, "data": songs ?? []};
              } catch (e) {
                return {"site": MusicSite.KuGou.name, "data": []};
              }
            case MusicSite.Baidu:
              try {
                var datas = (e.data["data"]?["result"] as List?)
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
                    .where((element) => element["id"] != null)
                    .toList();
                return {"site": MusicSite.Baidu.name, "data": datas ?? []};
              } catch (e) {
                return {"site": MusicSite.Baidu.name, "data": []};
              }
            case MusicSite.Netease:
              try {
                var datas = (e.data["data"] as List?)
                    ?.map((e) => Song(
                          site: MusicSite.Netease,
                          id: e["id"],
                          pic: "${e["album"]?["picUrl"]}?imageView=1&thumbnail=300x0",
                          title: e["name"],
                          subTitle: (e["artists"] as List?)?.map((e) => e["name"]).join(","),
                          artist: (e["artists"] as List?)?.map((e) => Artist(id: e["id"], name: e["name"], pic: "${e["picUrl"]}?imageView=1&thumbnail=300x0")).toList(),
                          album: Album(site: MusicSite.Netease, id: e["album"]?["id"], title: e["album"]?["name"], pic: "${e["album"]?["picUrl"]}?imageView=1&thumbnail=300x0"),
                        ))
                    .where((element) => element["id"] != null)
                    .toList()
                    .sublist(0, 10);
                return {"site": MusicSite.Netease.name, "data": datas ?? []};
              } catch (e) {
                return {"site": MusicSite.Netease.name, "data": []};
              }
            case MusicSite.QQ:
              try {
                var datas = (e.data["newSong"]?["data"]?["songlist"] as List?)
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
                    .where((element) => element["id"] != null)
                    .toList()
                    .sublist(0, 10);
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
                            "id": e["copyrightId"],
                            "contentId": e["contentId"],
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

    var urls = await _getUrl(songs: datas, withEmpty: false);

    print(json.encode(urls));

    return Answer(site: MusicSite.Mix, data: urls);
  } catch (e) {
    print("歌曲列表异常：" + e.toString());
    return const Answer(site: MusicSite.Mix, data: []);
  }
}

///获取各平台的url
Future<List<dynamic>> _getUrl({required List<dynamic> songs, bool withEmpty = true}) async {
  var resp = [];

  ///分割一下list，防止瞬间请求过多导致的失败
  var datas = splitList(songs, 15);
  for (var element in datas) {
    var list = (await Future.wait(element.map((e) {
      var site = e?["site"];
      if (site == MusicSite.Baidu.name) {
        return Baidu.songInfo(tsId: e["id"]);
      } else if (site == MusicSite.KuGou.name) {
        return KuGou.musicInfo(hash: e["id"], albumAudioId: "${e["albumAudioId"]}");
      } else if (site == MusicSite.KuWo.name) {
        return KuWo.playUrl(rid: "${e["id"]}");
      } else if (site == MusicSite.MiGu.name) {
        return MiGu.playUrl2(contentId: "${e["contentId"]}");
      } else if (site == MusicSite.Netease.name) {
        return Netease.songUrl(id: "${e["id"]}");
      } else if (site == MusicSite.QQ.name) {
        return QQ.songListen(songMid: e["mid"], mediaMid: e["mediaId"]);
      } else if (site == MusicSite.MyFreeMp3.name) {
        return Future.value(Answer(site: MusicSite.MyFreeMp3, data: e ?? {}));
      } else {
        return Future.value(Answer(site: MusicSite.None, data: e ?? {}));
      }
    })))
        .toList();
    resp.addAll(list);
    await Future.delayed(const Duration(milliseconds: 200));
  }

  var urls = songs
      .map((e) {
        try {
          var index = songs.indexOf(e);
          var site = e["site"];
          var data = resp[index].data;
          if (site == MusicSite.Baidu.name) {
            e["url"] = data["data"]["path"];
            e["lyric"] = data["data"]["lyric"];
          } else if (site == MusicSite.KuGou.name) {
            e["url"] = data["data"]?["play_url"];
            e["lyric"] = data["data"]?["lyrics"];
          } else if (site == MusicSite.KuWo.name) {
            e["url"] = data["url"];
          } else if (site == MusicSite.MiGu.name) {
            e["url"] = data["url"];
          } else if (site == MusicSite.Netease.name) {
            e["url"] = (data["data"] as List?)?.first["url"];
          } else if (site == MusicSite.QQ.name) {
            e["url"] = data['req_0']['data']["midurlinfo"][0]['purl'] == ""
                ? null
                : data['req']["data"]['freeflowsip'][0] + data['req_0']['data']["midurlinfo"][0]['purl'] + '&fromtag=77';
          }
        } catch (e) {
          print(e);
        }

        return e;
      })
      .where((element) => withEmpty || (element["url"] != null && element["url"] != ""))
      .toList();

  return Future.value(urls);
}

///获取各平台的url
Future<String?> _getLrc({required Map songs}) async {
  var site = songs["site"];
  if (site == MusicSite.Baidu.name) {
    return Baidu.songInfo(tsId: songs["id"]).then((value) {
      var path = value.data["data"]["lyric"];
      return Http.get(path).then((value) => value.transform(utf8.decoder).join());
    });
  } else if (site == MusicSite.KuGou.name) {
    return KuGou.musicInfo(hash: songs["id"], albumAudioId: "${songs["albumAudioId"]}").then((value) => value.data["data"]["lyrics"]);
  } else if (site == MusicSite.KuWo.name) {
    return KuWo.songLrc(rid: "${songs["id"]}").then((value) => value.data);
  } else if (site == MusicSite.MiGu.name) {
    return MiGu.songLrc(songId: "${songs["id"]}").then((value) => value.data);
  } else if (site == MusicSite.Netease.name) {
    return Netease.lyric(id: "${songs["id"]}").then((value) => value.data);
  } else if (site == MusicSite.QQ.name) {
    return QQ.songLyric(songMid: songs["mid"], songId: songs["id"]).then((value) => value.data["lyric"]);
  } else {
    return Future.value("暂无歌词");
  }
}
