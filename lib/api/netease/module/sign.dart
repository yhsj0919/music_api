part of '../netease.dart';

///乐签信息接口
Future<Answer> _signHappyInfo(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/sign/happy/info',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
