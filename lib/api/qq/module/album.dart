part of '../qq.dart';

/*
* 新专辑、新碟
 */
Future<Answer> newAlbum(Map params, List<Cookie> cookie) {
  final num = params['num'] ?? 20;
  final page = params['page'] ?? 1;
  final start = (page - 1) * num;

  final data = {
    "data": json.encode({
      "new_album": {
        "module": "newalbum.NewAlbumServer",
        "method": "get_new_album_info",
        "param": {"area": 1, "start": start, "num": num}
      },
      "new_album_tag": {
        "module": "newalbum.NewAlbumServer",
        "method": "get_new_album_area",
        "param": {},
      },
      "comm": {"ct": 24, "cv": 0}
    })
  };
  return _get(
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    params: data,
    cookie: cookie,
  );
}

///专辑歌曲列表
Future<Answer> albumSongList(Map params, List<Cookie> cookie) {
  final num = params['num'] ?? 20;
  final page = params['page'] ?? 1;
  final start = (page - 1) * num;

  final data = {
    "data": json.encode({
      "comm": {"ct": 24, "cv": 10000},
      "albumSonglist": {
        "method": "GetAlbumSongList",
        "param": {
          "albumMid": params["albumMid"],
          "albumID": 0,
          "begin": start,
          "num": num,
          "order": 2,
        },
        "module": "music.musichallAlbum.AlbumSongList"
      }
    })
  };
  return _get(
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    params: data,
    cookie: cookie,
  );
}

///专辑信息
Future<Answer> albumInfo(Map params, List<Cookie> cookie) {
  final num = params['num'] ?? 60;
  final page = params['page'] ?? 1;
  final start = (page - 1) * num;

  final data = {
    "data": json.encode({
      //该歌手其他专辑
      "req_0": {
        "module": "music.musichallAlbum.OtherAlbumList",
        "method": "OtherAlbumList",
        "param": {"albumMid": params["albumMid"], "order": 0, "num": 6}
      },
      //专辑信息
      "req_1": {
        "module": "music.musichallAlbum.AlbumInfoServer",
        "method": "GetAlbumDetail",
        "param": {"albumMid": params["albumMid"]}
      },
      //专辑歌曲
      "req_2": {
        "module": "music.musichallAlbum.AlbumSongList",
        "method": "GetAlbumSongList",
        "param": {"albumMid": params["albumMid"], "begin": start, "num": num, "order": 2}
      },
      //是否收藏？
      "req_3": {
        "module": "music.musicasset.AlbumFavRead",
        "method": "IsAlbumFan",
        "param": {
          "v_albumMid": [params["albumMid"]]
        }
      },
      "req_4": {
        "method": "QueryAlbumDetail",
        "param": {"albummid": params["albumMid"]},
        "module": "mall.MusicMallSvr"
      },
      "comm": {"g_tk": 709041629, "uin": "0", "format": "json", "ct": 20, "cv": 1803, "platform": "wk_v17"}
    })
  };
  return _get(
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    params: data,
    cookie: cookie,
  );
}
