part of '../netease.dart';

// 批量请求接口
Future<Answer> _batch(Map params, List<Cookie> cookie) {
  final data = {"e_r": true};
  params.forEach((key, value) {
    if (RegExp(r"^\/api\/").hasMatch(key)) {
      data[key] = params[key];
    }
  });
  return eApiRequest(
    url: 'http://music.163.com/eapi/batch',
    optionUrl: '/api/batch',
    data: data,
    cookies: cookie,
  );
}
