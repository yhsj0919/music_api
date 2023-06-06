part of '../kuwo.dart';

///榜单列表
Future<Answer> _rankList(Map params, List<Cookie> cookie) {
  return _get(
    "http://kuwo.cn/api/www/bang/bang/bangMenu",
    params: {},
    cookie: cookie,
  );
}

///榜单列表
Future<Answer> _rankInfo(Map params, List<Cookie> cookie) {
  return _get(
    "http://kuwo.cn/api/www/bang/bang/musicList",
    params: {
      "bangId": params["id"],
      "pn": params["page"] ?? 1,
      "rn": params["size"] ?? 30,
    },
    cookie: cookie,
  );
}

Future<Answer> _rankInfoAll(Map params, List<Cookie> cookie) {
  // params["size"] = 1000;
  return _rankInfo(params, cookie).then((value) async {
    var data = value.data;
    try {
      var info = data["data"];
      var list = data["data"]["musicList"] as List?;
      var total = int.parse(data["data"]["num"].toString());
      var pagesize = 30;
      var maxTotal = params["maxTotal"];

      var size = getPageSize(total, pagesize, currentTotal: list?.length ?? 0, maxTotal: maxTotal);

      var music = (await Future.wait(
        List.generate(
          size - 1,
              (data) async {
            var resp = await _rankInfo({"id": params["id"], "page": data + 2}, cookie);

            return resp.data["data"]["musicList"] as List?;
          },
        ),
      ));

      for (var item in music) {
        if (item != null) {
          list?.addAll(item);
        }
      }

      info["musicList"] = list;

      return value.copy(data: info);
    } catch (e) {
      print(e);
    }

    return value;
  });
}
