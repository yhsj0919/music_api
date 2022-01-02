part of '../netease.dart';

// 推荐节目
Future<Answer> _programRecommend(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/program/recommend/v1',
    {
      'cateId': params['type'],
      'limit': params['limit'] ?? 10,
      'offset': params['offset'] ?? 0
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 每日推荐歌单
Future<Answer> _recommendResource(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/v1/discovery/recommend/resource',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 每日推荐歌曲
Future<Answer> _recommendSongs(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'ios'));
  return request(
    'POST',
    'https://music.163.com/api/v3/discovery/recommend/songs',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
