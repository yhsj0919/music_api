part of '../netease.dart';

// 账户
Future<Answer> _userAccount(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/nuser/account/get',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 用户创建的电台
Future<Answer> _userAudio(Map params, List<Cookie> cookie) {
  final data = {
    'userId': params['uid'],
  };

  return request(
    'POST',
    'https://music.163.com/weapi/djradio/get/byuser',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
// 用户绑定手机
Future<Answer> _userBindingCellphone(Map params, List<Cookie> cookie) {
  final data = {
    'phone': params['phone'],
    'countrycode': params['countrycode'] ?? '86',
    'captcha': params['captcha'],
    'password': Encrypted(Uint8List.fromList(md5.convert(utf8.encode(params['password'])).bytes)).base16,
  };

  return request(
    'POST',
    'https://music.163.com/api/user/bindingCellphone',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 用户绑定
Future<Answer> _userBinding(Map params, List<Cookie> cookie) {
  final data = {
    'userId': params['uid'],
  };

  return request(
    'POST',
    'https://music.163.com/api/v1/user/bindings/${params["uid"]}',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 云盘歌曲删除
Future<Answer> _userCloudDel(Map params, List<Cookie> cookie) {
  final data = {
    'songIds': [params['id']],
  };

  return request(
    'POST',
    'https://music.163.com/weapi/cloud/del',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
// 云盘数据详情
Future<Answer> _userCloudDetail(Map params, List<Cookie> cookie) {
  final id = params['id'].toString().replaceAll(' ', "").split(",");

  final data = {
    'songIds': id,
  };

  return request(
    'POST',
    'https://music.163.com/weapi/v1/cloud/get/byids',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 云盘数据详情
Future<Answer> _userCloud(Map params, List<Cookie> cookie) {
  final data = {
    'limit': params['limit'] ?? 30,
    'offset': params['offset'] ?? 0,
  };

  return request(
    'POST',
    'https://music.163.com/api/v1/cloud/get',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
// 用户详情
Future<Answer> _userDetail(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    '`https://music.163.com/weapi/v1/user/detail/${params["uid"]}',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 用户电台节目
Future<Answer> _userDj(Map params, List<Cookie> cookie) {
  final data = {
    'limit': params['limit'] ?? 30,
    'offset': params['offset'] ?? 0,
  };

  return request(
    'POST',
    'https://music.163.com/weapi/dj/program/${params["uid"]}',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 用户动态
Future<Answer> _userEvent(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'ios'));
  cookie.add(Cookie('appver', '8.1.20'));

  return request(
    'POST',
    'https://music.163.com/api/event/get/${params['uid']}',
    {'getcounts': true, 'limit': params['limit'] ?? 30, 'time': params['lasttime'] ?? -1, 'total': false},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 关注与取消关注用户
Future<Answer> _userFollow(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));
  params['t'] = (params['t'] == 1 ? 'follow' : 'delfollow');
  return request(
    'POST',
    'https://music.163.com/weapi/user/${params['t']}/${params['id']}',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 关注TA的人(粉丝)
Future<Answer> _userFolloweds(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/eapi/user/getfolloweds/${params["uid"]}',
    {
      'userId': params['uid'],
      'time': '0',
      'limit': params['limit'] ?? 30,
      'offset': params['offset '] ?? 0,
      'getcounts': 'true',
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// TA关注的人(关注)
Future<Answer> _userFollows(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/user/getfollows/${params["uid"]}',
    {'limit': params['limit'] ?? 30, 'offset': params['offset'] ?? 0, 'order': true},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 类别热门电台
Future<Answer> _userLevel(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/user/level',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 用户歌单
Future<Answer> _userPlaylist(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/user/playlist',
    {
      'uid': params['uid'],
      'limit': params['limit'] ?? 30,
      'offset': params['offset'] ?? 0,
      'includeVideo': true,
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 听歌排行
Future<Answer> _userRecord(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/v1/play/record',
    {
      'uid': params['uid'],
      'type': params['type'] ?? 1 // 1: 最近一周, 0: 所有时间
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 更换手机
Future<Answer> _userReplaceCellphone(Map params, List<Cookie> cookie) {
  final data = {
    'phone': params['phone'],
    'captcha': params['captcha'],
    'oldcaptcha': params['oldcaptcha'],
    'ctcode': params['ctcode'] ?? '86',
  };

  return request(
    'POST',
    'https://music.163.com/api/user/replaceCellphone',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 收藏计数
Future<Answer> _userSubcount(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/subcount',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 编辑用户信息
Future<Answer> _userUpdate(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/user/profile/update',
    {
      'avatarImgId': "0",
      'birthday': params['birthday'],
      'city': params['city'],
      'gender': params['gender'],
      'nickname': params['nickname'],
      'province': params['province'],
      'signature': params['signature']
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 用户评论历史
Future<Answer> _userCommentHistory(Map params, List<Cookie> cookie) {
  cookie.add(Cookie("os", "ios"));
  cookie.add(Cookie("appver", "8.1.20"));
  return request(
    'POST',
    'https://music.163.com/api/comment/user/comment/history',
    {
      'compose_reminder': "true",
      'compose_hot_comment': "true",
      'limit': params['limit'] ?? 10,
      'user_id': params['uid'],
      'time': params['time'] ?? 0,
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
