part of '../qq.dart';

/*
 * 榜单信息
 */
Future<Answer> toplistInfo(Map params, List<Cookie> cookie) {
  final num = params['num'] ?? 20;
  final page = params['page'] ?? 1;
  final start = (page - 1) * num;

  final data = {
    "data": {
      "req_0": {
        "module": "musicToplist.ToplistInfoServer",
        "method": "GetAll",
        "param": {},
      },
      "comm": {
        "g_tk": 709041629,
        "uin": "0",
        "format": "json",
        "ct": 20,
        "cv": 1803,
        "platform": "wk_v17",
      }
   }
  };
  return _get(

    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    params: data,
    cookie: cookie,
  );
}

/*
 * 榜单歌曲
 */
Future<Answer> toplistDetail(Map params, List<Cookie> cookie) {
  final num = params['num'] ?? 20;
  final page = params['page'] ?? 1;
  final start = (page - 1) * num;

  final data = {
    "data": {
      "req_0": {
        "module": "musicToplist.ToplistInfoServer",
        "method": "GetDetail",
        "param": {"topid": 62, "num": 300, "period": "2021-03-10"}
      },
      "comm": {
        "g_tk": 709041629,
        "uin": "0",
        "format": "json",
        "ct": 20,
        "cv": 1803,
        "platform": "wk_v17",
      }
   }
  };
  return _get(

    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    params: data,
    cookie: cookie,
  );
}
