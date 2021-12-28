part of '../qq.dart';

/*
 * 全部歌单
 */
Future<Answer> _playlist(Map params, List<Cookie> cookie) {
  final page = params['page'] ?? 1;
  final size = params['size'] ?? 60;
  final sin = (page - 1) * size;

  final data = {
    "data": json.encode({
      "playlist": {
        "module": "playlist.PlayListPlazaServer",
        "method": "get_playlist_by_tag",
        "param": {
          "id": 10000000,
          "sin": sin,
          "size": size,
          //5,最新，2最热
          "order": params["order"] ?? 5,
          "is_parent": 0,
        },
      },
      "tag": {
        "method": "get_category_grid",
        "module": "playlist.PlayListNavigateServer",
        "param": {},
      },
      "allTag": {
        "method": "GetAllTag",
        "module": "music.playlist.PlaylistSquare",
        "param": {},
      },
      "comm": {
        "ct": 20,
        "cv": 1803,
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
 * 根据Tag获取歌单
 */
Future<Answer> _playlistByTag(Map params, List<Cookie> cookie) {
  final page = params['page'] ?? 1;
  final size = params['size'] ?? 60;

  final data = {
    "data": json.encode({
      "playlist": {
        "module": "playlist.PlayListCategoryServer",
        "method": "get_category_content",
        "param": {
          "last_id": "",
          "size": size,
          "page": page,
          "caller": "0",
          "category_id": params["tag"],
        },
      },
      "tag": {
        "method": "get_category_basic",
        "module": "playlist.PlayListCategoryServer",
        "param": {"caller": "0", "category_id": params["tag"]}
      },
      "comm": {
        "uin": "0",
        "ct": 20,
        "cv": 1803,
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
 *歌单详情
 */
Future<Answer> _playlistInfo(Map params, List<Cookie> cookie) {
  final page = params['page'] ?? 1;
  final size = params['size'] ?? 60;
  final sin = (page - 1) * size;

  final data = {
    "data": json.encode({
      "playlist": {
        "module": "srf_diss_info.DissInfoServer",
        "method": "CgiGetDiss",
        "param": {
          "disstid": params["id"],
          "userinfo": 1,
          "tag": 1,
        }
      },
      "comm": {
        "g_tk": 5381,
        "uin": 0,
        "format": "json",
        "ct": 20,
        "cv": 1807,
        "platform": "wk_v17",
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
 *歌单所有分类
 */
Future<Answer> _playlistTag(Map params, List<Cookie> cookie) {
  final page = params['page'] ?? 1;
  final size = params['size'] ?? 60;
  final sin = (page - 1) * size;

  final data = {
    "data": json.encode({
      "allTag": {
        "method": "GetAllTag",
        "module": "music.playlist.PlaylistSquare",
        "param": {},
      },
      "comm": {"g_tk": 5381, "uin": 0, "format": "json", "ct": 20, "cv": 1807, "platform": "wk_v17"}
    })
  };
  return _get(
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    params: data,
    cookie: cookie,
  );
}
