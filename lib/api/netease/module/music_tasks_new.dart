part of '../netease.dart';

// 获取音乐人任务
Future<Answer> _musicTasksNew(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/nmusician/workbench/mission/stage/list',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
