part of '../netease.dart';

///重复昵称检测
Future<Answer> _nicknameCheck(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/nickname/duplicated',
    {"nickname": params["nickname"]},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
