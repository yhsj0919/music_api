part of '../netease.dart';

// 将mlog id转为video id
Future<Answer> _mlogToVideo (Map params, List<Cookie> cookie) {
  final data = {
    'mlogId': params['id'],
  };
  return request(
    'POST',
    'https://music.163.com/weapi/mlog/video/convert/id',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// mlog链接
Future<Answer> _mlogUrl (Map params, List<Cookie> cookie) {
  final data = {
    'id': params['id'],
    'resolution': params['res'] ?? 1080,
    'type': 1,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/mlog/detail/v1',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
// 歌曲相关视频
Future<Answer> _mlogMusicRcmd (Map params, List<Cookie> cookie) {
  final data = {
    'id': params['mvid'] ?? 0,
    'type': 2,
    'rcmdType': 20,
    'limit': params['limit'] ?? 10,
    'extInfo': json.encode({
      'songId': params['songId'],
    }),
  };
  return request(
    'POST',
    'https://interface.music.163.com/eapi/mlog/rcmd/feed/list',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
