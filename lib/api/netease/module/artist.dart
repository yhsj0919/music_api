part of '../netease.dart';

// 歌手专辑列表
Future<Answer> _artistAlbum(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    "https://music.163.com/weapi/artist/albums/${params['id']}",
    {'limit': params['limit'] ?? 30, 'offset': params['offset'] ?? 0, 'total': true},
    cookies: cookie,
    crypto: Crypto.weApi,
  );
}

//歌手介绍
Future<Answer> _artistDesc(Map params, List<Cookie> cookie) => request(
      'POST',
      'https://music.163.com/weapi/artist/introduction',
      {'id': params['id']},
      crypto: Crypto.weApi,
      cookies: cookie,
    );

//歌手介详情
Future<Answer> _artistDetail(Map params, List<Cookie> cookie) => request(
      'POST',
      'https://music.163.com/api/artist/head/info/get',
      {'id': params['id']},
      crypto: Crypto.weApi,
      cookies: cookie,
    );

//歌手分类

/*
  initial 取值 a-z/A-Z
  type 取值
  1:男歌手
  2:女歌手
  3:乐队

  area 取值
  -1:全部
  7华语
  96欧美
  8:日本
  16韩国
  0:其他
 */
Future<Answer> _artistList(Map params, List<Cookie> cookie) {
  return request(
      'POST',
      'https://music.163.com/api/v1/artist/list',
      {
        'initial': (params['initial'] as String).toUpperCase().codeUnitAt(0),
        'offset': params['offset'] ?? 0,
        'limit': params['limit'] ?? 30,
        'total': true,
        'type': params['type'] ?? '1',
        'area': params['area']
      },
      cookies: cookie,
      crypto: Crypto.weApi);
}

// 歌手相关MV
Future<Answer> _artistMv(Map params, List<Cookie> cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/artist/mvs',
      {
        'artistId': params['id'],
        'limit': params['limit'],
        'offset': params['offset'],
        'total': true,
      },
      crypto: Crypto.weApi,
      cookies: cookie);
}

// 歌手相关视频
Future<Answer> _artistVideo(Map params, List<Cookie> cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/mlog/artist/video',
      {
        'artistId': params['id'],
        'page': {
          "size": params["size"] ?? 10,
          "cursor": params["cursor"] ?? 0,
        },
        'tab': 0,
        'order': params["order"] ?? 0,
      },
      crypto: Crypto.weApi,
      cookies: cookie);
}

// 歌手新MV
Future<Answer> _artistNewMv(Map params, List<Cookie> cookie) {
  cookie.add(Cookie("os", 'ios'));
  cookie.add(Cookie("appver", '8.1.20'));

  return request(
      'POST',
      'https://music.163.com/api/sub/artist/new/works/mv/list',
      {
        'limit': params['limit'] ?? 20,
        'startTimestamp': params['before'] ?? DateTime.now(),
      },
      cookies: cookie,
      crypto: Crypto.weApi);
}

// 歌手新歌
Future<Answer> _artistNewSong(Map params, List<Cookie> cookie) {
  cookie.add(Cookie("os", 'ios'));
  cookie.add(Cookie("appver", '8.1.20'));

  return request(
      'POST',
      'https://music.163.com/api/sub/artist/new/works/song/list',
      {
        'limit': params['limit'] ?? 20,
        'startTimestamp': params['before'] ?? DateTime.now(),
      },
      cookies: cookie,
      crypto: Crypto.weApi);
}

// 歌手歌曲
Future<Answer> _artistSongs(Map params, List<Cookie> cookie) {
  cookie.add(Cookie("os", 'pc'));

  return request(
      'POST',
      'https://music.163.com/api/v1/artist/songs',
      {
        'id': params['id'],
        'private_cloud': true,
        'work_type': 1,
        'order': params['order'] ?? 'hot', //hot,time
        'offset': params['offset'] ?? 0,
        'limit': params['limit'] ?? 100,
      },
      cookies: cookie,
      crypto: Crypto.weApi);
}

// 收藏与取消收藏歌手
Future<Answer> _artistSub(Map params, List<Cookie> cookie) {
  final type = params['t'] == 1 ? 'sub' : 'unsub';

  return request(
      'POST',
      'https://music.163.com/weapi/artist/$type',
      {
        'artistId': params['id'],
        'artistIds': '[${params['id']}]',
      },
      cookies: cookie,
      crypto: Crypto.weApi);
}

// 关注歌手列表
Future<Answer> _artistSubList(Map params, List<Cookie> cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/artist/sublist',
      {
        'limit': params['limit'] ?? 25,
        'offset': params['offset'] ?? 0,
        'total': true,
      },
      cookies: cookie,
      crypto: Crypto.weApi);
}

// 歌手热门 50 首歌曲
Future<Answer> _artistTopSong(Map params, List<Cookie> cookie) {
  return request(
      'POST',
      'https://music.163.com/api/artist/top/song',
      {
        'id': params['id'],
      },
      cookies: cookie,
      crypto: Crypto.weApi);
}

// 歌手单曲
Future<Answer> _artists(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/v1/artist/${params["id"]}',
    {},
    cookies: cookie,
    crypto: Crypto.weApi,
  );
}

// 歌手粉丝
Future<Answer> _artistFans(Map params, List<Cookie> cookie) {
  final data = {
    'id': params['id'],
    'limit': params['limit'] ?? 20,
    'offset': params['offset'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/v1/artist/${params["id"]}',
    data,
    cookies: cookie,
    crypto: Crypto.weApi,
  );
}
