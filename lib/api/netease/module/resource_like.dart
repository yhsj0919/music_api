part of '../netease.dart';

// 点赞与取消点赞资源
Future<Answer> _resourceLike(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));
  params['t'] = (params['t'] == 1 ? 'like' : 'unlike');
  params['type'] = const {
    1: 'R_MV_5_', //  MV
    4: 'A_DJ_1_', //  电台
    5: 'R_VI_62_', //  视频
    6: 'A_EV_2_'
  }[params['type']];

  final data = {'threadId': '${params['type']}${params['id']}'};
  if (params['type'] == 'A_EV_2_') {
    data['threadId'] = params['threadId'];
  }

  return request(
    'POST',
    'https://music.163.com/weapi/resource/${params["t"]}',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
