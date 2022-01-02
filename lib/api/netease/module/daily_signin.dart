part of '../netease.dart';

/*
    0为安卓端签到 3点经验, 1为网页签到,2点经验
    签到成功 {'android': {'point': 3, 'code': 200}, 'web': {'point': 2, 'code': 200}}
    重复签到 {'android': {'code': -2, 'msg': '重复签到'}, 'web': {'code': -2, 'msg': '重复签到'}}
    未登录 {'android': {'code': 301}, 'web': {'code': 301}}
*/
Future<Answer> _dailySignin(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/point/dailyTask',
    {"type": params['type'] ?? 0},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
