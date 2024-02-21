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
    // var len = list.length > 10 ? 10 : list.length;
    // var songs = [];
    // var datas = list.sublist(0, len);
    // for (var element in datas) {
    //   var album = (await _albumInfo({"albumId": element["album_id"]}, cookie)).data;
    //   element["album_name"] = album["data"]["albumname"];
    //   songs.add(element);
    // }

    return resp.copy(data: list);
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
    // print(DateTime.now().millisecondsSinceEpoch);
    var list = (resp.data["newSongList"] as List?) ?? [];

    // var datas = splitList(list, 25);
    //
    // var albums = [];
    // for (var element in datas) {
    //   var datas = (await Future.wait((element).map((e) => _albumInfo({"albumId": e["album_id"]}, cookie)))).map((e) {
    //     print(e.data);
    //     return e.data["data"];
    //   }).toList();
    //
    //   albums.addAll(datas);
    //   // await Future.delayed(const Duration(milliseconds: 10));
    // }
    //
    // var songs = list.map((e) {
    //   var album = albums.where((element) => element["albumid"].toString() == e["album_id"].toString()).first;
    //   e["album_name"] = album?["albumname"] ?? "";
    //   return e;
    // }).toList();
    // print(DateTime.now().millisecondsSinceEpoch);
    return resp.copy(data: list);
  });
}

Future<Answer> _musicInfo(Map params, List<Cookie> cookie) {
//https://m3ws.kugou.com/v1/song/info?srcappid=2919&clientver=2000&clienttime=1679625193379&mid=13b99c4ecc49b8e85dde00e21160b008&uuid=13b99c4ecc49b8e85dde00e21160b008&dfid=1JdAUM1MExVq2HbWdD1cveSL&appid=1058&cmd=playInfo&hash=492DF9BEE89AF801625FE4D439F4DDF9&from=mkugou&apiver=2&platid=4&uid=0&token=&userid=0&album_id=38123847&album_audio_id=260603552&signature=38b23dada3cca277bd3f25d9a98024a5
  String hash = params["hash"];
  String albumAudioId = params["albumAudioId"] ?? "";

  var data = {
    "album_audio_id": albumAudioId,
    "cmd": "playInfo",
    "hash": hash,
    "timelength": 0,
    "srcappid": 2919,
    "clientver": 2000,
    "clienttime": DateTime.now().millisecondsSinceEpoch,
    "mid": DateTime.now().millisecondsSinceEpoch,
    "uuid": DateTime.now().millisecondsSinceEpoch,
    "dfid": "1JdAUM1MExVq2HbWdD1cveSL",
  };

  var signature = signatureParams(data);

  data["signature"] = signature;
  // print(signature);
  return _get(
    "https://m3ws.kugou.com/v1/song/info",
    params: data,
    cookie: cookie,
  );
}

///歌曲信息
Future<Answer> _musicInfo6(Map params, List<Cookie> cookie) {
//https://m.kugou.com/app/i/getSongInfo.php?cmd=playInfo&hash=A5456E5A05080F21BB801FC423B348D0
  cookie.add(Cookie('musicwo17', 'kugou'));
  return _get(
    "https://m.kugou.com/app/i/getSongInfo.php",
    params: {
      "cmd": "playInfo",
      "hash": params["hash"].toString(),
    },
    cookie: cookie,
  );
}

Future<Answer> _musicInfoWithLyric(Map params, List<Cookie> cookie) {
//https://www.kugou.com/yy/index.php?r=play/getdata&hash=DE12B818BD5FA8C3A8DF71D5940C5A08&album_audio_id=375044853
  return _get(
    "https://www.kugou.com/yy/index.php",
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

Future<Answer> _musicInfo4(Map params, List<Cookie> cookie) {
//https://m3ws.kugou.com/api/v1/song/get_song_info_v2?cmd=playInfo&from=mkugou&apiver=2&mid=1e8d9450ee27ae0e73ad10dea18dee1c&userid=0&platid=4&dfid=2B4X0T1jW4EU45wcnn4Y8nOC&hash=" + hash+"&album_id"+album_id
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

Future<Answer> _musicInfo5(Map params, List<Cookie> cookie) {
////https://m3ws.kugou.com/api/v1/song/get_song_info_v2?cmd=playInfo&from=mkugou&apiver=2&mid=1e8d9450ee27ae0e73ad10dea18dee1c&userid=0&platid=4&dfid=2B4X0T1jW4EU45wcnn4Y8nOC&hash=" + hash+"&album_id"+album_id
  return _get(
    "https://m3ws.kugou.com/api/v1/song/get_song_info_v2",
    params: {
      // "cmd": "playInfo",
      // "from":"mkugou",
      // "apiver":"2",
      "mid": "1e8d9450ee27ae0e73ad10dea18dee1c",
      // "userid":"0",
      // "platid":"4",
      // "dfid":"2B4X0T1jW4EU45wcnn4Y8nOC",
      "hash": params["hash"],
      "album_id": params["albumAudioId"] ?? "",
    },
    cookie: cookie,
  );
}

//
///歌词信息
Future<Answer> _lrc(Map params, List<Cookie> cookie) {
  https: //m3ws.kugou.com/api/v1/krc/get_lyrics?keyword=郑少秋 - 笑看风云&hash=6340EBA91E893EED118FF7400F2AA3CB&timelength=262000&srcappid=2919&clientver=20000&clienttime=1679561402031&mid=1679561402031&uuid=1679561402031&dfid=-&signature=1BA519D66EF9FA87F931E10CEBF869CA
  String hash = params["hash"];

  var data = {
    "keyword": "",
    "hash": hash,
    "timelength": 0,
    "srcappid": 2919,
    "clientver": 20000,
    "clienttime": DateTime.now().millisecondsSinceEpoch,
    "mid": DateTime.now().millisecondsSinceEpoch,
    "uuid": DateTime.now().millisecondsSinceEpoch,
    "dfid": "-",
  };

  var signature = signatureParams(data);

  data["signature"] = signature;
  print(signature);
  return _get(
    "https://m3ws.kugou.com/api/v1/krc/get_lyrics",
    params: data,
    cookie: cookie,
  );
}

Future<Answer> _krc(Map params, List<Cookie> cookie) {
//http://lyrics.kugou.com/search?ver=1&man=yes&client=pc&keyword=%s&hash=%s&timelength=%s
  String hash = params["hash"];

  var data = {
    "keyword": "",
    "ver": 1,
    "hash": hash,
    "man": "yes",
    "client": "pc",
    "timelength": 0,
  };

  return _get(
    "http://lyrics.kugou.com/search",
    params: data,
    cookie: cookie,
  ).then((value) {
    var data = value.data;
    var id = (data["candidates"] as List<dynamic>).firstOrNull["id"];
    var accesskey = (data["candidates"] as List<dynamic>).firstOrNull["accesskey"];

    print(id);
    print(accesskey);
    return _krcInfo({"id": id, "accesskey": accesskey}, cookie);
  });
}

Future<Answer> _krcInfo(Map params, List<Cookie> cookie) {
  http: //lyrics.kugou.com/download?ver=1&client=pc&id=%s&accesskey=%s&fmt=krc&charset=utf8
  String id = params["id"];
  String accesskey = params["accesskey"];
  var data = {
    "ver": 1,
    "client": "pc",
    "id": id,
    "accesskey": accesskey,
    "fmt": "krc",
    "charset": "utf8",
  };

  return _get(
    "http://lyrics.kugou.com/download",
    params: data,
    cookie: cookie,
  ).then((value) {
    var content = value.data["content"];
    String result = decodeKrc(content);

    var krc = {"lyric": result};

    return Future.value(value.copy(data: krc));
  });
}
