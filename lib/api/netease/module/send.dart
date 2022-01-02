part of '../netease.dart';

// 私信歌单
Future<Answer> _sendPlaylist(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', "pc"));

  final data = {
    'id': params['playlist'],
    'type': 'playlist',
    'msg': params['msg'],
    'userIds': '[${params['user_ids']}]'
  };
  return request(
    'POST',
    'https://music.163.com/weapi/msg/private/send',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 私信歌曲
Future<Answer> _sendSong(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', "ios"));
  cookie.add(Cookie('appver', "8.1.20"));

  final data = {
    'id': params['id'],
    'type': 'song',
    'msg': params['msg'],
    'userIds': '[${params['user_ids']}]'
  };
  return request(
    'POST',
    'https://music.163.com/api/msg/private/send',
    data,
    crypto: Crypto.linuxApi,
    cookies: cookie,
  );
}

// 私信
Future<Answer> _sendText(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', "pc"));

  final data = {
    'type': 'text',
    'msg': params['msg'],
    'userIds': '[${params['user_ids']}]'
  };
  return request(
    'POST',
    'https://music.163.com/weapi/msg/private/send',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
