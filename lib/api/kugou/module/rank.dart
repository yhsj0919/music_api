part of '../kugou.dart';

///榜单列表
Future<Answer> _rankList(Map params, List<Cookie> cookie) {
  return _get(
    "http://mobilecdnbj.kugou.com/api/v3/rank/list",
    params: {},
    cookie: cookie,
  );
}

///榜单详情
Future<Answer> _rankInfo(Map params, List<Cookie> cookie) {
  return _get(
    "http://mobilecdnbj.kugou.com/api/v3/rank/info",
    params: {
      "rankid": params["rankId"],
    },
    cookie: cookie,
  );
}

///榜单歌曲
Future<Answer> _rankSong(Map params, List<Cookie> cookie) {
  return _get(
    "http://mobilecdnbj.kugou.com/api/v3/rank/song",
    params: {
      "rankid": params["rankId"],
      "page": params["page"] ?? 1,
      "pagesize": params["size"] ?? 30,
    },
    cookie: cookie,
  );
}
Future<Answer> _rankSongAll(Map params, List<Cookie> cookie) {
  // params["size"] = 1000;
  return _rankSong(params, cookie).then((value) async {
    var data = value.data;
    try {
      var info = data["data"];
      var list = data["data"]["info"] as List?;
      var total = int.parse(data["data"]["total"].toString());
      var pagesize = 30;
      var maxTotal = params["maxTotal"];

      var size = getPageSize(total, pagesize, currentTotal: list?.length ?? 0, maxTotal: maxTotal);

      var music = (await Future.wait(
        List.generate(
          size - 1,
              (data) async {
            var resp = await _rankSong({"rankId": params["rankId"], "page": data + 2}, cookie);

            return resp.data["data"]["info"] as List?;
          },
        ),
      ));

      for (var item in music) {
        if (item != null) {
          list?.addAll(item);
        }
      }

      info["info"] = list;

      return value.copy(data: info);
    } catch (e) {
      print(e);
    }

    return value;
  });
}