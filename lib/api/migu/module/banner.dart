part of '../migu.dart';

///Banner
Future<Answer> _banner(Map params, List<Cookie> cookie) {
  final data = {
    "pageSize": 10,
    "nid": 23831003,
    "pageNo": 0,
    "type": 2006,
  };
  return _get(
    "https://m.music.migu.cn/migu/remoting/cms_list_tag",
    params: data,
    cookie: cookie,
  ).then((value) {
    var body = value.data;
    body = body["result"];
    body['results'] = (body["results"] as List)
        .map((e) => {
              "title": e["linkData"]["linkDes"].toString().replaceAll("《", "").replaceAll("》", ""),
              "picUrl": e["linkData"]["linkPicUrl"],
              "type": e["linkData"]["linkTitle"].toString().replaceAll(e["linkData"]["linkDes"].toString(), ""),
              "id": e["linkData"]["linkUrl"].toString().replaceAll("https://m.music.migu.cn/v3/music/song/", ""),
            })
        .toList();
    return Future.value(value.copy(data: body));
  });
}
