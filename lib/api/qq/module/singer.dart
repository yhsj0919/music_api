part of '../qq.dart';

/*
 * 歌手列表
 */
Future<Answer> _singerList(Map params, List<Cookie> cookie) {
  final page = params['page'] ?? 1;
  final size = params['size'] ?? 80;
  final sin = (page - 1) * size;

  final data = {
    "data": json.encode({
      "comm": {"ct": 24, "cv": 10000},
      "singerList": {
        "module": "music.musichallSinger.SingerList",
        "method": "GetSingerListIndex",
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
Future<Answer> _singerInfo(Map params, List<Cookie> cookie) {
  final data = {
    "data": json.encode({
      "comm": {"ct": 24, "cv": 0},
      "detail": {
        "method": "GetSingerDetail",
        "param": {
          "singer_mids": [params["singerMid"]],
          "ex_singer": 1,
          "wiki_singer": 1,
          "group_singer": 0,
          "pic": 1,
          "photos": 0
        },
        "module": "music.musichallSinger.SingerInfoInter"
      },
    })
  };
  return _get(
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    params: data,
    cookie: cookie,
  );
}

/*
* 歌手热门音乐
*/
Future<Answer> _singerSong(Map params, List<Cookie> cookie) {
  final page = params['page'] ?? 1;
  final size = params['size'] ?? 10;
  final sin = (page - 1) * size;

  final data = {
    "data": json.encode({
      "comm": {"ct": 24, "cv": 0},
      "singerSongList": {
        "module": "musichall.song_list_server",
        "method": "GetSingerSongList",
        "param": {
          "order": 1,
          "singerMid": params["singerMid"],
          "begin": sin,
          "num": size,
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
* 歌手专辑
*/
Future<Answer> _singerAlbum(Map params, List<Cookie> cookie) {
  final page = params['page'] ?? 1;
  final size = params['size'] ?? 10;
  final sin = (page - 1) * size;
  final data = {
    "data": json.encode({
      "comm": {"ct": 24, "cv": 0},
      "albumList": {
        "method": "GetAlbumList",
        "module": "music.musichallAlbum.AlbumListServer",
        "param": {
          "singerMid": params["singerMid"],
          "order": 0,
          "begin": sin,
          "num": size,
          "songNumTag": 0,
          "singerID": 0,
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

Future<Answer> _singerMV(Map params, List<Cookie> cookie) {
  final page = params['page'] ?? 1;
  final size = params['size'] ?? 20;
  final sin = (page - 1) * size;
  final data = {
    "data": json.encode({
      "comm": {"ct": 24, "cv": 10000},
      "similarSingerList": {
        "method": "GetSingerMvList",
        "param": {
          "singermid": params["singerMid"],
          "count": size,
          "start": sin,
          "order": 1,
        },
        "module": "MvService.MvInfoProServer"
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
* 相似歌手
*/
Future<Answer> _singerSimilar(Map params, List<Cookie> cookie) {
  final data = {
    "data": json.encode({
      "comm": {"ct": 24, "cv": 10000},
      "similarSingerList": {
        "method": "GetSimilarSingerList",
        "module": "music.SimilarSingerSvr",
        "param": {
          "singerMid": params["singerMid"],
          "num": 5,
          "singerId": 0,
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
