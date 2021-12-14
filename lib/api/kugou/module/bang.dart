part of '../kugou.dart';

///榜单列表
Future<Answer> _bangList(Map params, List<Cookie> cookie) {
  return _get(
    "http://m.kugou.com/rank/list",
    params: {"json": "true"},
    cookie: cookie,
  );
}

///榜单列表
Future<Answer> _bangInfo(Map params, List<Cookie> cookie) {
  return _get(
    "http://m.kugou.com/rank/info",
    params: {
      "rankid": params["rankId"],
      "page": params["page"] ?? 1,
      "json": params["true"],
    },
    cookie: cookie,
  );
}
