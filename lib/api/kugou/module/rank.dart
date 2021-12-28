part of '../kugou.dart';

///榜单列表
Future<Answer> _rankList(Map params, List<Cookie> cookie) {
  return _get(
    "http://mobilecdnbj.kugou.com/api/v3/rank/list",
    params: {},
    cookie: cookie,
  );
}

///榜单详情
Future<Answer> _rankInfo(Map params, List<Cookie> cookie) {
  return _get(
    "http://mobilecdnbj.kugou.com/api/v3/rank/info",
    params: {
      "rankid": params["rankId"],
    },
    cookie: cookie,
  );
}

///榜单歌曲
Future<Answer> _rankSong(Map params, List<Cookie> cookie) {
  return _get(
    "http://mobilecdnbj.kugou.com/api/v3/rank/song",
    params: {
      "rankid": params["rankId"],
      "page": params["page"] ?? 1,
      "pagesize": params["size"] ?? 30,
    },
    cookie: cookie,
  );
}
