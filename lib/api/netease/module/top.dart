part of '../netease.dart';

// 新碟上架
Future<Answer> _topAlbum(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/discovery/new/albums/area',
    {
      'area': params['type'] ?? 'ALL', //ALL:全部,ZH:华语,EA:欧美,KR:韩国,JP:日本
      'limit': params['limit'] ?? 50,
      'offset': params['offset'] ?? 0,
      'type': params['type'] ?? 'new',
      'year': params['year'] ?? DateTime.now().year,
      'month': params['month'] ?? DateTime.now().month + 1,
      'total': false,
      'rcmd': true,
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 热门歌手
Future<Answer> _topArtists(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/artist/top',
    {'limit': params['limit'] ?? 50, 'offset': params['offset'] ?? 0, 'total': true},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 排行榜
Future<Answer> _topList(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));

  if (params.containsKey('idx')) {
    return Future.value(
      Answer().copy(
        data: {
          'code': 500,
          'msg': '不支持此方式调用,只支持id调用',
        },
      ),
    );
  }

  return request(
    'POST',
    'https://interface3.music.163.com/api/playlist/v4/detail',
    {
      'id': params['id'],
      'n': 500,
      's': 0,
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// MV排行榜
Future<Answer> _topMv(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/mv/toplist',
    {'area': params['area'] ?? '', 'limit': params['limit'] ?? 30, 'offset': params['offset'] ?? 0, 'total': true},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 精品歌单
Future<Answer> _topPlaylistHighquality(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/playlist/highquality/list',
    {
      // 全部,华语,欧美,韩语,日语,粤语,小语种,运动,ACG,影视原声,流行,摇滚,后摇,古风,民谣,轻音乐,电子,器乐,说唱,古典,爵士
      'cat': params['cat'] ?? '全部',
      'limit': params['limit'] ?? 50,
      'lasttime': params['before'] ?? 0, // 歌单updateTime
      'total': true
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 分类歌单
Future<Answer> _topPlaylist(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/playlist/list',
    {
      // 全部,华语,欧美,日语,韩语,粤语,小语种,流行,摇滚,民谣,电子,舞曲,说唱,轻音乐,爵士,乡村,R&B/Soul,古典,民族,英伦,金属,朋克,蓝调,雷鬼,世界音乐,拉丁,另类/独立,New Age,古风,后摇,Bossa Nova,清晨,夜晚,学习,工作,午休,下午茶,地铁,驾车,运动,旅行,散步,酒吧,怀旧,清新,浪漫,性感,伤感,治愈,放松,孤独,感动,兴奋,快乐,安静,思念,影视原声,ACG,儿童,校园,游戏,70后,80后,90后,网络歌曲,KTV,经典,翻唱,吉他,钢琴,器乐,榜单,00后
      'cat': params['cat'] ?? '全部',
      'order': params['order'] ?? 'hot',
      // hot,new
      'limit': params['limit'] ?? 50,
      'offset': params['offset'] ?? 0,
      'total': true
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 新歌速递
Future<Answer> _topSong(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/v1/discovery/new/songs',
    {
      'areaId': params['type'] ?? 0, // 全部:0 华语:7 欧美:96 日本:8 韩国:16
      'total': true
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 热门话题/专栏
Future<Answer> _topicDetailEventHot(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/act/event/hot',
    {
      'actid': params['actid'],
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 话题/专栏详情
Future<Answer> _topicDetail(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/act/detail',
    {
      'actid': params['actid'],
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 收藏的专栏
Future<Answer> _topicSubList(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/topic/sublist',
    {'limit': params['limit'] ?? 50, 'offset': params['offset'] ?? 0, 'total': true},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 歌手榜
Future<Answer> _toplistArtist(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/toplist/artist',
    {
      'type': 1,
      'limit': 100,
      'offset': 0,
      'total': true,
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 所有榜单内容摘要
Future<Answer> _toplistDetail(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/toplist/detail',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 所有榜单介绍
Future<Answer> _toplist(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/toplist',
    {},
    crypto: Crypto.linuxApi,
    cookies: cookie,
  );
}
