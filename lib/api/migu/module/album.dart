part of '../migu.dart';

/*
* 新专辑、新碟
 */
Future<Answer> _albumNewWeb(Map params, List<Cookie> cookie) {
  final data = {
    "pageSize": params["size"] ?? 10,
    "nid": 23854016,
    "pageNo": params["page"] ?? 0,
    "type": 2003,
  };
  return _get(
    "http://m.music.migu.cn/migu/remoting/cms_list_tag",
    params: data,
    cookie: cookie,
  );
}

/*
 * 新专辑类型
 */
Future<Answer> _albumNewType(Map params, List<Cookie> cookie) {
  final data = {
    "templateVersion": 7,
  };
  return _get(
    "http://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/get-new-cd-list-header",
    params: data,
    cookie: cookie,
  ).then((value) {
    final data = value.data;
    final contentItemList = data['data']['contentItemList'] as List;
    final itemList = contentItemList[0]['itemList'] as List;
    var items = itemList.map((e) {
      final actionUrl = e['actionUrl'];
      final columnId = Uri.parse(actionUrl).queryParameters['columnId'];
      e['columnId'] = columnId;
      return e;
    }).toList();

    data['data'] = items;

    final resp = value.copy(data: data);
    return Future.value(resp);
  });
}

/*
 * 全部专辑
 */
Future<Answer> _albumNew(Map params, List<Cookie> cookie) {
  final data = {
    "columnId": params['columnId'] ?? 15279065,
    "count": params['size'] ?? 20,
    "start": params['page'] ?? 1,
    "templateVersion": 7,
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM3.0/v1.0/template/get-new-cd-list-data/release",
    params: data,
    cookie: cookie,
  );
}

/*
* 专辑歌曲
 */
Future<Answer> _albumSong(Map params, List<Cookie> cookie) {
  final data = {
    "resourceId": params['albumId'],
    "needSimple": params['needSimple'] ?? "01",
    "resourceType": params['type'] ?? "2003",
    "pageNo": params['page'] ?? 1,
    "pageSize": params['size'] ?? 50,
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM2.0/v1.0/content/resourceinfo.do",
    params: data,
    cookie: cookie,
  );
}

Future<Answer> _albumSong2(Map params, List<Cookie> cookie) {
  final data = {
    "albumId": params['albumId'],
    "pageNo": params['page'] ?? 1,
    "pageSize": params['size'] ?? 50,
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM3.0/resource/album/song/v2.0",
    params: data,
    cookie: cookie,
  );
}

/*
* 专辑信息
 */
Future<Answer> _albumInfo(Map params, List<Cookie> cookie) {
  final data = {
    "resourceId": params['albumId'],
    "needSimple": params['needSimple'] ?? "00",
    "resourceType": params['type'] ?? "2003",
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM2.0/v1.0/content/resourceinfo.do",
    params: data,
    cookie: cookie,
  );
}

/*
* 专辑信息
 */
Future<Answer> _albumInfo2(Map params, List<Cookie> cookie) {
  final data = {
    "albumId": params['albumId'],
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM3.0/resource/album/v2.0",
    params: data,
    cookie: cookie,
  );
}
