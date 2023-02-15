part of '../kugou.dart';

///新歌推荐
Future<Answer> _musicNew(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('musicwo17', 'kugou'));
  return _get(
    "https://m.kugou.com",
    params: {
      "json": "true",
    },
    cookie: cookie,
  ).then((resp) async {
    var list = (resp.data["data"] as List?) ?? [];
    var len = list.length > 10 ? 10 : list.length;
    var songs = [];
    var datas = list.sublist(0, len);
    for (var element in datas) {
      var album = (await _albumInfo({"albumId": element["album_id"]}, cookie)).data;
      element["album_name"] = album["data"]["albumname"];
      songs.add(element);
    }

    return resp.copy(data: songs);
  });
}

Future<Answer> _musicList(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('musicwo17', 'kugou'));
  return _get(
    "https://m.kugou.com/newsong/index",
    params: {
      "json": "true",
    },
    cookie: cookie,
  ).then((resp) async {
    print(DateTime.now().millisecondsSinceEpoch);
    var list = (resp.data["newSongList"] as List?) ?? [];

    var datas = splitList(list, 25);

    var albums = [];
    for (var element in datas) {
      var datas = (await Future.wait((element).map((e) => _albumInfo({"albumId": e["album_id"]}, cookie)))).map((e) => e.data["data"]).toList();
      albums.addAll(datas);
      // await Future.delayed(const Duration(milliseconds: 10));
    }

    var songs = list.map((e) {
      var album = albums.where((element) => element["albumid"].toString() == e["album_id"].toString()).first;
      e["album_name"] = album?["albumname"] ?? "";
      return e;
    }).toList();
    print(DateTime.now().millisecondsSinceEpoch);
    return resp.copy(data: songs);
  });
}

///歌曲信息
Future<Answer> _musicInfo(Map params, List<Cookie> cookie) {
//https://m.kugou.com/app/i/getSongInfo.php?cmd=playInfo&hash=A5456E5A05080F21BB801FC423B348D0
  cookie.add(Cookie('musicwo17', 'kugou'));
  return _get(
    "https://m.kugou.com/app/i/getSongInfo.php",
    params: {
      "cmd": "playInfo",
      "hash": params["hash"],
    },
    cookie: cookie,
  );
}

Future<Answer> _musicInfoWithLyric(Map params, List<Cookie> cookie) {
//https://wwwapi.kugou.com/yy/index.php?r=play/getdata&hash=DE12B818BD5FA8C3A8DF71D5940C5A08&album_audio_id=375044853
  return _get(
    "https://wwwapi.kugou.com/yy/index.php",
    params: {
      "r": "play/getdata",
      "hash": params["hash"],
      "album_audio_id": params["albumAudioId"] ?? "",
    },
    cookie: cookie,
  );
}

///歌曲信息
Future<Answer> _musicInfo2(Map params, List<Cookie> cookie) {
  //http://trackercdn.kugou.com/i/v2/?cmd=26&pid=4&hash=6E168B3349A4CB833CDD10A9BA1E7327&key=86c8f9eb1ed74ea9684165cca6d31acb&behavior=play&appid=3238&mid=1fbf760909b864a20361065451df36db&version=151&vipType=0&album_id=51227378

  var mid = "0";
  var userid = "0";
  var appid = "1005";
  String hash = params["hash"];

  return _get(
    "http://trackercdn.kugou.com/i/v2/",
    params: {
      "cmd": "26",
      "key": md5.convert(utf8.encode("${hash.toLowerCase()}kgcloudv2$appid$mid$userid")),
      "hash": hash.toLowerCase(),
      "pid": 1,
      "behavior": "play",
      "mid": mid,
      "appid": appid,
      "userid": userid,
      "version": 0,
      "vipType": 0,
      "token": 0,
    },
    cookie: cookie,
  );
}

///歌曲信息
Future<Answer> _musicInfo3(Map params, List<Cookie> cookie) {
  //http://trackercdn.kugou.com/i/v2/?cmd=26&pid=4&hash=6E168B3349A4CB833CDD10A9BA1E7327&key=86c8f9eb1ed74ea9684165cca6d31acb&behavior=play&appid=3238&mid=1fbf760909b864a20361065451df36db&version=151&vipType=0&album_id=51227378

  String hash = params["hash"];

  return _get(
    "http://trackercdn.kugou.com/i/v2/",
    params: {
      "cmd": "25",
      "key": md5.convert(utf8.encode("${hash.toLowerCase()}kgcloudv2")),
      "hash": hash.toLowerCase(),
      "pid": 1,
      "behavior": "download",
    },
    cookie: cookie,
  );
}
