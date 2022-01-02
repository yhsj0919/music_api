part of '../netease.dart';

// 会员成长值
Future<Answer> _vipGrowthpoint (Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/vipnewcenter/app/level/growhpoint/basic',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
// 会员成长值领取记录
Future<Answer> _vipGrowthpointDetail (Map params, List<Cookie> cookie) {
  final data = {
    'limit': params['limit'] ?? 20,
    'offset': params['offset'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/vipnewcenter/app/level/growth/details',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 领取会员成长值
Future<Answer> _vipGrowthpointGet (Map params, List<Cookie> cookie) {
  final data = {
    'taskIds': params['ids'],
  };
  return request(
    'POST',
    'https://music.163.com/weapi/vipnewcenter/app/level/task/reward/get',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 会员任务
Future<Answer> _vipTasks (Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/vipnewcenter/app/level/task/list',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
// 获取 VIP 信息
Future<Answer> _vipInfo (Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/music-vip-membership/front/vip/info',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
