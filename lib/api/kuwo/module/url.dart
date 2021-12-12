part of '../kuwo.dart';

///播放地址
Future<Answer> _playUrl(Map params, List<Cookie> cookie) {
  return _get(
    "http://www.kuwo.cn/api/v1/www/music/playUrl",
    params: {
      "mid": params["mid"],
      "type": params["type"] ?? 1,
    },
    cookie: cookie,
  );
}
