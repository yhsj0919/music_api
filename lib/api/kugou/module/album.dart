part of '../kugou.dart';

///专辑列表
Future<Answer> _albumList(Map params, List<Cookie> cookie) {
  return _get(
    "http://mobilecdnbj.kugou.com/api/v3/album/list",
    params: {
      "page": params["page"] ?? 1,
    },
    cookie: cookie,
  );
}

///专辑信息
Future<Answer> _albumInfo(Map params, List<Cookie> cookie) {
  return _get(
    "http://mobilecdnbj.kugou.com/api/v3/album/info",
    params: {
      "albumid": params["albumId"],
    },
    cookie: cookie,
  );
}

///专辑歌曲
Future<Answer> _albumSong(Map params, List<Cookie> cookie) {
  return _get(
    "http://mobilecdnbj.kugou.com/api/v3/album/song",
    params: {
      "albumid": params["albumId"],
      "page": 1,
      "pagesize": -1,
    },
    cookie: cookie,
  ).then((value) async {
    try {
      var data = value.data;

      var songs=[];



      var datas = (await Future.wait((data["data"]["info"] as List).map((e) => _musicInfoWithLyric({"hash": e["hash"], "albumAudioId": e["album_audio_id"]}, cookie))))
          .map((e) => e.data["data"])
          .toList();

      data["data"]["info"] = datas;

      return value.copy(data: data);
    } catch (e) {
      print(e);
    }
    return value;
  });
}
