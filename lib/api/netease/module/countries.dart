part of '../netease.dart';

// 国家编码列表
Future<Answer> _countriesCodeList(Map params, List<Cookie> cookie) {
  return eApiRequest(
    'https://interface3.music.163.com/eapi/lbs/countries/v1',
    '/api/lbs/countries/v1',
    {},
    cookies: cookie,
  );
}
