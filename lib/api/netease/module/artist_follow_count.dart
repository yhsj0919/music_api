part of '../netease.dart';

// 歌手粉丝数量
Future<Answer> _artistFollowCount(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/artist/follow/count/get',
    {"id": params["id"]},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
