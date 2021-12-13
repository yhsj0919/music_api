part of '../kugou.dart';

///热门歌单
Future<Answer> _playList(Map params, List<Cookie> cookie) {
  return _get(
    "http://m.kugou.com/plist/index",
    params: {
      "page": params["page"] ?? 1,
      "json": "true",
    },
    cookie: cookie,
  );
}

///@params id : specialid
Future<Answer> _playListInfo(Map params, List<Cookie> cookie) {
  var id = params["id"];

  return _get(
    "http://m.kugou.com/plist/list/$id",
    params: {
      "json": "true",
    },
    cookie: cookie,
  );
}
