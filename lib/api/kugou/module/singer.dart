part of '../kugou.dart';


///歌手列表
Future<Answer> _singerList(Map params, List<Cookie> cookie) {
  return _get(
    "http://mobilecdnbj.kugou.com/api/v3/singer/list?type=1&sextype=2&page=2",
    params: {
      "sextype": params["sexType"] ?? 0,
      "type": params["type"] ?? 0,
      "page": params["page"] ?? 1,
    },
    cookie: cookie,
  );
}

///歌手分类，和下面配合使用
Future<Answer> _singerType(Map params, List<Cookie> cookie) {
  return _get(
    "https://m.kugou.com/singer/class",
    params: {
      "json": "true",
    },
    cookie: cookie,
  );
}

///歌手列表
Future<Answer> _singerList2(Map params, List<Cookie> cookie) {
  return _get(
    "http://m.kugou.com/singer/list/${params["classId"]}",
    params: {
      "page": params["page"] ?? 1,
      "json": "true",
    },
    cookie: cookie,
  );
}

///歌手信息
Future<Answer> _singerInfo(Map params, List<Cookie> cookie) {
  return _get(
    "http://mobilecdnbj.kugou.com/api/v3/singer/info",
    params: {
      "singerid": params["id"],
    },
    cookie: cookie,
  );
}

///歌手单曲
Future<Answer> _singerSong(Map params, List<Cookie> cookie) {
  return _get(
    "http://mobilecdnbj.kugou.com/api/v3/singer/song",
    params: {
      "singerid": params["id"],
      "page": params["page"] ?? 1,
      "pagesize": params["size"] ?? 30,
    },
    cookie: cookie,
  );
}

///歌手专辑
Future<Answer> _singerAlbum(Map params, List<Cookie> cookie) {
  return _get(
    "http://mobilecdnbj.kugou.com/api/v3/singer/album",
    params: {
      "singerid": params["id"],
      "page": params["page"] ?? 1,
      "pagesize": params["size"] ?? 30,
    },
    cookie: cookie,
  );
}

///歌手专辑
Future<Answer> _singerMv(Map params, List<Cookie> cookie) {
  return _get(
    "http://mobilecdnbj.kugou.com/api/v3/singer/mv",
    params: {
      "singerid": params["id"],
      "page": params["page"] ?? 1,
      "pagesize": params["size"] ?? 30,
    },
    cookie: cookie,
  );
}

//http://uwp.kugou.com/v2/musicol/yueku/v1/singer/album/getData.js?cdn=cdn&sid=3060&p=1&s=20
//http://fm.service.kugou.com/v1/get_singer_song_list?clienttime=1639723546179&key=AC5F50BC065BAB96C8155B207425BA99&callback=singerFmInitCallback&size=5&t=0.4171996126489703&singerid=3060
