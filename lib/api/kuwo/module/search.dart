part of '../kuwo.dart';

///搜索热词
Future<Answer> _hotSearch(Map params, List<Cookie> cookie) {
  return _get(
    "http://kuwo.cn/api/www/search/searchKey",
    params: {},
    cookie: cookie,
  );
}

///搜索单曲
Future<Answer> _searchMusic(Map params, List<Cookie> cookie) {
  //https://www.kuwo.cn/search/searchMusicBykeyWord?vipver=1&ft=music&encoding=utf8&mobi=1&pn=0&rn=20&all=%E8%96%9B%E4%B9%8B%E8%B0%A6
  return _get(
    "http://www.kuwo.cn/search/searchMusicBykeyWord",
    params: {
      "vipver": "1",
      "ft": "music",
      "encoding": "utf8",
      "mobi": "1",
      "all": params["keyWord"],
      "pn": params["page"] ?? 0,
      "rn": params["size"] ?? 30,
    },
    cookie: cookie,
  );
}

///搜索单曲
Future<Answer> _searchMusic2(Map params, List<Cookie> cookie) {
  return _get(
    "http://search.kuwo.cn/r.s",
    params: {
      "client": "kt",
      "all": params["keyWord"],
      "pn": params["page"] ?? 1,
      "rn": params["size"] ?? 30,
      "uid": "794762570",
      "ver": "kwplayer_ar_9.2.2.1",
      "vipver": "1",
      "show_copyright_off": "1",
      "newver": "1",
      "ft": "music",
      "cluster": "0",
      "strategy": "2012",
      "encoding": "utf8",
      "rformat": "json",
      "vermerge": "1",
      "mobi": "1",
      "issubtitle": "1",
    },
    cookie: cookie,
  );
}

///搜索专辑
Future<Answer> _searchAlbum(Map params, List<Cookie> cookie) {
  return _get(
    "http://www.kuwo.cn/api/www/search/searchAlbumBykeyWord",
    params: {
      "key": params["keyWord"],
      "pn": params["page"] ?? 1,
      "rn": params["size"] ?? 30,
    },
    cookie: cookie,
  );
}

///搜索MV
Future<Answer> _searchMv(Map params, List<Cookie> cookie) {
  return _get(
    "http://kuwo.cn/api/www/search/searchMvBykeyWord",
    params: {
      "key": params["keyWord"],
      "pn": params["page"] ?? 1,
      "rn": params["size"] ?? 30,
    },
    cookie: cookie,
  );
}

///搜索歌单
Future<Answer> _searchPlayList(Map params, List<Cookie> cookie) {
  return _get(
    "http://kuwo.cn/api/www/search/searchPlayListBykeyWord",
    params: {
      "key": params["keyWord"],
      "pn": params["page"] ?? 1,
      "rn": params["size"] ?? 30,
    },
    cookie: cookie,
  );
}

///搜索歌手
Future<Answer> _searchArtist(Map params, List<Cookie> cookie) {
  return _get(
    "http://kuwo.cn/api/www/search/searchArtistBykeyWord",
    params: {
      "key": params["keyWord"],
      "pn": params["page"] ?? 1,
      "rn": params["size"] ?? 30,
    },
    cookie: cookie,
  );
}
