part of '../migu.dart';

/*
* 新歌
 */
Future<Answer> _songNewWeb(Map params, List<Cookie> cookie) {
  final data = {
    "pageSize": params["size"] ?? 10,
    "nid": 23853978,
    "pageNo": params["page"] ?? 0,
  };
  return _get(
    "https://m.music.migu.cn/migu/remoting/cms_list_tag",
    params: data,
    cookie: cookie,
  );
}

/*
 * 新歌类型
 */
Future<Answer> _songNewType(Map params, List<Cookie> cookie) {
  final data = {
    "templateVersion": 4,
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/get-new-music-list-header",
    params: data,
    cookie: cookie,
  ).then((value) {
    final data = value.data;
    final contentItemList = data['data']['contentItemList'] as List;
    final itemList = contentItemList[0]['itemList'] as List;
    data['data']['contentItemList'] = itemList.map((e) {
      final actionUrl = e['actionUrl'];
      final columnId = Uri.parse(actionUrl).queryParameters['columnId'];
      e['columnId'] = columnId;
      return e;
    }).toString();
    final resp = value.copy(data: data);
    return Future.value(resp);
  });
}

/*
 * 新歌
 */
Future<Answer> _songNew(Map params, List<Cookie> cookie) {
  final data = {
    "columnId": params['columnId'],
    "count": params['size'] ?? 20,
    "start": params['page'] ?? 1,
    "templateVersion": 7,
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/new-music-list-data/release",
    params: data,
    cookie: cookie,
  );
}

/*
* 播放地址
 */
Future<Answer> _playUrl(Map params, List<Cookie> cookie) {
  final data = {
    // "albumId": params['albumId'],
    "netType": '01',
    "resourceType": 2,
    "songId": params['songId'],
    "toneFlag": params['toneFlag'] ?? 'PQ',
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM2.0/strategy/listen-url/v2.3",
    params: data,
    cookie: cookie,
  );
}

/*
* 播放地址
* {
   "formatType": "LQ",
   "resourceType": "2",
  },
  {
   "formatType": "PQ",
   "resourceType": "2",
  },
  {
   "formatType": "HQ",
   "resourceType": "2",
  },
  {
   "formatType": "SQ",
   "resourceType": "E",
  },
  {
  "formatType": "ZQ24",
  "resourceType": "2",
  }
 */
Future<Answer> _playUrl2(Map params, List<Cookie> cookie) {
  final data = {
    "netType": '00',
    "copyrightId": 0,
    "contentId": params['contentId'],
    "resourceType": params['resourceType'] ?? '2',
    "channel": 0,
    "toneFlag": params['toneFlag'] ?? 'PQ',
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM2.0/v1.0/content/sub/listenSong.do",
    params: data,
    cookie: cookie,
    followRedirects: false,
  );
}
