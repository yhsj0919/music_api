part of '../migu.dart';

///Banner
Future<Answer> _banner(Map params, List<Cookie> cookie) {
  return _get(
    "https://m.music.migu.cn/migumusic/h5/home/banner",
    params: {},
    cookie: cookie,
  );
}
