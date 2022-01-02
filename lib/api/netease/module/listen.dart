part of '../netease.dart';

// 一起听状态
Future<Answer> _listenTogetherStatus(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    "https://music.163.com/api/listen/together/status/get",
    {},
    cookies: cookie,
    crypto: Crypto.weApi,
  );
}
