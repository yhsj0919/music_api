part of '../baidu.dart';

//开屏
Future<Answer> _openScreen(Map params, List<Cookie> cookie) {
  return _get(
    "https://api-qianqian.taihe.com/v1/ad/openscreen",
    params: {},
    cookie: cookie,
  );
}
