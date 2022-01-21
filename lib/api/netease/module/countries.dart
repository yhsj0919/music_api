part of '../netease.dart';

// 国家编码列表
Future<Answer> _countriesCodeList(Map params, List<Cookie> cookie) {
  return eApiRequest(
    url: 'https://interface3.music.163.com/eapi/lbs/countries/v1',
    optionUrl: '/api/lbs/countries/v1',
    data: {},
    cookies: cookie,
  );
}
