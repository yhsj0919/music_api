part of '../netease.dart';

//云贝支出
Future<Answer> _yunbeiExpense(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/store/api/point/expense',
    {
      'limit': params['limit'] ?? 10,
      'offset': params['offset'] ?? 0,
    },
    crypto: Crypto.linuxApi,
    cookies: cookie,
  );
}
//云贝账户信息
Future<Answer> _yunbeiInfo(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/v1/user/info',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
//云贝收入
Future<Answer> _yunbeiReceipt(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/store/api/point/receipt',
    {
      'limit': params['limit'] ?? 10,
      'offset': params['offset'] ?? 0,
    },
    crypto: Crypto.linuxApi,
    cookies: cookie,
  );
}
//云贝签到
Future<Answer> _yunbeiSign(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/point/dailyTask',
    {
      'type': '0',
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
//云贝完成任务
Future<Answer> _yunbeiTaskFinish(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/usertool/task/point/receive',
    {
      'userTaskId': params['userTaskId'],
      'depositCode': params['depositCode'] ?? '0',
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

//云贝todo任务
Future<Answer> _yunbeiTaskTodo(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/usertool/task/todo/query',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
//云贝所有任务
Future<Answer> _yunbeiTask(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/usertool/task/list/all',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
//云贝今日签到信息
Future<Answer> _yunbeiToday(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/point/today/get',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
//云贝
Future<Answer> _yunbei(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/point/signed/get',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 云贝推歌
Future<Answer> _yunbeiRcmdSong(Map params, List<Cookie> cookie) {
  final data = {
    'songId': params['id'],
    'reason': params['reason'] ?? '好歌献给你',
    'scene': '',
    'fromUserId': -1,
  };

  return request(
    'POST',
    'https://music.163.com/weapi/yunbei/rcmd/song/submit',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 云贝推歌历史记录
Future<Answer> _yunbeiRcmdSongHistory(Map params, List<Cookie> cookie) {
  final data = {
    'page': json.encode({
      'size': params['size'] ?? 20,
      'cursor': params['cursor'] ?? '',
    })
  };

  return request(
    'POST',
    'https://music.163.com/weapi/yunbei/rcmd/song/history/list',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
