part of '../my_free_mp3.dart';

///搜索
///sort data:0,Longest:1,Popular:2
Future<Answer> _search(Map params, List<Cookie> cookie) {
  return _post(
    "https://myfreemp3juices.cc/api/search.php",
    params: {
      "q": params['keyWords'],
      "page": params['page'] ?? 0,
      "sort": params['sort'] ?? 0,
    },
    cookie: cookie,
  );
}
