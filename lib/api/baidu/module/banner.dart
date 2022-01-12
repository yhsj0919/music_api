part of '../baidu.dart';

//banner
Future<Answer> _banner(Map query, List<Cookie> cookie) {
  return _get(
    "https://api-qianqian.taihe.com/v1/index",
    params: {},
    cookie: cookie,
  ).then((value) {
    var data = value.data;
    var banner = (data["data"] as List?)?.firstWhere((element) => element["type"] == "banner");
    data["data"] = banner;
    return Future.value(value.copy(data: data));
  });
}
