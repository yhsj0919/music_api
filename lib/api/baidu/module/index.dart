part of '../baidu.dart';

//首页
Future<Answer> _index(Map query, List<Cookie> cookie) {
  return _get(
    "https://api-qianqian.taihe.com/v1/index",
    params: {},
    cookie: cookie,
  );
}
