part of '../netease.dart';

Future<Answer> _scrobble(Map params, List<Cookie> cookie) {
  final data = {
    'logs': json.encode([
      {
        'action': 'play',
        'json': {
          'download': 0,
          'end': 'playend',
          'id': params['id'],
          'sourceId': params['sourceId'],
          'time': params['time'],
          'type': 'song',
        }
      }
    ]),
  };

  return request(
    'POST',
    'https://music.163.com/weapi/feedback/weblog',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
