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
  );
}
