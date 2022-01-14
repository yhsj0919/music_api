part of '../baidu.dart';

/*
 * 搜索
 * @param type 0全部、1单曲、3专辑、2歌手
 * 0没有分页，其他有 pageNo、pageSize
 * @param word 搜索关键词
*/
Future<Answer> _search(Map params, List<Cookie> cookie) {
  LinkedHashMap<String, dynamic> data = LinkedHashMap();
  if ((params['type'] ?? 0) != 0) {
    data['pageNo'] = params['page'] ?? 1;
    data['pageSize'] = params['size'] ?? 20;
    data['timestamp'] = DateTime.now().millisecondsSinceEpoch;
    data['type'] = params['type'] ?? 0;
    data['word'] = params['keyWord'];
  } else {
    data['timestamp'] = DateTime.now().millisecondsSinceEpoch;
    data['type'] = params['type'] ?? 0;
    data['word'] = params['word'];
  }

  return _get(
    "https://api-qianqian.taihe.com/v1/search",
    params: data,
    cookie: cookie,
  );
}

/*
 * 搜索热词
 * @param word 搜索关键词
*/
Future<Answer> _searchSug(Map params, List<Cookie> cookie) {
  LinkedHashMap<String, dynamic> data = LinkedHashMap();
  data['timestamp'] = DateTime.now().millisecondsSinceEpoch;
  data['word'] = params['word'];
  return _get(
    "https://api-qianqian.taihe.com/v1/search/sug",
    params: data,
    cookie: cookie,
  );
}
