part of '../qq.dart';

/*
 * MV推荐
 */
Future<Answer> mvRec(Map params, List<Cookie> cookie) {
  final page = params['page'] ?? 1;
  final size = params['size'] ?? 20;
  final sin = (page - 1) * size;

  final data = {
    "data": {
      "rec": {"module": "MvService.MvInfoProServer", "method": "GetRecMv", "param": {}},
      "new": {
        "module": "MvService.MvInfoProServer",
        "method": "GetNewMv",
        "param": {"style": 1, "tag": 0, "size": 10, "start": 0}
      },
      "hot": {
        "module": "MvService.MvInfoProServer",
        "method": "GetHotMv",
        "param": {"style": 1, "tag": 16, "size": 10, "start": 0}
      },
      "collection": {"module": "video.VideoLogicServer", "method": "get_video_collection_main", "param": {}},
      "discovery": {
        "module": "video.VideoDiscoveryServer",
        "method": "get_discovery_video",
        "param": {"page": 1}
      },
      "comm": {"g_tk": 5381, "uin": 0, "format": "json", "ct": 20, "cv": 1807, "platform": "wk_v17"}
   }
  };
  return _get(

    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    params: data,
    cookie: cookie,
  );
}

/*
 * 全部MV
 * order 1，最新，0最热
 */
Future<Answer> mvlist(Map params, List<Cookie> cookie) {
  final page = params['page'] ?? 1;
  final size = params['size'] ?? 20;
  final sin = (page - 1) * size;

  final data = {
    "data": {
      "comm": {"ct": 24},
      "mv_tag": {"module": "MvService.MvInfoProServer", "method": "GetAllocTag", "param": {}},
      "mv_list": {
        "module": "MvService.MvInfoProServer",
        "method": "GetAllocMvInfo",
        "param": {"start": sin, "size": size, "version_id": 7, "area_id": 15, "order": 1}
      }
   }
  };
  return _get(

    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    params: data,
    cookie: cookie,
  );
}

/*
 *mv信息，更多推荐
 */
Future<Answer> mvInfo(Map params, List<Cookie> cookie) {
  final data = {
    "data": {
      "comm": {"ct": 24, "cv": 4747474},
      "mvinfo": {
        "module": "video.VideoDataServer",
        "method": "get_video_info_batch",
        "param": {
          "vidlist": [params['vid']],
          "required": [
            "vid",
            "type",
            "sid",
            "cover_pic",
            "duration",
            "singers",
            "video_switch",
            "msg",
            "name",
            "desc",
            "playcnt",
            "pubdate",
            "isfav",
            "gmid",
          ],
        }
      },
      "other": {
        "module": "video.VideoLogicServer",
        "method": "rec_video_byvid",
        "param": {
          "vid": params['vid'],
          "required": [
            "vid",
            "type",
            "sid",
            "cover_pic",
            "duration",
            "singers",
            "video_switch",
            "msg",
            "name",
            "desc",
            "playcnt",
            "pubdate",
            "isfav",
            "gmid",
            "uploader_headurl",
            "uploader_nick",
            "uploader_encuin",
            "uploader_uin",
            "uploader_hasfollow",
            "uploader_follower_num"
          ],
          "support": 1
        }
      }
   }
  };
  return _get(

    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    params: data,
    cookie: cookie,
  );
}
/*
* MV播放地址
 */
Future<Answer> mvUrl(Map params, List<Cookie> cookie) {
  final data = {
    "comm": {"ct": 24, "cv": 4747474, "g_tk": 812935580, "uin": 0, "format": "json", "platform": "yqq"},
    "data": {
      "mvUrl": {
        "module": "gosrf.Stream.MvUrlProxy",
        "method": "GetMvUrls",
        "param": {
          "vids": [params['vid']],
          "request_typet": 10001,
          "addrtype": 3,
          "format": 264
        }
      },
   }
  };
  return _get(

    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    params: data,
    cookie: cookie,
  );
}
