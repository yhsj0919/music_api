part of '../netease.dart';

//专辑评论
Future<Answer> _commentAlbum(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));

  final data = {
    'rid': params['id'],
    'limit': params['limit'] ?? 20,
    'offset': params['offset'] ?? 0,
    'beforeTime': params['before'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/v1/resource/comments/R_AL_3_${params["id"]}',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

//电台评论
Future<Answer> _commentDj(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));
  final data = {
    'rid': params['id'],
    'limit': params['limit'] ?? 20,
    'offset': params['offset'] ?? 0,
    'beforeTime': params['before'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/v1/resource/comments/A_DJ_1_${params["id"]}',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 获取动态评论
Future<Answer> _commentEvents(Map params, List<Cookie> cookie) {
  final data = {
    'limit': params['limit'] ?? 20,
    'offset': params['offset'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/v1/resource/comments/${params["threadId"]}',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

//楼层评论
Future<Answer> _commentFloor(Map params, List<Cookie> cookie) {
  final data = {
    'parentCommentId': params['parentCommentId'],
    'threadId': params['type'] + params['id'],
    'time': params['time'] ?? -1,
    'limit': params['limit'] ?? 20,
  };
  return request(
    'POST',
    'https://music.163.com/api/resource/comment/floor/get',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 热门评论
Future<Answer> _commentHot(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));

  params['type'] = const {
    0: 'R_SO_4_', //  歌曲
    1: 'R_MV_5_', //  MV
    2: 'A_PL_0_', //  歌单
    3: 'R_AL_3_', //  专辑
    4: 'A_DJ_1_', //  电台,
    5: 'R_VI_62_', //  视频
    6: 'R_EV_2_', //  动态
  }[params['type']];

  final data = {
    'rid': params['id'],
    'limit': params['limit'] ?? 20,
    'offset': params['offset'] ?? 0,
    'beforeTime': params['before'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/v1/resource/hotcomments/${params["type"]}${params["id"]}',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

//评论抱一抱列表
Future<Answer> _commentHugList(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'ios'));
  cookie.add(Cookie('appver', '8.1.20'));

  params['type'] = const {
    0: 'R_SO_4_', //  歌曲
    1: 'R_MV_5_', //  MV
    2: 'A_PL_0_', //  歌单
    3: 'R_AL_3_', //  专辑
    4: 'A_DJ_1_', //  电台,
    5: 'R_VI_62_', //  视频
    6: 'R_EV_2_', //  动态
  }[params['type']];

  final data = {
    'targetUserId': params['uid'],
    'commentId': params['cid'],
    'cursor': params['cursor'] ?? '-1',
    'threadId': params['type'] + params['id'],
    'pageNo': params['page'] ?? 1,
    'idCursor': params['idCursor'] ?? -1,
    'pageSize': params['pageSize'] ?? 100,
  };

  return request(
    'POST',
    'https://music.163.com/api/v2/resource/comments/hug/list',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

Future<Answer> _commentHugListener(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'ios'));
  cookie.add(Cookie('appver', '8.0.00'));

  params['type'] = const {
    0: 'R_SO_4_', //  歌曲
    1: 'R_MV_5_', //  MV
    2: 'A_PL_0_', //  歌单
    3: 'R_AL_3_', //  专辑
    4: 'A_DJ_1_', //  电台,
    5: 'R_VI_62_', //  视频
    6: 'R_EV_2_', //  动态
  }[params['type']];

  final data = {
    'targetUserId': params['uid'],
    'commentId': params['cid'],
    'threadId': params['type'] + params['id'],
  };

  return request(
    'POST',
    'https://music.163.com/api/v2/resource/comments/hug/listener',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 点赞与取消点赞评论
Future<Answer> _commentLike(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));

  final t = params['t'] == 1 ? 'like' : 'unlike';

  params['type'] = const {
    0: 'R_SO_4_', //  歌曲
    1: 'R_MV_5_', //  MV
    2: 'A_PL_0_', //  歌单
    3: 'R_AL_3_', //  专辑
    4: 'A_DJ_1_', //  电台,
    5: 'R_VI_62_', //  视频
    6: 'R_EV_2_', //  动态
  }[params['type']];

  final data = {'threadId': params['type'] + params['id'], 'commentId': params['cid']};
  if (params['type'] == 'A_EV_2_') {
    data['threadId'] = params['threadId'];
  }
  return request(
    'POST',
    'https://music.163.com/weapi/v1/comment/$t',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

//歌曲评论
Future<Answer> _commentMusic(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));

  final data = {
    'rid': params['id'],
    'limit': params['limit'] ?? 20,
    'offset': params['offset'] ?? 0,
    'beforeTime': params['before'] ?? 0,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/v1/resource/comments/R_SO_4_${params["id"]}',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

//mv评论
Future<Answer> _commentMv(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));

  final data = {
    'rid': params['id'],
    'limit': params['limit'] ?? 20,
    'offset': params['offset'] ?? 0,
    'beforeTime': params['before'] ?? 0,
  };
  return request('POST', 'https://music.163.com/weapi/v1/resource/comments/R_MV_5_${params["id"]}', data, crypto: Crypto.weApi, cookies: cookie);
}

//歌单评论
Future<Answer> _commentPlaylist(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));
  final data = {
    'rid': params['id'],
    'limit': params['limit'] ?? 20,
    'offset': params['offset'] ?? 0,
    'beforeTime': params['before'] ?? 0,
  };
  return request('POST', 'https://music.163.com/weapi/v1/resource/comments/A_PL_0_${params["id"]}', data, crypto: Crypto.weApi, cookies: cookie);
}

//视频评论
Future<Answer> _commentVideo(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));
  final data = {
    'rid': params['id'],
    'limit': params['limit'] ?? 20,
    'offset': params['offset'] ?? 0,
    'beforeTime': params['before'] ?? 0,
  };
  return request('POST', 'https://music.163.com/weapi/v1/resource/comments/R_VI_62_${params["id"]}', data, crypto: Crypto.weApi, cookies: cookie);
}

//评论
Future<Answer> _commentNew(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));
  params['t'] = (params['t'] == 1 ? 'add' : 'delete');
  params['type'] = const {
    0: 'R_SO_4_', //  歌曲
    1: 'R_MV_5_', //  MV
    2: 'A_PL_0_', //  歌单
    3: 'R_AL_3_', //  专辑
    4: 'A_DJ_1_', //  电台,
    5: 'R_VI_62_', //  视频
    6: 'A_EV_2_' //  动态
  }[params['type']];

  final pageNo = params['pageNo'] ?? 1;
  final pageSize = params['pageSize'] ?? 20;
  var sortType = params['sortType'] ?? 99;
  if (sortType == 1) {
    sortType = 99;
  }
  var cursor = '';
  switch (sortType) {
    case 99:
      cursor = (pageNo - 1) * pageSize;
      break;
    case 2:
      cursor = 'normalHot#' + (pageNo - 1) * pageSize;
      break;
    case 3:
      cursor = params["cursor"] ?? '0';
      break;
    default:
      break;
  }
  final data = {
    'threadId': params['type'] + params['id'],
    'pageNo': pageNo,
    'pageSize': pageSize,
    'showInner': params['showInner'] ?? true,
    'cursor': cursor,
    'sortType': params['sortType'] ?? 1 //99:按推荐排序,2:按热度排序,3:按时间排序
  };

  return eApiRequest(
    url: 'https://music.163.com/api/v2/resource/comments',
    optionUrl: '/api/v2/resource/comments',
    data: data,
    cookies: cookie,
  );
}

//发送与删除评论
Future<Answer> _comment(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'android'));
  params['t'] = const {
    0: 'delete',
    1: 'add',
    2: 'reply',
  }[params['t'] ?? 1];
  params['type'] = const {
    0: 'R_SO_4_', //  歌曲
    1: 'R_MV_5_', //  MV
    2: 'A_PL_0_', //  歌单
    3: 'R_AL_3_', //  专辑
    4: 'A_DJ_1_', //  电台,
    5: 'R_VI_62_', //  视频
    6: 'A_EV_2_' //  动态
  }[params['type']];

  final data = {
    'threadId': params['type'] + params['id'],
  };
  if (params['type'] == 'A_EV_2_') {
    data['threadId'] = params['threadId'];
  }

  if (params['t'] == 'add') {
    data['content'] = params['content'];
  } else if (params['t'] == 'delete') {
    data['commentId'] = params['commentId'];
  } else if (params['t'] == 'reply') {
    data['commentId'] = params['commentId'];
    data['content'] = params['content'];
  }
  return request(
    'POST',
    'https://music.163.com/weapi/resource/comments/${params["t"]}',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
