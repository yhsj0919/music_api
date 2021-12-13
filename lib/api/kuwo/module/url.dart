part of '../kuwo.dart';

///播放地址
Future<Answer> _playUrl(Map params, List<Cookie> cookie) {
  http://kuwo.cn/url?rid=156991791&response=url&format=mp4|mkv&type=convert_url
  https://kuwo.cn/url?format=mp3&rid=155925915&response=url&type=convert_url3&br=128kmp3
  return _get(
    "http://www.kuwo.cn/api/v1/www/music/playUrl",
    params: {
      "mid": params["mid"],
      "type": params["type"] ?? "music",
    },
    cookie: cookie,
  );
}
