part of '../netease.dart';

// 垃圾桶
//说明 : 调用此接口 , 传入音乐 id, 可把该音乐从私人 FM 中移除至垃圾桶
Future<Answer> _fmTrash (Map params, List<Cookie> cookie) {
  final data = {
    'songId': params['id'],
  };
  return request(
    'POST',
    'https://music.163.com/weapi/radio/trash/add?alg=RT&songId=${params['id']}&time=${params['time'] ?? 25}',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
