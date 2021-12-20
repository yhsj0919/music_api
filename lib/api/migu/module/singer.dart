part of '../migu.dart';

/*
* 歌手
 */
Future<Answer> singer(Map params, List<Cookie> cookie) {
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
* 歌手标签
 */
Future<Answer> singerTabs(Map params, List<Cookie> cookie) {
  return _get(

    "https://app.c.nf.migu.cn/MIGUM3.0/bmw/singer-index/tabs/v1.0",
    params: {},
    cookie: cookie,
  );
}

/*
* 歌手单曲
 */
Future<Answer> singerSongs(Map params, List<Cookie> cookie) {
  final data = {
    "pageNo": params['page'] ?? 1,
    "pageSize": params['size'] ?? 50,
    "singerId": params['singerId'],
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
* 歌手单曲
 */
Future<Answer> singerInfo(Map params, List<Cookie> cookie) {
  final data = {
    "resourceId": params['singerId'],
    "resourceType": 2002,
  };
  return _get(

    "https://app.c.nf.migu.cn/MIGUM2.0/v1.0/content/resourceinfo.do",
    params: data,
    cookie: cookie,
  );
}

/*
* 歌手专辑
 */
Future<Answer> singerAlbum(Map params, List<Cookie> cookie) {
  final data = {
    "singerId": params['singerId'],
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
Future<Answer> singerMv(Map params, List<Cookie> cookie) {
  final data = {
    "singerId": params['singerId'],
    "templateVersion": 2,
  };
  return _get(

    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/singerMv/release",
    params: data,
    cookie: cookie,
  );
}
