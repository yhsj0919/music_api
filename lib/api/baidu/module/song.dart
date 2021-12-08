part of '../baidu.dart';

/*
 * 新歌推荐
 * @param page 从1开始
 * @param size 默认20
*/
Future<Answer> _songList(Map params, List<Cookie> cookie) {
  return _get(
    "https://api-qianqian.taihe.com/v1/song/list",
    params: LinkedHashMap.of({
      "pageNo": params['pageNo'] ?? 1,
      "pageSize": params['size'] ?? 20,
    }),
    cookie: cookie,
  );
}

/*
 * 歌曲信息(播放地址。Vip歌曲只能获取30秒)
 * @param tsId 歌曲Id
*/
Future<Answer> _songInfo(Map params, List<Cookie> cookie) {
  return _get(
    "https://api-qianqian.taihe.com/v1/song/tracklink",
    params: LinkedHashMap.of({
      "TSID": params['tsId'],
      "appid": '16073360',
      "rate": params['rate'] ?? 320,
    }),
    cookie: cookie,
  );
}

/*
 * 歌曲下载
 * @param tsId 歌曲Id
*/
Future<Answer> _songDownload(Map params, List<Cookie> cookie) {
  return _get(
    "https://api-qianqian.taihe.com/v1/song/download",
    params: LinkedHashMap.of({
      "TSID": params['tsId'],
      "appid": '16073360',
      "rate": params['rate'] ?? 320,
    }),
    cookie: cookie,
  );
}
