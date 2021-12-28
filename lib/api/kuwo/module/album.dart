part of '../kuwo.dart';

///专辑列表
Future<Answer> _albumList(Map params, List<Cookie> cookie) {
  return _get(
    "http://wapi.kuwo.cn/openapi/v1/pc/disc/shelves",
    params: {
      "pn": params["page"] ?? 1,
      "rn": params["size"] ?? 30,
    },
    cookie: cookie,
  );
}

///专辑信息
Future<Answer> _albumInfo(Map params, List<Cookie> cookie) {
  return _get(
    "http://kuwo.cn/api/www/album/albumInfo",
    params: {
      "albumId": params["albumId"],
      "pn": params["page"] ?? 1,
      "rn": params["size"] ?? 30,
    },
    cookie: cookie,
  );
}
