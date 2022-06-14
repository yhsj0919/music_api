part of '../kuwo.dart';

///歌手列表
///prefix A-Z ，#
///category 0 = 全部 1 = 华语男 2 = 华语女 3 = 华语组合 4 = 日韩男 5 = 日韩女 6 = 日韩组合 7 = 欧美男 8 = 欧美女 9 = 欧美组合 10 = 其他
Future<Answer> _artistList(Map params, List<Cookie> cookie) {
  return _get(
    "http://kuwo.cn/api/www/artist/artistInfo",
    params: {
      "category": params["category"]??"0",
      "prefix": params["prefix"]??"",
      "pn": params["page"] ?? 1,
      "rn": params["size"] ?? 100,
    },
    cookie: cookie,
  );
}

///歌手详情
Future<Answer> _artistInfo(Map params, List<Cookie> cookie) {
  return _get(
    "http://www.kuwo.cn/api/www/artist/artist",
    params: {
      "artistid": params["artistId"],
    },
    cookie: cookie,
  );
}

///歌手单曲
Future<Answer> _artistMusic(Map params, List<Cookie> cookie) {
  return _get(
    "http://www.kuwo.cn/api/www/artist/artistMusic",
    params: {
      "artistid": params["artistId"],
      "pn": params["page"] ?? 1,
      "rn": params["size"] ?? 100,
    },
    cookie: cookie,
  );
}

///歌手专辑
Future<Answer> _artistAlbum(Map params, List<Cookie> cookie) {
  return _get(
    "http://www.kuwo.cn/api/www/artist/artistAlbum",
    params: {
      "artistid": params["artistId"],
      "pn": params["page"] ?? 1,
      "rn": params["size"] ?? 100,
    },
    cookie: cookie,
  );
}

///歌手MV
Future<Answer> _artistMv(Map params, List<Cookie> cookie) {
  return _get(
    "http://www.kuwo.cn/api/www/artist/artistMv",
    params: {
      "artistid": params["artistId"],
      "pn": params["page"] ?? 1,
      "rn": params["size"] ?? 100,
    },
    cookie: cookie,
  );
}
