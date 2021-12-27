part of '../qq.dart';

/*
 * 榜单信息
 */
Future<Answer> _rankList(Map params, List<Cookie> cookie) {
  final data = {
    "data": json.encode({
      "req_0": {
        "module": "musicToplist.ToplistInfoServer",
        "method": "GetAll",
        "param": {},
      },
      "comm": {
        "g_tk": 709041629,
        "uin": "0",
        "format": "json",
        "ct": 20,
        "cv": 1803,
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
 * 榜单歌曲
 */
Future<Answer> _rankInfo(Map params, List<Cookie> cookie) {
  final data = {
    "data": json.encode({
      "req_0": {
        "module": "musicToplist.ToplistInfoServer",
        "method": "GetDetail",
        "param": {
          "topid": params["topId"],
          "num": 300,
          "period": params["period"],
        }
      },
      "comm": {
        "g_tk": 709041629,
        "uin": "0",
        "format": "json",
        "ct": 20,
        "cv": 1803,
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
 * 榜单歌曲
 */
Future<Answer> _mvRank(Map params, List<Cookie> cookie) {
  final data = {
    "data": json.encode({
      "comm": {
        "cv": 4747474,
        "ct": 24,
        "format": "json",
        "inCharset": "utf-8",
        "outCharset": "utf-8",
        "notice": 0,
        "platform": "yqq.json",
        "needNewCode": 1,
        "uin": 0,
        "g_tk_new_20200303": 5381,
        "g_tk": 5381
      },
      "list": {
        "module": "video.VideoRankServer",
        "method": "get_video_rank_list",
        "param": {
          "rank_type": 0,
          "area_type": params["period"] ?? 0,
          "period": params["period"],
          "required": ["vid", "name", "pubdate", "cover_pic", "singers", "trend"]
        }
      },
      "history": {
        "module": "video.VideoRankServer",
        "method": "get_history_key_list",
        "param": {"periods": 6}
      },
      "tag": {"module": "MvService.MvInfoProServer", "method": "GetToplistTag", "param": {}}
    })
  };
  return _get(
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    params: data,
    cookie: cookie,
  );
}
