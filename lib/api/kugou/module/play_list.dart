part of '../kugou.dart';

///热门歌单
Future<Answer> _playList(Map params, List<Cookie> cookie) {
  return _get(
    "https://m.kugou.com/plist/index",
    params: {
      "page": params["page"] ?? 1,
      "json": "true",
    },
    cookie: cookie,
  );
}

///@params id : specialid
Future<Answer> _playListInfo(Map params, List<Cookie> cookie) {
  return _get(
    "https://m.kugou.com/plist/list/${params["id"]}",
    params: {
      "page": params["page"] ?? 1,
      "json": "true",
    },
    cookie: cookie,
  );
}
