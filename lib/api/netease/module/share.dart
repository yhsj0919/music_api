part of '../netease.dart';

// 分享歌曲到动态
Future<Answer> _shareResource(Map params, List<Cookie> cookie) {
  final data = {
    'type': params['type'] ?? 'song', // song,playlist,mv,djprogram,djradio,noresource
    'msg': params['msg'] ?? '',
    'id': params['id'] ?? '',
  };
  return request(
    'POST',
    'https://music.163.com/weapi/share/friends/resource',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}


