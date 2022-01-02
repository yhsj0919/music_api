part of '../netease.dart';

// 心动模式/智能播放
Future<Answer> _playmodeIntelligenceList(Map params, List<Cookie> cookie) {
  return request(
      'POST',
      'http://music.163.com/weapi/playmode/intelligence/list',
      {
        'songId': params['id'],
        'type': "fromPlayOne",
        'playlistId': params['pid'],
        'startMusicId': params['sid'] ?? params['id'],
        'count': params['count'] ?? 1
      },
      crypto: Crypto.weApi,
      cookies: cookie);
}
