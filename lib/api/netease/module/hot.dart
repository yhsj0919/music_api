part of '../netease.dart';

//热门话题
Future<Answer> _hotTopic(Map params, List<Cookie> cookie) {
  final data = {
    'limit': params['limit'] ?? 20,
    'offset': params['offset'] ?? 0,
  };
  return request(
    'POST',
    'http://music.163.com/weapi/act/hot',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
