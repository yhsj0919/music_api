part of '../kuwo.dart';

Future<Answer> _songNew(Map params, List<Cookie> cookie) {
  return _get(
    "http://mobi.kuwo.cn/mobiweb.s",
    params: {
      "prod": "kwplayer_ar_10.0.7.0",
      "type": "zuixinyinyue",
    },
    cookie: cookie,
  );
}

///播放地址
Future<Answer> _playUrl(Map params, List<Cookie> cookie) {
  //http://antiserver.kuwo.cn/anti.s?format=mp3&rid=228908&response=url&type=convert_url3&br=320kmp3
  return _get(
    "http://antiserver.kuwo.cn/anti.s",
    params: {
      "rid": params["rid"],
      "format": params["format"],
      "response": "url",
      "type": "convert_url3",
      "br": "320kmp3",
    },
    cookie: cookie,
  );
}

///备用，不支持收费音乐
Future<Answer> _playUrl2(Map params, List<Cookie> cookie) {
  //http://antiserver.kuwo.cn/anti.s?format=mp3&rid=228908&response=url&type=convert_url3
  return _get(
    "http://www.kuwo.cn/api/v1/www/music/playUrl",
    params: {
      "mid": params["mid"],
      "type": params["type"] ?? "music",
    },
    cookie: cookie,
  );
}
