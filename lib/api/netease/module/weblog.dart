part of '../netease.dart';

// 操作记录
Future<Answer> _weblog(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/feedback/weblog',
    params['data'] ?? {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
