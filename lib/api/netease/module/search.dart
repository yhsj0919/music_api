part of '../netease.dart';

// 默认搜索关键词
Future<Answer> _searchDefaultKeyword(Map params, List<Cookie> cookie) {
  return eApiRequest(
    url: 'https://interface3.music.163.com/eapi/search/defaultkeyword/get',
    optionUrl: '/api/search/defaultkeyword/get',
   data: {},
    cookies: cookie,
  );
}

// 热搜列表
Future<Answer> _searchHotDetail(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/hotsearchlist/get',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 热门搜索
Future<Answer> _searchHot(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/search/hot',
    {'type': 1111},
    crypto: Crypto.weApi,
    cookies: cookie,
    ua: 'mobile',
  );
}

// 多类型搜索
Future<Answer> _searchMultimatch(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/search/suggest/multimatch',
    {
      'type': params['type'] ?? 1,
      's': params['keywords'] ?? '',
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 搜索建议
Future<Answer> _searchSuggest(Map params, List<Cookie> cookie) {
  final type = params['type'] == 'mobile' ? 'keyword' : 'web';
  return request(
    'POST',
    'https://music.163.com/weapi/search/suggest/$type',
    {'s': params['keywords'] ?? ''},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

//搜索

Future<Answer> _search(Map params, List<Cookie> cookie) {
  final num = params['size'] ?? 20;
  final page = params['page'] ?? 1;
  final offset = (page - 1) * num;

  final data = {
    's': params['keyWord'],
    // 1: 单曲, 10: 专辑, 100: 歌手, 1000: 歌单, 1002: 用户, 1004: MV, 1006: 歌词, 1009: 电台, 1014: 视频
    'type': params['type'] ?? 1,
    'limit': num,
    'offset': offset
  };
  return request(
    'POST',
    'https://music.163.com/weapi/search/get',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

//搜索

Future<Answer> _cloudSearch(Map params, List<Cookie> cookie) {
  final data = {
    's': params['keywords'],
    // 1: 单曲, 10: 专辑, 100: 歌手, 1000: 歌单, 1002: 用户, 1004: MV, 1006: 歌词, 1009: 电台, 1014: 视频
    'type': params['type'] ?? 1,
    'limit': params['limit'] ?? 30,
    'offset': params['offset'] ?? 0
  };
  return request('POST', 'https://music.163.com/api/cloudsearch/pc', data, crypto: Crypto.weApi, cookies: cookie);
}
