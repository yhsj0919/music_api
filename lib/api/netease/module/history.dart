part of '../netease.dart';

// 历史每日推荐歌曲详情
Future<Answer> _historyRecommendSongsDetail(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'ios'));
  return request(
    'POST',
    'https://music.163.com/api/discovery/recommend/songs/history/detail',
    {"data": params['data']},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 历史每日推荐歌曲
Future<Answer> _historyRecommendSongs(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'ios'));
  return request(
    'POST',
    'https://music.163.com/api/discovery/recommend/songs/history/recent',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
