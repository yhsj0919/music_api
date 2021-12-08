part of '../baidu.dart';

//收藏
//restype:video,artist,song,tracklist,album
Future<Answer> _favorite(Map params, List<Cookie> cookie) {
  return _post(
    "https://api-qianqian.taihe.com/v1/favorite/create",
    params: LinkedHashMap.of({
      "code": params['code'],
      "restype": params['restype'],
    }),
    cookie: cookie,
  );
}

//取消收藏
//restype:video,artist,song,tracklist,album
Future<Answer> _favoriteDelete(Map params, List<Cookie> cookie) {
  return _post(
    "https://api-qianqian.taihe.com/v1/favorite/delete",
    params: LinkedHashMap.of({
      "code": params['code'],
      "restype": params['restype'],
    }),
    cookie: cookie,
  );
}

/*
 * 收藏的列表
 * restype:video,artist,song,tracklist,album
 */
Future<Answer> _favoriteList(Map params, List<Cookie> cookie) {
  return _get(
    "https://api-qianqian.taihe.com/v1/favorite/song",
    params: LinkedHashMap.of({
      "pageNo": params['pageNo'] ?? 1,
      "pageSize": params['size'] ?? 20,
      "restype": params['restype'],
    }),
    cookie: cookie,
  );
}
