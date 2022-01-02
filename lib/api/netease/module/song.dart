part of '../netease.dart';

const _keys = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

// 歌曲详情
Future<Answer> _songDetail(Map params, List<Cookie> cookie) {
  params['ids'] = params['ids'].toString().split(RegExp(r'\s*,\s*'));
  return request(
    'POST',
    'https://music.163.com/api/v3/song/detail',
    {
      'c': '[' + params['ids'].map((id) => ('{"id":' + id + '}')).join(',') + ']',
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 更新歌曲顺序
Future<Answer> _songOrderUpdate(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'http://interface.music.163.com/api/playlist/manipulate/tracks',
    {
      'pid': params['pid'],
      'trackIds': params['ids'],
      'op': 'update',
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 歌曲链接
Future<Answer> _songUrl(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));

  if (!cookie.any((cookie) => cookie.name == 'MUSIC_U')) {
    String _createdSecretKey({int size = 16}) {
      StringBuffer buffer = StringBuffer();
      for (var i = 0; i < size; i++) {
        final position = math.Random().nextInt(_keys.length);
        buffer.write(_keys[position]);
      }
      return buffer.toString();
    }

    cookie = List.from(cookie)..add(Cookie('_ntes_nuid', _createdSecretKey()));
  }

  return eApiRequest(
    'https://interface3.music.163.com/eapi/song/enhance/player/url',
    '/api/song/enhance/player/url',
    {
      'ids': '[${params["id"]}]',
      'br': int.parse(params['br'] ?? '999000'),
    },
    cookies: cookie,
  );
}
// 已购单曲
Future<Answer> _songPurchased(Map params, List<Cookie> cookie) {
  final data = {
    'limit': params['limit'] ?? 20,
    'offset': params['offset'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/single/mybought/song/list',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

//歌曲上传
//TODO
Future<Answer> _songUpload(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'http://interface.music.163.com/',
    {
      'pid': params['pid'],
      'trackIds': params['ids'],
      'op': 'update',
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
