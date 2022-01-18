part of '../baidu.dart';


//banner
Future<Answer> _playlistRec(Map query, List<Cookie> cookie) {
  return _get(
    "https://api-qianqian.taihe.com/v1/index",
    params: {},
    cookie: cookie,
  ).then((value) {
    var data = value.data;
    var list = (data["data"] as List?)?.firstWhere((element) => element["type"] == "tracklist");
    data["data"] = list;
    return Future.value(value.copy(data: data));
  });
}

/*
 * 歌单分类
*/
Future<Answer> _playListType(Map params, List<Cookie> cookie) {
  return _get(
    "https://api-qianqian.taihe.com/v1/tracklist/category",
    params: {},
    cookie: cookie,
  );
}

/*
 * 歌单分类详情
 * https://api-qianqian.taihe.com/v1/tracklist/list?appid=16073360&pageNo=1&pageSize=20
*/
Future<Answer> _playList(Map params, List<Cookie> cookie) {
  LinkedHashMap<String, dynamic> data = LinkedHashMap();
  data['pageNo'] = params['page'] ?? 1;
  data['pageSize'] = params['size'] ?? 20;

  if (params['subCateId'] != null) {
    data['subCateId'] = params['subCateId'];
  }
  return _get(
    "https://api-qianqian.taihe.com/v1/tracklist/list",
    params: data,
    cookie: cookie,
  );
}

/*
 * 歌单详情、推荐歌单
*/
Future<Answer> _playListInfo(Map params, List<Cookie> cookie) {
  LinkedHashMap<String, dynamic> data = LinkedHashMap();
  data['id'] = params['id'];
  data['pageNo'] = params['page'] ?? 1;
  data['pageSize'] = params['size'] ?? 20;
  return _get(
    "https://api-qianqian.taihe.com/v1/tracklist/info",
    params: data,
    cookie: cookie,
  );
}
