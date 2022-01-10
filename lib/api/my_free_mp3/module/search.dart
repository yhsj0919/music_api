part of '../my_free_mp3.dart';

///搜索
///sort data:0,Longest:1,Popular:2
Future<Answer> _search(Map params, List<Cookie> cookie) {
  return _post(
    "https://myfreemp3juices.cc/api/search.php",
    params: {
      "q": params['keyWords'],
      "page": params['page'] ?? 0,
      "sort": params['sort'] ?? 0,
    },
    cookie: cookie,
  ).then((value) {
    var body = value.body;
    var musics = (body["response"] as List?)?.map((element) {
      return Song(
          site: MusicSite.MyFreeMp3,
          id: "${element["id"]}",
          name: element["title"],
          artist: (element["artist"]?.toString())?.split(",").map((name) => Artist(id: null, name: name)).toList() ?? [],
          album: Album(id: "${element["album"]?["id"]}", name: element["album"]?["title"], thumb: element["album"]?["thumb"]?["photo_300"]),
          url: [Url(format: MusicFormat.HQ, url: element["url"])],
          thumb: element["album"]?["thumb"]?["photo_300"],
          date: element["date"]);
    }).toList();

    var resp = Resp(data: musics);

    return Future.value(value.copy(body: resp));
  });
}
