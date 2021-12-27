part of '../baidu.dart';

/*
 * 榜单分类
*/
Future<Answer> _rankType(Map params, List<Cookie> cookie) {
  return _get(
    "https://api-qianqian.taihe.com/v1/bd/category",
    params: {},
    cookie: cookie,
  );
}

/*
 * 榜单列表
*/
Future<Answer> _rankList(Map params, List<Cookie> cookie) {
  LinkedHashMap<String, dynamic> data = LinkedHashMap();
  data['bdid'] = params['bdid'];
  data['pageNo'] = params['page'] ?? 1;
  data['pageSize'] = params['size'] ?? 20;
  return _get(
    "https://api-qianqian.taihe.com/v1/bd/list",
    params: data,
    cookie: cookie,
  );
}
