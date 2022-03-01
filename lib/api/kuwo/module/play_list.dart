part of '../kuwo.dart';

///歌单推荐
Future<Answer> _playListRec(Map params, List<Cookie> cookie) {
  return _get(
    "http://kuwo.cn/api/www/rcm/index/playlist?id=rcm&pn=1&rn=5",
    params: {
      "id": "rcm",
      "pn": 1,
      "rn": 10,
    },
    cookie: cookie,
  );
}

///歌单标签
Future<Answer> _playListTag(Map params, List<Cookie> cookie) {
  return _get(
    "http://kuwo.cn/api/www/playlist/getTagList",
    params: {},
    cookie: cookie,
  );
}

///热门歌单
///order:hot,new
Future<Answer> _playList(Map params, List<Cookie> cookie) {
  var data = {
    "pn": params["page"] ?? 1,
    "rn": params["size"] ?? 10,
  };

  if (params["id"] != null) {
    data["id"] = params["id"];
  } else {
    data["order"] = params["order"] ?? "new";
  }

  var url = "http://kuwo.cn/api/www/classify/playlist/${data.containsKey("id") ? "getTagPlayList" : "getRcmPlayList"}";

  return _get(
    url,
    params: data,
    cookie: cookie,
  );
}

Future<Answer> _playListInfo(Map params, List<Cookie> cookie) {
  return _get(
    "http://kuwo.cn/api/www/playlist/playListInfo",
    params: {
      "pid": params["id"],
      "pn": params["page"] ?? 1,
      "rn": params["size"] ?? 100,
    },
    cookie: cookie,
  );
}

Future<Answer> _playListInfoAll(Map params, List<Cookie> cookie) {
  // params["size"] = 100;
  return _playListInfo(params, cookie).then((value) async {
    var data = value.data;
    try {
      var info = data["data"];
      var list = data["data"]["musicList"] as List?;
      var total = data["data"]["total"];
      var pagesize = 100;

      var size = getPageSize(total, pagesize, currentTotal: list?.length ?? 0);

      var otherSongs = (await Future.wait(
        List.generate(
          size - 1,
          (data) {
            return _playListInfo({"id": params["id"], "page": data + 2}, cookie);
          },
        ),
      ))
          .map(
        (e) {
          var data = e.data;
          var list = data["data"]["musicList"] as List?;
          return list;
        },
      ).toList();
      for (var element in otherSongs) {
        list?.addAll((element as List));
      }
      info["musicList"] = list;

      return value.copy(data: info);
    } catch (e) {
      print(e);
    }

    return value;
  });
}
