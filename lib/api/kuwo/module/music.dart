part of '../kuwo.dart';

///歌曲信息
Future<Answer> _musicInfo(Map params, List<Cookie> cookie) {
  return _get(
    "http://www.kuwo.cn/api/www/music/musicInfo",
    params: {
      "mid": params["mid"],
    },
    cookie: cookie,
  );
}
