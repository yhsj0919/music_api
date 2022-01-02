part of '../netease.dart';

// 评论
Future<Answer> _msgComment(Map params, List<Cookie> cookie) {
  final data = {
    'beforeTime': params['beforeTime'] ?? "-1",
    'limit': params['limit'] ?? 30,
    'total': "true",
    'uid': params['uid']
  };
  return request(
    'POST',
    'https://music.163.com/api/v1/user/comments/${params["uid"]}',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// @我
Future<Answer> _msgForwards(Map params, List<Cookie> cookie) {
  final data = {
    'offset': params['offset'] ?? 0,
    'limit': params['limit'] ?? 30,
    'total': "true"
  };
  return request(
    'POST',
    'https://music.163.com/api/forwards/get',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 通知
Future<Answer> _msgNotice(Map params, List<Cookie> cookie) {
  final data = {
    'offset': params['offset'] ?? 0,
    'limit': params['limit'] ?? 30,
    'total': "true"
  };
  return request(
    'POST',
    'https://music.163.com/api/msg/notices',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 私信内容
Future<Answer> _msgPrivateHistory(Map params, List<Cookie> cookie) {
  final data = {
    'userId': params['uid'],
    'offset': params['offset'] ?? 0,
    'limit': params['limit'] ?? 30,
    'total': "true"
  };
  return request(
    'POST',
    'https://music.163.com/api/msg/private/history',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 私信
Future<Answer> _msgPrivate(Map params, List<Cookie> cookie) {
  final data = {
    'offset': params['offset'] ?? 0,
    'limit': params['limit'] ?? 30,
    'total': "true"
  };
  return request(
    'POST',
    'https://music.163.com/api/msg/private/users',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
// 最近联系
Future<Answer> _msgRecentcontact(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/msg/recentcontact/get',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
