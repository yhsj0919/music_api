part of '../kugou.dart';

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
