part of '../baidu.dart';

//albumNew
Future<Answer> _albumNew(Map query, List<Cookie> cookie) {
  return _get(
    "https://api-qianqian.taihe.com/v1/index",
    params: {},
    cookie: cookie,
  ).then((value) {
    var data = value.data;
    var album = (data["data"] as List?)?.lastWhere((element) => element["type"] == "album");
    data["data"] = album;
    return Future.value(value.copy(data: data));
  });
}

/*
 * 专辑列表，最新专辑
 * @param page 从1开始
 * @param size 默认20
*/
Future<Answer> _albumList(Map params, List<Cookie> cookie) {
  return _get(
    "https://api-qianqian.taihe.com/v1/album/list",
    params: LinkedHashMap.of({
      "pageNo": params['pageNo'] ?? 1,
      "pageSize": params['size'] ?? 20,
    }),
    cookie: cookie,
  );
}

/*
 * 专辑信息
 * @param albumAssetCode 专辑Id
*/
Future<Answer> _albumInfo(Map params, List<Cookie> cookie) {
  return _get(
    "https://api-qianqian.taihe.com/v1/album/info",
    params: LinkedHashMap.of({
      "albumAssetCode": params['albumAssetCode'],
      "appid": '16073360',
    }),
    cookie: cookie,
  );
}
