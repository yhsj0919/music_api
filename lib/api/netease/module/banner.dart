part of '../netease.dart';

Future<Answer> _banner(Map params, List<Cookie> cookie) {
  final type = const {
        0: 'pc',
        1: 'android',
        2: 'iphone',
        3: 'ipad'
      }[params['type'] ?? 0] ??
      'pc';
  return request(
    'POST',
    'https://music.163.com/api/v2/banner/get',
    {'clientType': type},
    crypto: Crypto.linuxApi,
    cookies: cookie,
  );
}
