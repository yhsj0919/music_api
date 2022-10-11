part of '../netease.dart';

///签到进度
Future<Answer> _signInProgress(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/act/modules/signin/v2/progress',
    {"moduleId": params["moduleId"] ?? "1207signin-1207signin"},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
