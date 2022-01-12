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
  return _get(
    "http://kuwo.cn/api/www/search/searchMusicBykeyWord",
    params: {
      "key": params["keyWord"],
      "pn": params["page"] ?? 1,
      "rn": params["size"] ?? 30,
    },
    cookie: cookie,
  );
}

///搜索专辑
Future<Answer> _searchAlbum(Map params, List<Cookie> cookie) {
  return _get(
    "http://kuwo.cn/api/www/search/searchAlbumBykeyWord",
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
