part of '../netease.dart';

// 账号云豆数
Future<Answer> _musicianCloudBean (Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/cloudbean/get',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
// 领取云豆
Future<Answer> _musicianCloudBeanObtain (Map params, List<Cookie> cookie) {
  final data = {
    'userMissionId': params['id'],
    'period': params['period'],
  };
  return request(
    'POST',
    'https://music.163.com/weapi/nmusician/workbench/mission/reward/obtain/new',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
// 音乐人数据概况
Future<Answer> _musicianDataOverview (Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/creator/musician/statistic/data/overview/get',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
// 音乐人歌曲播放趋势
Future<Answer> _musicianPlayTrend (Map params, List<Cookie> cookie) {
  final data = {
    'startTime': params['startTime'],
    'endTime': params['endTime'],
  };
  return request(
    'POST',
    'https://music.163.com/weapi/creator/musician/play/count/statistic/data/trend/get',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 音乐人歌曲播放趋势
Future<Answer> _musicianTask (Map params, List<Cookie> cookie) {

  return request(
    'POST',
    'https://music.163.com/weapi/nmusician/workbench/mission/cycle/list',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
// 音乐人签到
Future<Answer> _musicianSign (Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/creator/user/access',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
