part of '../migu.dart';

/*
* 榜单
 */
Future<Answer> topList(Map params, List<Cookie> cookie) {
  final data = {
    "templateVersion": '11',
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/rank-list/release",
    params: data,
    cookie: cookie,
  );
}

/*
* 榜单详情
 */
Future<Answer> topListDetail(Map params, List<Cookie> cookie) {
  final data = {
    "columnId": params['columnId'],
    "needAll": '0',
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM2.0/v1.0/content/querycontentbyId.do",
    params: data,
    cookie: cookie,
  );
}
