part of '../baidu.dart';

/*
 * 歌单分类
*/
Future<Answer> _playListType(Map params, List<Cookie> cookie) {
  return _get(
    "https://api-qianqian.taihe.com/v1/tracklist/category",
    params: {},
    cookie: cookie,
  );
}

/*
 * 歌单分类详情
*/
Future<Answer> _playList(Map params, List<Cookie> cookie) {
  LinkedHashMap<String, dynamic> data = LinkedHashMap();
  data['pageNo'] = params['page'] ?? 1;
  data['pageSize'] = params['size'] ?? 20;

  if (params['subCateId'] != null) {
    data['subCateId'] = params['subCateId'];
  }
  return _get(
    "https://api-qianqian.taihe.com/v1/tracklist/list",
    params: data,
    cookie: cookie,
  );
}

/*
 * 歌单详情、推荐歌单
*/
Future<Answer> _playListInfo(Map params, List<Cookie> cookie) {
  LinkedHashMap<String, dynamic> data = LinkedHashMap();
  data['id'] = params['id'];
  data['pageNo'] = params['page'] ?? 1;
  data['pageSize'] = params['size'] ?? 20;
  return _get(
    "https://api-qianqian.taihe.com/v1/tracklist/info",
    params: data,
    cookie: cookie,
  );
}
