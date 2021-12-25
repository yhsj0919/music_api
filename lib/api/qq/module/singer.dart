part of '../qq.dart';

/*
 * 歌手列表
 */
Future<Answer> singerList(Map params, List<Cookie> cookie) {
  final page = params['page'] ?? 1;
  final sin = (page - 1) * 80;

  final data = {
    "data": json.encode({
      "comm": {"ct": 24, "cv": 10000},
      "singerList": {
        "module": "Music.SingerListServer",
        "method": "get_singer_list",
        "param": {
          "area": params['area'] ?? -100,
          "sex": params['sex'] ?? -100,
          "genre": params['genre'] ?? -100,
          "index": params['index'] ?? -100,
          "sin": sin,
          "cur_page": page,
        }
      }
    })
  };
  return _get(
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    params: data,
    cookie: cookie,
  );
}

/*
* 歌手信息
*/
Future<Answer> singerInfo(Map params, List<Cookie> cookie) {
  final data = {
    'singermid': params['singerMid'],
    'utf8': 1,
    'outCharset': 'utf-8',
    'format': 'xml',
    'r': DateTime.now().millisecondsSinceEpoch,
  };
  return _get(
    "https://c.y.qq.com/splcloud/fcgi-bin/fcg_get_singer_desc.fcg",
    params: data,
    cookie: cookie,
    contentType: 'xml',
  );
}

/*
* 歌手热门音乐
*/
Future<Answer> singerSong(Map params, List<Cookie> cookie) {
  final data = {
    "data": json.encode({
      "comm": {"ct": 24, "cv": 0},
      "singerSongList": {
        "module": "musichall.song_list_server",
        "method": "GetSingerSongList",
        "param": {"order": 1, "singerMid": params["singerMid"], "begin": (params['page'] - 1) * 20, "num": 20}
      }
    })
  };
  return _get(
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    params: data,
    cookie: cookie,
  );
}

/*
* 歌手专辑
*/
Future<Answer> singerAlbum(Map params, List<Cookie> cookie) {
  final data = {
    "data": json.encode({
      "comm": {"ct": 24, "cv": 0},
      "singerSongList": {
        "method": "GetAlbumList",
        "module": "music.musichallAlbum.AlbumListServer",
        "param": {
          "singerMid": params["singerMid"],
          "order": 0,
          "begin": ((params['page'] ?? 1) - 1) * 20,
          "num": 20,
          "songNumTag": 0,
          "singerID": params['singerId'] ?? 0,
        }
      }
    })
  };
  return _get(
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    params: data,
    cookie: cookie,
  );
}

/*
* 歌手MV
*/
Future<Answer> singerMV(Map params, List<Cookie> cookie) {
  final data = {
    'format': 'json',
    'platform': 'yqq.json',
    'needNewCode': 0,
    'singermid': params['singerMid'],
    'outCharset': 'utf-8',
    'order': 'listen', //listen,time两种排序
    "begin": ((params['page'] ?? 1) - 1) * 20,
    "num": 20,
    "cid": '205360581',
    "cmd": 0, //0,官方mv，1粉丝上传
  };
  return _get(
    "https://c.y.qq.com/mv/fcgi-bin/fcg_singer_mv.fcg",
    params: data,
    cookie: cookie,
  );
}

/*
* 相似歌手
*/
Future<Answer> singerSimilarSinger(Map params, List<Cookie> cookie) {
  final data = {
    "data": json.encode({
      "comm": {"ct": 24, "cv": 10000},
      "similarSingerList": {
        "method": "GetSimilarSingerList",
        "module": "music.SimilarSingerSvr",
        "param": {
          "singerMid": params["singerMid"],
          "num": 5,
          "singerId": params['singerId'] ?? 0,
        }
      }
    })
  };
  return _get(
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    params: data,
    cookie: cookie,
  );
}
