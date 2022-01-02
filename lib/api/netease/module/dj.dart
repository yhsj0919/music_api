part of '../netease.dart';

//电台banner
Future<Answer> _djBanner(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'http://music.163.com/weapi/djradio/banner/get',
    const {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 电台非热门类型
Future<Answer> _djCategoryExcludehot(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'http://music.163.com/weapi/djradio/category/excludehot',
    const {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 电台推荐类型
Future<Answer> _djCategoryRecommend(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'http://music.163.com/weapi/djradio/category/recommend',
    const {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

//电台分类列表
Future<Answer> _djCatelist(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'http://music.163.com/weapi/djradio/category/get',
    const {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

//电台详情
Future<Answer> _djDetail(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/djradio/v2/get',
    {'id': params['rid']},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

//热门电台
Future<Answer> _djHot(Map params, List<Cookie> cookie) {
  final data = {
    'limit': params['limit'] ?? 30,
    'offset': params['offset'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/djradio/hot/v1',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 付费电台
Future<Answer> _djPaygift(Map params, List<Cookie> cookie) {
  final data = {'limit': params['limit'] ?? 30, 'offset': params['offset'] ?? 0};
  return request(
    'POST',
    'https://music.163.com/weapi/djradio/home/paygift/list?_nmclfl=1',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 电台个性推荐
Future<Answer> _djPersonalizeRcmd(Map params, List<Cookie> cookie) {
  final data = {
    'limit': params['limit'] ?? 6,
  };
  return request(
    'POST',
    'https://music.163.com/api/djradio/personalize/rcmd',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 电台节目详情
Future<Answer> _djProgramDetail(Map params, List<Cookie> cookie) {
  final data = {'id': params['id']};
  return request(
    'POST',
    'https://music.163.com/weapi/dj/program/detail',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 电台24小时节目榜
Future<Answer> _djProgramToplistHours(Map params, List<Cookie> cookie) {
  final data = {
    'limit': params['limit'] ?? 100,
    // 不支持 offset
  };
  return request(
    'POST',
    'https://music.163.com/api/djprogram/toplist/hours',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 电台节目榜
Future<Answer> _djProgramToplist(Map params, List<Cookie> cookie) {
  final data = {
    'limit': params['limit'] ?? 100,
    'offset': params['offset'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/api/program/toplist/v1',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 电台节目列表
Future<Answer> _djProgram(Map params, List<Cookie> cookie) {
  final data = {'radioId': params['rid'], 'limit': params['limit'] ?? 30, 'offset': params['offset'] ?? 0, 'asc': toBoolean(params['asc'])};
  return request(
    'POST',
    'https://music.163.com/weapi/dj/program/byradio',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 类别热门电台
Future<Answer> _djRadioHot(Map params, List<Cookie> cookie) {
  final data = {
    'cateId': params['cateId'],
    'limit': params['limit'] ?? 30,
    'offset': params['offset'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/api/djradio/hot',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 精选电台分类

/*
    有声书 10001
    知识技能 453050
    商业财经 453051
    人文历史 11
    外语世界 13
    亲子宝贝 14
    创作|翻唱 2001
    音乐故事 2
    3D|电子 10002
    相声曲艺 8
    情感调频 3
    美文读物 6
    脱口秀 5
    广播剧 7
    二次元 3001
    明星做主播 1
    娱乐|影视 4
    科技科学 453052
    校园|教育 4001
    旅途|城市 12
*/
Future<Answer> _djRecommendType(Map params, List<Cookie> cookie) {
  final data = {'cateId': params['type']};
  return request(
    'POST',
    'https://music.163.com/weapi/djradio/recommend',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 精选电台
Future<Answer> _djRecommend(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/djradio/recommend/v1',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 订阅与取消电台
Future<Answer> _djSub(Map params, List<Cookie> cookie) {
  params['t'] = (params['t'] == 1 ? 'sub' : 'unsub');
  return request(
    'POST',
    'https://music.163.com/weapi/djradio/${params["t"]}',
    {'id': params['rid']},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 订阅电台列表
Future<Answer> _djSublist(Map params, List<Cookie> cookie) {
  final data = {'limit': params['limit'] ?? 30, 'offset': params['offset'] ?? 0, 'total': true};
  return request(
    'POST',
    'https://music.163.com/weapi/djradio/get/subed',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 电台订阅者列表
Future<Answer> _djSubscriber(Map params, List<Cookie> cookie) {
  final data = {'time': params['time'] ?? '-1', 'id': params['id'], 'limit': params['limit'] ?? 20, 'total': true};
  return request(
    'POST',
    'https://music.163.com/api/djradio/subscriber',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 电台今日优选
Future<Answer> _djTodayPerfered(Map params, List<Cookie> cookie) {
  final data = {'page': params['page'] ?? 0};
  return request(
    'POST',
    'https://music.163.com/weapi/djradio/home/today/perfered',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 电台24小时主播榜
Future<Answer> _djToplistHours(Map params, List<Cookie> cookie) {
  final data = {
    'limit': params['limit'] ?? 100,
    // 不支持 offset
  };
  return request(
    'POST',
    'https://music.163.com/api/dj/toplist/hours',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 电台新人榜
Future<Answer> _djToplistNewcomer(Map params, List<Cookie> cookie) {
  final data = {
    'limit': params['limit'] ?? 100,
    'offset': params['offset'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/api/dj/toplist/newcomer',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 付费精品
Future<Answer> _djToplistPay(Map params, List<Cookie> cookie) {
  final data = {
    'limit': params['limit'] ?? 100,
    // 'offset': params['offset'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/api/djradio/toplist/pay',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 电台最热主播榜
Future<Answer> _djToplistPopular(Map params, List<Cookie> cookie) {
  final data = {
    'limit': params['limit'] ?? 100,
    // 'offset': params['offset'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/api/dj/toplist/popular',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 新晋电台榜/热门电台榜
Future<Answer> _djToplist(Map params, List<Cookie> cookie) {
  //0为新晋,1为热门
  final type = const {"new": 0, "hot": 1}[params['type'] ?? "new"];

  final data = {
    'limit': params['limit'] ?? 100,
    'offset': params['offset'] ?? 0,
    'type': type,
  };
  return request(
    'POST',
    'https://music.163.com/api/djradio/toplist',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
