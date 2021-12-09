part of '../kuwo.dart';

///歌手列表
Future<Answer> _artistList(Map params, List<Cookie> cookie) {
  return _get(
    "http://kuwo.cn/api/www/artist/artistInfo",
    params: {
      "category": params["category"],
      "prefix": params["prefix"],
      "pn": params["page"] ?? 1,
      "rn": params["size"] ?? 100,
    },
    cookie: cookie,
  );
}
