part of '../netease.dart';

// 红心与取消红心歌曲
Future<Answer> _like(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));
  cookie.add(Cookie('appver', '2.9.7'));

  final data = {
    "alg": 'itembased',
    'trackId': params['id'],
    'like': params['like'] == 'false' ? false : true,
    "time":3,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/radio/like',
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
