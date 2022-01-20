import 'dart:convert';
import 'package:music_api/entity/music_entity.dart';
import 'package:universal_io/io.dart';

import 'package:music_api/utils/answer.dart';
import 'package:music_api/utils/types.dart';
import 'package:music_api/http/http.dart';

part 'module/search.dart';

class MyFreeMp3 {
  MyFreeMp3._();

  static Future<Answer> search({String? keyWord, int? page, int? sort}) {
    return _search.call({"keyWord": keyWord, "page": page, "sort": sort}, []);
  }

  static Future<Answer> api(String? path, {Map? params, List<Cookie> cookie = const []}) {
    if (!_api.containsKey(path)) {
      return Future.value(const Answer(site: MusicSite.MyFreeMp3).copy(data: {'code': 500, 'msg': "url:“$path”未被定义, 请检查", 'path': _api.keys.toList()}));
    }
    return _api[path]!.call(params ?? {}, cookie);
  }
}

//Api列表
final _api = <String, Api>{
  "/search": _search,
};

//请求
Future<Answer> _post(String path, {Map<String, dynamic>? params, List<Cookie> cookie = const []}) async {
  Map<String, String> header = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36 Edg/96.0.1054.43",
    "origin": "https://myfreemp3juices.cc",
    "referer": "https://myfreemp3juices.cc/",
  };
  return Http.post(path, params: params, headers: header).then((value) async {
    try {
      if (value.statusCode == 200) {
        var cookies = value.headers[HttpHeaders.setCookieHeader];
        var ans = const Answer(site: MusicSite.MyFreeMp3);
        if (cookies != null) {
          ans = ans.copy(cookie: cookies.map((str) => Cookie.fromSetCookieValue(str)).toList());
        }
        String content = await value.transform(utf8.decoder).join();
        var data = content.replaceFirst("({", "{").replaceAll("});", "}").replaceAll('["apple",', "[");
        ans = ans.copy(code: value.statusCode, data: json.decode(data));
        return Future.value(ans);
      } else {
        return Future.error(Answer(site: MusicSite.MyFreeMp3, code: 500, data: {'code': value.statusCode, 'msg': value}));
      }
    } catch (e) {
      return Future.error(const Answer(site: MusicSite.MyFreeMp3, code: 500, data: {'code': 500, 'msg': "MyFreeMp3对象转换异常"}));
    }
  });
}
