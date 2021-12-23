part of '../qq.dart';

/*
 * 搜索建议
 * https://c.y.qq.com/splcloud/fcgi-bin/smartbox_new.fcg?format=json&key=周杰伦
 */
Future<Answer> searchSuggest(Map params, List<Cookie> cookie) {
  final data = {
    "format": "json",
    "key": params["key"],
  };
  return _get(

    "https://c.y.qq.com/splcloud/fcgi-bin/smartbox_new.fcg",
    params: data,
    cookie: cookie,
  );
}

/*
 *搜索
 * t 0:单曲, 1:相关歌手,2:专辑,3:歌单,4:MV,7:歌词,8:用户
 */
Future<Answer> search(Map params, List<Cookie> cookie) {
  final num = params['num'] ?? 20;
  final page = params['page'] ?? 1;

  final data = {
    "data": json.encode({
      "comm": {"mina": 1, "ct": 25},
      "req": {
        "method": "DoSearchForQQMusicMobile",
        "module": "music.search.SearchBrokerCgiServer",
        "param": {
          "search_type": params['type'] ?? 0,
          "query": params['key'],
          "page_num": page,
          "num_per_page": num,
        }
      }
   })
  };
  return _get(

    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    params: data,
    cookie: cookie,
  );
}
