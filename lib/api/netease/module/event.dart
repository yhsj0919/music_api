part of '../netease.dart';

// 删除动态
Future<Answer> _eventDel(Map params, List<Cookie> cookie) {
  final data = {
    'id': params['evId'],
  };
  return request(
    'POST',
    'https://music.163.com/eapi/event/delete',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 转发动态
Future<Answer> _eventForward(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));
  final data = {
    'forwards': params['forwards'],
    'id': params['evId'],
    'eventUserId': params['uid']
  };
  return request(
    'POST',
    'https://music.163.com/weapi/event/forward',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 动态
Future<Answer> _event(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));
  final data = {
    "pagesize": params['pagesize'] ?? 20,
    "lasttime": params['lasttime'] ?? -1
  };
  return request(
    'POST',
    'https://music.163.com/weapi/v1/event/get',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
