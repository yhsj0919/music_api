part of '../netease.dart';

// 视频点赞转发评论数数据
Future<Answer> _videoDetailInfo(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/comment/commentthread/info',
    {
      'threadid': "R_VI_62_${params['vid']}",
      'composeliked': true,
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 视频详情
Future<Answer> _videoDetail(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/cloudvideo/v1/video/detail',
    {
      'id': params['id'],
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 视频标签列表
Future<Answer> _videoGroupList(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/cloudvideo/group/list',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 视频标签/分类下的视频
Future<Answer> _videoGroup(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/videotimeline/videogroup/otherclient/get',
    {
      'groupId': params['id'],
      'offset': params['offset'] ?? 0,
      'need_preview_url': 'true',
      'total': true,
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 收藏与取消收藏视频
Future<Answer> _videoSub(Map params, List<Cookie> cookie) {
  params['t'] = (params['t'] == 1 ? 'sub' : 'unsub');
  return request(
    'POST',
    'https://music.163.com/weapi/cloudvideo/video/${params["t"]}',
    {
      'id': params['id'],
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 全部视频列表
Future<Answer> _videoTimelineAll(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/videotimeline/otherclient/get',
    {
      'groupId': 0,
      'offset': params['offset'] ?? 0,
      'need_preview_url': 'true',
      'total': true,
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 推荐视频
Future<Answer> _videoTimelineRecommend(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/videotimeline/get',
    {
      'offset': params['offset'] ?? 0,
      'filterLives': '[]',
      'withProgramInfo': 'true',
      'needUrl': '1',
      'resolution': 480,
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 视频链接
Future<Answer> _videoUrl(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/cloudvideo/playurl',
    {
      'ids': '["' + params['id'] + '"]',
      'resolution': params['res'] ?? 1080,
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
