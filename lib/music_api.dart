import 'dart:convert';

import 'package:music_api/api/baidu/baidu.dart';
import 'package:music_api/api/kugou/kugou.dart';
import 'package:music_api/api/kuwo/kuwo.dart';
import 'package:music_api/api/migu/migu.dart';
import 'package:music_api/api/netease/netease.dart';
import 'package:music_api/api/qq/qq.dart';
import 'package:music_api/utils/answer.dart';

class MusicApi {
  MusicApi._();

  static Future<Answer> banner() async {
    Future.wait([
      KuWo.banner(),
      MiGu.banner(),
      KuGou.banner(),
      Baidu.banner(),
      Netease.banner(),
      QQ.banner(),
    ]).then((value) {
      for (var element in value) {
        print(json.encode(element.data));
      }
    });

    return Answer(data: {});
  }

  ///匹配音乐播放地址
  static Future<Answer> matchMusic({String? name, String? artist}) async {
    var keyWord = "$name $artist";

    var value = await Future.wait([
      KuWo.searchMusic(keyWord: keyWord, size: 10),
      MiGu.search(keyWord: keyWord, size: 10),
      KuGou.searchSong(keyword: keyWord, size: 10),
      Baidu.search(keyWord: keyWord, type: 1, size: 10),
      Netease.search(keyWord: keyWord, size: 10),
      QQ.search(keyWord: keyWord, size: 10),
    ]);
    var datas = value
        .map((e) {
          var index = value.indexOf(e);
          if (index == 0) {
            return (e.data["data"]["list"] as List?)
                ?.map((e) => {
                      "site": "kuwo",
                      "id": e["rid"],
                      "name": e["name"],
                      "artist": e["artist"],
                    })
                .firstWhere((element) => element["name"].toString().toLowerCase() == name.toString().toLowerCase() && element["artist"].toString().toLowerCase().contains("${artist?.toLowerCase()}"), orElse: () => {});
          } else if (index == 1) {
            return (e.data["songResultData"]["result"] as List?)
                ?.map((e) => {
                      "site": "migu",
                      "id": e["contentId"],
                      "name": e["name"],
                      "artist": (e["artists"] as List?)?.map((e) => e["name"]).join(","),
                    })
                .firstWhere((element) => element["name"].toString().toLowerCase().contains("${name?.toLowerCase()}") && element["artist"].toString().toLowerCase().contains("${artist?.toLowerCase()}"), orElse: () => {});
          } else if (index == 2) {
            return (e.data["data"]["info"] as List?)
                ?.map((e) => {
                      "site": "kugou",
                      "id": e["hash"],
                      "albumAudioId": e["album_audio_id"],
                      "name": e["songname"],
                      "artist": e["singername"],
                    })
                .firstWhere((element) => element["name"].toString().toLowerCase() == name.toString().toLowerCase() && element["artist"].toString().toLowerCase().contains("${artist?.toLowerCase()}"), orElse: () => {});
          } else if (index == 3) {
            return (e.data["data"]["typeTrack"] as List?)
                ?.map((e) => {
                      "site": "baidu",
                      "id": e["TSID"],
                      "name": e["title"],
                      "artist": (e["artist"] as List?)?.map((e) => e["name"]).join(","),
                    })
                .firstWhere((element) => element["name"].toString().toLowerCase() == name.toString().toLowerCase() && element["artist"].toString().toLowerCase().contains("${artist?.toLowerCase()}"), orElse: () => {});
          } else if (index == 4) {
            return (e.data["result"]["songs"] as List?)
                ?.map((e) => {
                      "site": "netease",
                      "id": e["id"],
                      "name": e["name"],
                      "artist": (e["artists"] as List?)?.map((e) => e["name"]).join(","),
                    })
                .firstWhere((element) => element["name"].toString().toLowerCase() == name.toString().toLowerCase() && element["artist"].toString().toLowerCase().contains("${artist?.toLowerCase()}"), orElse: () => {});
          } else if (index == 5) {
            return (e.data["req"]["data"]["body"]["item_song"] as List?)
                ?.map((e) => {
                      "site": "qq",
                      "id": e["mid"],
                      "mediaId": e["file"]["media_mid"],
                      "name": e["title"].toString().replaceAll("<em>", "").replaceAll("</em>", ""),
                      "artist": (e["singer"] as List?)?.map((e) => e["name"]).join(","),
                    })
                .firstWhere((element) => element["name"].toString().toLowerCase() == name.toString().toLowerCase() && element["artist"].toString().toLowerCase().contains("${artist?.toLowerCase()}"), orElse: () => {});
          } else {
            return {};
          }
        })
        .where((element) => element != null || element != {})
        .toList();

    var urls = await _getUrl(datas);

    print(json.encode(urls));

    return Answer(data: urls);
  }

  static Future<List<dynamic>> _getUrl(List<dynamic> infos) async {
    var resp = await Future.wait(infos.map((e) {
      var site = e["site"];
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
      } else {
        return Future.value(Answer(data: {}));
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
            e["url"] = data['req_0']['data']["midurlinfo"][0]['purl'] == "" ? null : data['req']["data"]['freeflowsip'][0] + data['req_0']['data']["midurlinfo"][0]['purl'] + '&fromtag=77';
          }
          return e;
        })
        .where((element) => element["url"] != null && element["url"] != "")
        .toList();

    return urls;
  }
}
