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

///歌词
Future<Answer> _musicLrc(Map params, List<Cookie> cookie) {
  return _get(
    "http://m.kuwo.cn/newh5/singles/songinfoandlrc",
    params: {
      "musicId": params["musicId"],
    },
    cookie: cookie,
  );
}
