part of '../migu.dart';

/*
* 新歌
 */
Future<Answer> _songNewWeb(Map params, List<Cookie> cookie) {
  return _get(
    "https://m.music.migu.cn/migumusic/h5/home/newsong",
    params: {},
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
// const qualitys = {
//   '128k': 'PQ',
//   '320k': 'HQ',
//   flac: 'SQ',
//   flac24bit: 'ZQ',
// }
Future<Answer> _playUrl(Map params, List<Cookie> cookie) {
  final data = {
    // "albumId": params['albumId'],
    "netType": '01',
    "resourceType": 2,
    "songId": params['songId'],
    "toneFlag": params['toneFlag'] ?? 'PQ',
    "timestamp": DateTime.now().millisecondsSinceEpoch,
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
    "toneFlag": params['toneFlag'] ?? 'HQ',
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM2.0/v1.0/content/sub/listenSong.do",
    params: data,
    cookie: cookie,
    followRedirects: false,
  );
}
// resourceId 可以是专辑id，可以是歌曲id
// obj[typeMap[formatType]] = url.replace(/ftp:\/\/[^/]+/, 'https://freetyst.nf.migu.cn');
// 2003专辑 2 歌曲  2021歌单
// https://app.c.nf.migu.cn/MIGUM2.0/v1.0/content/resourceinfo.do?needSimple=01&resourceId=1003767159&resourceType=2003
//https://app.c.nf.migu.cn/MIGUM2.0/v1.0/content/resourceinfo.do?needSimple=01&resourceId=600929000002872565&resourceType=2
// https://c.musicapp.migu.cn/MIGUM2.0/v1.0/content/resourceinfo.do?copyrightId=60054704981&resourceType=2
// https://app.c.nf.migu.cn/MIGUM2.0/v2.0/content/querySongBySongId.do?songId=1141310219
/*
* 歌词
 */
Future<Answer> _songLrc(Map params, List<Cookie> cookie) {
  //https://app.c.nf.migu.cn/MIGUM2.0/strategy/listen-url/v2.2?netType=01&resourceType=E&songId=155554&toneFlag=ZQ
  final data = {
    // "albumId": params['albumId'],
    "netType": '01',
    "resourceType": 2,
    "songId": params['songId'],
    "toneFlag": params['toneFlag'] ?? 'PQ',
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM2.0/strategy/listen-url/v2.2",
    params: data,
    cookie: cookie,
  ).then((value) async {
    var lrcUrl = value.data["data"]["songItem"]?["lrcUrl"];
    var lrc = await HttpDio().get(lrcUrl).then((value) => value?.data?.toString());
    return value.copy(data: lrc);
  });
}
