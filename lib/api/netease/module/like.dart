part of '../netease.dart';

// 红心与取消红心歌曲
Future<Answer> _like(Map params, List<Cookie> cookie) {
  final data = {
    'trackId': params['id'],
    'like': params['like'] == 'false' ? false : true,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/radio/like?alg=${params["alg"] ?? "itembased"}&trackId=${params["id"]}&time=${params["time"] ?? 25}',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 喜欢的歌曲(无序)
Future<Answer> _likelist(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/song/like/get',
    {"uid": params['uid']},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
