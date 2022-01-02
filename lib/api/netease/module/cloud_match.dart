part of '../netease.dart';

//云盘歌曲信息匹配纠正
Future<Answer> _cloudMatch (Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));
  cookie.add(Cookie('appver', '8.1.20'));

  final data = {
    'userId': params['uid'],
    'songId': params['sid'],
    'adjustSongId': params['asid'],
  };
  return request(
    'POST',
    'https://music.163.com/api/cloud/user/song/match',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
