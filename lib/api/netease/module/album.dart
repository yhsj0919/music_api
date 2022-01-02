part of '../netease.dart';

//专辑内容
Future<Answer> _album(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    "https://music.163.com/weapi/v1/album/${params['id']}",
    {},
    cookies: cookie,
    crypto: Crypto.weApi,
  );
}

// 专辑动态信息
Future<Answer> _albumDetailDynamic(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    "https://music.163.com/api/album/detail/dynamic",
    {'id': params['id']},
    cookies: cookie,
    crypto: Crypto.weApi,
  );
}

// 数字专辑详情
Future<Answer> _albumDetail(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    "https://music.163.com/weapi/vipmall/albumproduct/detail",
    {'id': params['id']},
    cookies: cookie,
    crypto: Crypto.weApi,
  );
}

//数字专辑-语种风格馆
//Z_H:华语,E_A:欧美,KR:韩国,JP:日本
Future<Answer> _albumStyle(Map params, List<Cookie> cookie) => request(
      'POST',
      'https://music.163.com/weapi/vipmall/appalbum/album/style',
      {'limit': params['limit'] ?? 10, 'offset': params['offset'] ?? 0, 'total': true, 'area': params['area'] ?? 'Z_H'},
      crypto: Crypto.weApi,
      cookies: cookie,
    );

//数字专辑-新碟上架
//ALL:全部,ZH:华语,EA:欧美,KR:韩国,JP:日本
Future<Answer> _albumList(Map params, List<Cookie> cookie) => request(
      'POST',
      'https://music.163.com/weapi/vipmall/albumproduct/list',
      {'limit': params['limit'] ?? 30, 'offset': params['offset'] ?? 0, 'total': true, 'area': params['area'] ?? 'ALL', 'type': params['type']},
      crypto: Crypto.weApi,
      cookies: cookie,
    );

// 全部新碟
//ALL:全部,ZH:华语,EA:欧美,KR:韩国,JP:日本
Future<Answer> _albumNew(Map params, List<Cookie> cookie) => request(
      'POST',
      'https://music.163.com/weapi/album/new',
      {
        'limit': params['limit'] ?? 30,
        'offset': params['offset'] ?? 0,
        'total': true,
        'area': params['area'] ?? 'ALL',
      },
      crypto: Crypto.weApi,
      cookies: cookie,
    );

// 最新专辑
Future<Answer> _albumNewest(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    "https://music.163.com/api/discovery/newAlbum",
    {},
    cookies: cookie,
    crypto: Crypto.weApi,
  );
}

// 数字专辑&数字单曲-榜单
Future<Answer> _albumSongSaleBoard(Map params, List<Cookie> cookie) {
  //0为数字专辑,1为数字单曲
  final data = {'albumType': params['albumType'] ?? 0};

  final type = params['type'] ?? 'daily'; // daily,week,year,total
  if (type == 'year') {
    data['year'] = params['year'];
  }

  return request(
    'POST',
    "https://music.163.com/api/feealbum/songsaleboard/$type/type",
    data,
    cookies: cookie,
    crypto: Crypto.weApi,
  );
}

// 收藏/取消收藏专辑
Future<Answer> _albumSub(Map params, List<Cookie> cookie) {
  final type = params['t'] == 1 ? 'sub' : 'unsub';

  return request(
    'POST',
    "https://music.163.com/api/album/$type",
    {'id': params['id']},
    cookies: cookie,
    crypto: Crypto.weApi,
  );
}

// 已收藏专辑列表
Future<Answer> _albumSublist(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    "https://music.163.com/weapi/album/sublist",
    {'limit': params['limit'] ?? 25, 'offset': params['offset'] ?? 0, 'total': true},
    cookies: cookie,
    crypto: Crypto.weApi,
  );
}

// 数字专辑销量
Future<Answer> _albumSales(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    "https://music.163.com/weapi/vipmall/albumproduct/album/query/sales",
    {
      'albumIds': params['ids'],
    },
    cookies: cookie,
    crypto: Crypto.weApi,
  );
}
