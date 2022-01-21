part of '../netease.dart';

// 全部歌单分类
Future<Answer> _playlistCatlist(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/playlist/catalogue',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 创建歌单
Future<Answer> _playlistCreate(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));

  return request(
    'POST',
    'https://music.163.com/api/playlist/create',
    {
      'name': params['name'],
      'privacy': params['privacy'], //0 为普通歌单，10 为隐私歌单
      'type': params['type'] ?? 'NORMAL', // NORMAL|VIDEO|SHARED
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 删除歌单
Future<Answer> _playlistDelete(Map params, List<Cookie> cookie) {
  return request(
      'POST',
      'https://music.163.com/weapi/playlist/remove',
      {
        'ids': '[${params['id']}]',
      },
      crypto: Crypto.weApi,
      cookies: cookie);
}

// 更新歌单描述
Future<Answer> _playlistDescUpdate(Map params, List<Cookie> cookie) {
  return eApiRequest(
    url: 'https://interface3.music.163.com/eapi/playlist/desc/update',
    optionUrl: '/api/playlist/desc/update',
    data: {
      'id': params['id'],
      'desc': params['desc'],
    },
    cookies: cookie,
  );
}

// 初始化名字
Future<Answer> _playlistDetailDynamic(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/playlist/detail/dynamic',
    {
      'id': params['id'],
      's': params['s'] ?? 8,
      'n': 100000,
    },
    crypto: Crypto.linuxApi,
    cookies: cookie,
  );
}

// 歌单详情
//说明 : 由于网易云接口限制，歌单详情只会提供10首歌，通过调用_playlistTrackAll接口，传入对应的歌单`id`，即可获得对应的所有歌曲，
Future<Answer> _playlistDetail(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/v3/playlist/detail',
    {
      'id': params['id'],
      'n': 100000,
      's': params['s'] ?? 8,
    },
    crypto: Crypto.linuxApi,
    cookies: cookie,
  );
}

// 通过传过来的歌单id拿到所有歌曲数据
// 支持传递参数limit来限制获取歌曲的数据数量 例如: /playlist/track/all?id=7044354223&limit=10
Future<Answer> _playlistTrackAll(Map params, List<Cookie> cookie) {
  var page = params["page"] ?? 0;
  var size = params["size"] ?? 100000;
  var offset = page * size;

  return request(
    'POST',
    'https://music.163.com/api/v6/playlist/detail',
    {
      'id': params['id'],
      'n': 100000,
      's': params['s'] ?? 8,
    },
    crypto: Crypto.linuxApi,
    cookies: cookie,
  ).then((value) {
    var data = value.data;

    var trackIds = (data["playlist"]?["trackIds"] as List?)?.map((e) => '{"id": ${e["id"]}}').toList();

    var ids = [];
    trackIds?.forEach((element) {
      var index = trackIds.indexOf(element);

      if (index >= offset && index < offset + size) {
        ids.add(element);
      }
    });

    return request(
      'POST',
      'https://music.163.com/api/v3/song/detail',
      {
        'c': '[${ids.join(",")}]',
      },
      crypto: Crypto.linuxApi,
      cookies: cookie,
    );
  });
}

// 精品歌单 tags
Future<Answer> _playlistHighqualityTags(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/playlist/highquality/tags',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 热门歌单分类
Future<Answer> _playlistHot(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/playlist/hottags',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 我喜欢的歌单
Future<Answer> _playlistMyLike(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/mlog/playlist/mylike/bytime/get',
    {
      'time': params['time'] ?? '-1',
      'limit': params['limit'] ?? '12',
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 更新歌单名
Future<Answer> _playlistNameUpdate(Map params, List<Cookie> cookie) {
  final data = {
    'id': params['id'],
    'name': params['name'],
  };

  return eApiRequest(
    url: 'https://interface3.music.163.com/eapi/playlist/update/name',
    optionUrl: '/api/playlist/update/name',
    data: data,
    cookies: cookie,
  );
}

// 编辑歌单顺序
Future<Answer> _playlistOrderUpdate(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));
  final data = {
    'ids': params['ids'],
  };

  return request(
    'POST',
    'https://music.163.com/api/playlist/order/update',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 收藏与取消收藏歌单
Future<Answer> _playlistSubscribe(Map params, List<Cookie> cookie) {
  params['t'] = (params['t'] == 1 ? 'subscribe' : 'unsubscribe');
  return request(
      'POST',
      'https://music.163.com/weapi/playlist/${params['t']}',
      {
        'id': params['id'],
      },
      crypto: Crypto.weApi,
      cookies: cookie);
}

// 歌单收藏者
Future<Answer> _playlistSubscribers(Map params, List<Cookie> cookie) {
  return request('POST', 'https://music.163.com/weapi/playlist/subscribers', {'id': params['id'], 'limit': params['limit'] ?? 20, 'offset': params['offset'] ?? 0},
      crypto: Crypto.weApi, cookies: cookie);
}

// 更新歌单名
Future<Answer> _playlistTagsUpdate(Map params, List<Cookie> cookie) {
  final data = {
    'id': params['id'],
    'tags': params['tags'],
  };

  return eApiRequest(
    url: 'https://interface3.music.163.com/eapi/playlist/tags/update',
    optionUrl: '/api/playlist/tags/update',
    data: data,
    cookies: cookie,
  );
}

// 收藏单曲到歌单
Future<Answer> _playlistTrackAdd(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));
  params['ids'] = params['ids'] ?? '';
  final data = {
    'id': params['pid'],
    'tracks': json.encode(
      params['ids'].toString().split(',').map((e) => {'type': 3, 'id': e}).toList(),
    ),
  };
  return request(
    'POST',
    'https://music.163.com/api/playlist/track/add',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

//从歌单删除歌曲
Future<Answer> _playlistTrackDelete(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));
  params['ids'] = params['ids'] ?? '';
  final data = {
    'id': params['pid'],
    'tracks': json.encode(
      params['ids'].toString().split(',').map((e) => {'type': 3, 'id': e}).toList(),
    ),
  };
  return request(
    'POST',
    'https://music.163.com/api/playlist/track/delete',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 收藏单曲到歌单 从歌单删除歌曲
Future<Answer> _playlistTracks(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));
  final tracks = params['tracks'].toString().split(',').toList();

  final data = {
    'op': params['op'], // del,add
    'pid': params['pid'], // 歌单id
    'trackIds': json.encode(tracks), // 歌曲id
    'imme': 'true'
  };

  return request(
    'POST',
    'https://music.163.com/api/playlist/manipulate/tracks',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 编辑歌单
Future<Answer> _playlistUpdate(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));
  params['desc'] = params['desc'] ?? '';
  params['tags'] = params['tags'] ?? '';
  final data = {
    '/api/playlist/desc/update': '{"id":${params['id']},"desc":"${params['desc']}"}',
    '/api/playlist/tags/update': '{"id":${params['id']},"tags":"${params['tags']}"}',
    '/api/playlist/update/name': '`{"id":${params['id']},"name":"${params['name']}"}',
  };

  return request(
    'POST',
    'https://music.163.com/weapi/batch',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

Future<Answer> _playlisVideoRecent(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/playlist/video/recent',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 公开隐私歌单
Future<Answer> _playlisPrivacy(Map params, List<Cookie> cookie) {
  final data = {
    'id': params['id'],
    'privacy': 0,
  };

  return request(
    'POST',
    'https://interface.music.163.com/eapi/playlist/update/privacy',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
