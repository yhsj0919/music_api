part of '../migu.dart';

/*
* 歌手标签
 */
Future<Answer> _singerTabs(Map params, List<Cookie> cookie) {
  var ans = const Answer(
    site: MusicSite.MiGu,
    code: 200,
    data: {
      "tip": "请求示例 huayu-nan ",
      "tab1": [
        {"title": "华语", "tab": "huayu"},
        {"title": "欧美", "tab": "oumei"},
        {"title": "日韩", "tab": "rihan"},
      ],
      "tab2": [
        {"title": "男", "tab": "nan"},
        {"title": "女", "tab": "nv"},
        {"title": "组合", "tab": "group"},
      ],
    },
  );

  return Future.value(ans);

  // return _get(
  //   "https://u.musicapp.migu.cn/MIGUM3.0/bmw/singer-index/tabs/v1.0",
  //   params: {},
  //   cookie: cookie,
  // );
}

/*
* 歌手
 */
Future<Answer> _singer(Map params, List<Cookie> cookie) {
  final data = {
    "tab": params['tab'],
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM3.0/bmw/singer-index/list/v1.0",
    params: data,
    cookie: cookie,
  );
}

/*
* 歌手信息
 */
Future<Answer> _singerInfo(Map params, List<Cookie> cookie) {
  final data = {
    "resourceId": params['id'],
    "resourceType": 2002,
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM2.0/v1.0/content/resourceinfo.do",
    params: data,
    cookie: cookie,
  );
}

/*
* 歌手单曲
 */
Future<Answer> _singerSongs(Map params, List<Cookie> cookie) {
  final data = {
    "pageNo": params['page'] ?? 1,
    "pageSize": params['size'] ?? 50,
    "singerId": params['id'],
    "songType": 0,
    "templateVersion": 3,
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/song-list/release",
    params: data,
    cookie: cookie,
  );
}

/*
* 歌手专辑
 */
Future<Answer> _singerAlbum(Map params, List<Cookie> cookie) {
  final data = {
    "singerId": params['id'],
    "pageNo": params['page'] ?? 1,
    "pageSize": params['size'] ?? 10,
    "templateVersion": 2,
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/singerAlbum/release",
    params: data,
    cookie: cookie,
  );
}

/*
* 歌手专辑
 */
Future<Answer> _singerMv(Map params, List<Cookie> cookie) {
  final data = {
    "singerId": params['id'],
    "pageNo": params['page'] ?? 1,
    "pageSize": params['size'] ?? 10,
    "templateVersion": 2,
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/singerMv/release",
    params: data,
    cookie: cookie,
  );
}
