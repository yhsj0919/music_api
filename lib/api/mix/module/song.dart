part of '../mix_music.dart';

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
                            "site": "kuwo",
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
                            "site": "migu",
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
                            "site": "myfreemp3",
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
                            "site": "kugou",
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
                            "site": "baidu",
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
                            "site": "netease",
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
                            "site": "qq",
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
    if (site == "baidu") {
      return Baidu.songInfo(tsId: e["id"]);
    } else if (site == "kugou") {
      return KuGou.musicInfo(hash: e["id"], albumAudioId: "${e["albumAudioId"]}");
    } else if (site == "kuwo") {
      return KuWo.playUrl(rid: "${e["id"]}");
    } else if (site == "migu") {
      return MiGu.playUrl2(contentId: "${e["id"]}");
    } else if (site == "netease") {
      return Netease.songUrl(id: "${e["id"]}");
    } else if (site == "qq") {
      return QQ.songListen(songMid: e["id"], mediaMid: e["mediaId"]);
    } else if (site == "myfreemp3") {
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
        if (site == "baidu") {
          e["url"] = data["data"]["path"];
        } else if (site == "kugou") {
          e["url"] = data["data"]["play_url"];
        } else if (site == "kuwo") {
          e["url"] = data["url"];
        } else if (site == "migu") {
          e["url"] = data["url"];
        } else if (site == "netease") {
          e["url"] = (data["data"] as List?)?.first["url"];
        } else if (site == "qq") {
          e["url"] =
              data['req_0']['data']["midurlinfo"][0]['purl'] == "" ? null : data['req']["data"]['freeflowsip'][0] + data['req_0']['data']["midurlinfo"][0]['purl'] + '&fromtag=77';
        }
        return e;
      })
      .where((element) => element["url"] != null && element["url"] != "")
      .toList();

  return urls;
}
