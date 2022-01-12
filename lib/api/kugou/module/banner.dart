part of '../kugou.dart';

///banner
Future<Answer> _banner(Map params, List<Cookie> cookie) {
  return _get(
    "https://m.kugou.com",
    params: {"json": "true"},
    cookie: cookie,
  ).then((value) {
    var body = value.data;
    body.remove("data");
    return Future.value(value.copy(data: body));
  });
}
