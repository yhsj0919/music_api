part of '../my_free_mp3.dart';

///搜索
///sort data:0,Longest:1,Popular:2
Future<Answer> _search(Map params, List<Cookie> cookie) {
  return _post(
    "https://myfreemp3juices.cc/api/api_search.php",
    params: {
      "q": params['keyWord'],
      "page": params['page'] ?? 0,
      "sort": params['sort'] ?? 0,
    },
    cookie: cookie,
  ).then((value) {
    var body = value.data;
    var musics = (body["response"] as List?)?.map((element) {
      return {
        "site": MusicSite.MyFreeMp3.name,
        "id": "${element["id"]}",
        "name": element["title"],
        "artist": (element["artist"]?.toString())?.split(",").map((name) => {"name": name}).toList() ?? [],
        "album": {"id": "${element["album"]?["id"]}", "name": element["album"]?["title"], "thumb": element["album"]?["thumb"]?["photo_300"]},
        "url": [
          {"format": MusicFormat.HQ.name, "url": element["url"]}
        ],
        "thumb": element["album"]?["thumb"]?["photo_300"],
        "date": element["date"]
      };
    });

    var resp = Resp(code: musics == null ? 500 : 200, msg: musics == null ? "服务器异常" : "操作成功", data: musics?.toList());

    return Future.value(value.copy(data: resp));
  });
}
