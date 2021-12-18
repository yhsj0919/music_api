part of '../kugou.dart';

///搜索提示
Future<Answer> _searchTip(Map params, List<Cookie> cookie) {
  return _get(
    "https://searchtip.kugou.com/getSearchTip",
    params: {
      "keyword": params["keyword"],
      "MusicTipCount": "5",
      "MVTipCount": "2",
      "albumcount": "2",
    },
    cookie: cookie,
  );
}

///搜索单曲
Future<Answer> _searchSong(Map params, List<Cookie> cookie) {
  return _get(
    "http://mobilecdnbj.kugou.com/api/v3/search/song",
    params: {
      "keyword": params["keyword"],
      "page": params["page"] ?? 1,
      "pagesize": params["size"] ?? 30,
    },
    cookie: cookie,
  );
}

///搜索专辑
Future<Answer> _searchAlbum(Map params, List<Cookie> cookie) {
  return _get(
    "http://mobilecdnbj.kugou.com/api/v3/search/album",
    params: {
      "keyword": params["keyword"],
      "page": params["page"] ?? 1,
      "pagesize": params["size"] ?? 30,
    },
    cookie: cookie,
  );
}

///搜索MV
Future<Answer> _searchMv(Map params, List<Cookie> cookie) {
  return _get(
    "http://mobilecdnbj.kugou.com/api/v3/search/mv",
    params: {
      "keyword": params["keyword"],
      "page": params["page"] ?? 1,
      "pagesize": params["size"] ?? 30,
    },
    cookie: cookie,
  );
}

///搜索歌单

Future<Answer> _searchPlayList(Map params, List<Cookie> cookie) {
  return _get(
    "http://mobilecdn.kugou.com/api/v3/search/special",
    params: {
      "keyword": params["keyword"],
      "page": params["page"] ?? 1,
      "pagesize": params["size"] ?? 30,
      "showtype": 1,
    },
    cookie: cookie,
  );
}
