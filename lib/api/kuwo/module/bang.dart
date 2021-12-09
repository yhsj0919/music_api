part of '../kuwo.dart';

///榜单列表
Future<Answer> _bangList(Map params, List<Cookie> cookie) {
  return _get(
    "http://kuwo.cn/api/www/bang/bang/bangMenu",
    params: {},
    cookie: cookie,
  );
}

///榜单列表
Future<Answer> _bangInfo(Map params, List<Cookie> cookie) {
  return _get(
    "http://kuwo.cn/api/www/bang/bang/musicList",
    params: {
      "bangId": params["id"],
      "pn": params["page"] ?? 1,
      "rn": params["size"] ?? 30,
    },
    cookie: cookie,
  );
}
