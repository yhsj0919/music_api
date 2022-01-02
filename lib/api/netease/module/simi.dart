part of '../netease.dart';

// 相似歌手
Future<Answer> _simiArtist(Map params, List<Cookie> cookie) {
  if (cookie.where((element) => element.name == "MUSIC_U").isEmpty) {
    cookie.add(Cookie('MUSIC_A',
        '8aae43f148f990410b9a2af38324af24e87ab9227c9265627ddd10145db744295fcd8701dc45b1ab8985e142f491516295dd965bae848761274a577a62b0fdc54a50284d1e434dcc04ca6d1a52333c9a'));
  }

  return request(
    'POST',
    'https://music.163.com/weapi/discovery/simiArtist',
    {
      'artistid': params['id'],
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 相似MV
Future<Answer> _simiMv(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/discovery/simiMv',
    {
      'mvid': params['mvid'],
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 相似歌单
Future<Answer> _simiPlaylist(Map params, List<Cookie> cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/discovery/simiPlaylist',
      {
        'playlistid': params['playlistid'],
        'limit': params['limit'] ?? 50,
        'offset': params['offset'] ?? 0
      },
      crypto: Crypto.weApi,
      cookies: cookie);
}

// 相似歌曲
Future<Answer> _simiSong(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/discovery/simiSong',
    {
      'songid': params['id'],
      'limit': params['limit'] ?? 50,
      'offset': params['offset'] ?? 0
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

Future<Answer> _simiUser(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/discovery/simiUser',
    {
      'songid': params['id'],
      'limit': params['limit'] ?? 50,
      'offset': params['offset'] ?? 0
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
