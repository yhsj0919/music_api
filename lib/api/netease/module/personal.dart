part of '../netease.dart';

// 私人FM
Future<Answer> _personalFm(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/v1/radio/get',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 推荐电台
Future<Answer> _personalizedDjprogram(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/personalized/djprogram',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 推荐电台
Future<Answer> _personalizedMv(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/personalized/mv',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 推荐新歌
Future<Answer> _personalizedNewsong(Map params, List<Cookie> cookie) {
  cookie.add(Cookie("os", "pc"));
  final data = {
    'type': 'recommend',
    'limit': params['limit'] ?? 10,
    'areaId': params['areaId'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/api/personalized/newsong',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 独家放送列表
Future<Answer> _personalizedPrivatecontentList(Map params, List<Cookie> cookie) {
  final data = {
    'offset': params['offset'] ?? 0,
    'limit': params['limit'] ?? 60,
    'total': 'true',
  };
  return request(
    'POST',
    'https://music.163.com/api/v2/privatecontent/list',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 独家放送
Future<Answer> _personalizedPrivatecontent(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/personalized/privatecontent',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 推荐歌单
Future<Answer> _personalized(Map params, List<Cookie> cookie) {
  final data = {
    // 'offset': params['offset'] ?? 0,
    'limit': params['limit'] ?? 30,
    'total': true,
    'n': '1000',
  };

  return request(
    'POST',
    'https://music.163.com/weapi/personalized/playlist',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
