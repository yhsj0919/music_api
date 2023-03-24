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


Future<Answer> _albumInfo(Map params, List<Cookie> cookie) {
//https://m3ws.kugou.com/api/v1/album/info?type=1&page=1&albumid=58849245&appid=1058&srcappid=2919&clientver=20000&clienttime=1679627053360&mid=1679627053360&uuid=1679627053360&dfid=-&signature=FC42C6ACAAA68E31CB9C83FC1B9F242F

  var data = {
    "type": 1,
    "page": "1",
    "albumid": params["albumId"],
    "timelength": 0,
    "srcappid": 2919,
    "clientver": 20000,
    "clienttime": DateTime.now().millisecondsSinceEpoch,
    "mid":  DateTime.now().millisecondsSinceEpoch,
    "uuid":  DateTime.now().millisecondsSinceEpoch,
    "dfid": "-",
  };

  var signature = signatureParams(data);

  data["signature"] = signature;
  // print(signature);
  return _get(
    "https://m3ws.kugou.com/api/v1/album/info",
    params: data,
    cookie: cookie,
  );
}

///专辑信息
Future<Answer> _albumInfo1(Map params, List<Cookie> cookie) {
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
      "albumid": params["albumId"].toString(),
      "page": 1,
      "pagesize": -1,
    },
    cookie: cookie,
  ).then((value) async {
    try {
      var data = json.decode(value.data);

      var datas = (await Future.wait((data["data"]["info"] as List).map((e) => _musicInfo({"hash": e["hash"].toString(), "albumAudioId": e["album_audio_id"].toString()}, cookie))))
          .map((e) => e.data)
          .toList();

      data["data"]["info"] = datas;

      return value.copy(data: data);
    } catch (e) {
      print(e);
    }
    return value;
  });
}
