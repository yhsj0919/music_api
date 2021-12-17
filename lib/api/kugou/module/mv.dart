part of '../kugou.dart';

///MV列表
///
Future<Answer> _mvList(Map params, List<Cookie> cookie) {
  return _get(
    "http://mobilecdnbj.kugou.com/api/v3/mv/list",
    params: {
      "page": params["page"] ?? 1,
    },
    cookie: cookie,
  );
}

///MV信息
Future<Answer> _mvInfo(Map params, List<Cookie> cookie) {
  return _get(
    "http://m.kugou.com/app/i/mv.php",
    params: {
      "hash": params["hash"],
      "cmd": 100,
      "ismp3": 1,
      "ext": "mp4",
    },
    cookie: cookie,
  );
}
