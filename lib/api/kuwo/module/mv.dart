part of '../kuwo.dart';

///MV推荐
///首播=236682871，华语=236682731，日韩=236742444，网络=236682773，欧美=236682735，现场=236742576，热舞=236682777，伤感=236742508，剧情=236742578
Future<Answer> _mvList(Map params, List<Cookie> cookie) {
  return _get(
    "http://www.kuwo.cn/api/www/music/mvList",
    params: {
      "pid": params["pid"] ?? "236682871",
      "pn": params["page"] ?? 1,
      "rn": params["size"] ?? 30,
    },
    cookie: cookie,
  );
}
