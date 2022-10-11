part of '../netease.dart';

// 歌单打卡
Future<Answer> _playlistUpdatePlaycount(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/playlist/update/playcount',
    {"id": params["id"]},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
