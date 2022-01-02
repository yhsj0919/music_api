part of '../netease.dart';

// 全部MV
Future<Answer> _mvAll(Map params, List<Cookie> cookie) {
  final data = {
    'tags': json.encode({
      '地区': params['area'] ?? '全部',
      '类型': params['type'] ?? '全部',
      '排序': params['order'] ?? '上升最快',
    }),
    'offset': params['offset'] ?? 0,
    'limit': params['limit'] ?? 30,
    'total': 'true',
  };
  return request(
    'POST',
    'https://interface.music.163.com/api/mv/all',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// MV 点赞转发评论数数据
Future<Answer> _mvDetailInfo(Map params, List<Cookie> cookie) {
  final data = {
    'threadid': 'R_MV_5_${params['mvid']}',
    'composeliked': true,
  };
  return request(
    'POST',
    'https://music.163.com/api/comment/commentthread/info',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// MV详情
Future<Answer> _mvDetail(Map params, List<Cookie> cookie) {
  final data = {'id': params['mvid']};
  return request(
    'POST',
    'https://music.163.com/weapi/mv/detail',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 网易出品
Future<Answer> _mvExclusiveRcmd(Map params, List<Cookie> cookie) {
  final data = {
    'offset': params['offset'] ?? 0,
    'limit': params['limit'] ?? 30,
  };
  return request(
    'POST',
    'https://interface.music.163.com/api/mv/exclusive/rcmd',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 最新MV
Future<Answer> _mvFirst(Map params, List<Cookie> cookie) {
  final data = {
    'area': params['area'] ?? '',
    'limit': params['limit'] ?? 30,
    'total': true,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/mv/first',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 收藏与取消收藏MV
Future<Answer> _mvSub(Map params, List<Cookie> cookie) {
  params['t'] = (params['t'] == 1 ? 'sub' : 'unsub');
  final data = {
    'mvId': params['mvid'],
    'mvIds': '["' + params['mvid'] + '"]',
  };
  return request(
    'POST',
    'https://music.163.com/weapi/mv/${params['t']}',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 已收藏MV列表
Future<Answer> _mvSublist(Map params, List<Cookie> cookie) {
  final data = {
    'limit': params['limit'] ?? 30,
    'total': true,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/mv/first',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// MV链接
Future<Answer> _mvUrl(Map params, List<Cookie> cookie) {
  final data = {
    'id': params['id'],
    'r': params['r'] ?? 1080,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/song/enhance/play/mv/url',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
