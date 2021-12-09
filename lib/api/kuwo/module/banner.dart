part of '../kuwo.dart';

///banner
Future<Answer> _banner(Map params, List<Cookie> cookie) {
  return _get(
    "http://www.kuwo.cn/api/www/banner/index/bannerList",
    params: {},
    cookie: cookie,
  );
}
