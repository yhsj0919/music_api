import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:music_api/api/utils/answer.dart';
import 'package:music_api/api/utils/types.dart';
import 'package:music_api/http/http.dart';

part 'module/search.dart';

class MyFreeMp3 {
  MyFreeMp3._();

  static Future search({String? keyWords, int? page, int? sort}) {
    return _search.call({"keyWords": keyWords, "page": page, "sort": sort}, []);
  }

  static Future api(String path, {Map? params, String? auth}) {
    if (!_api.containsKey(path)) {
      return Future.value(const Answer().copy(body: {'code': 500, 'msg': "此 api url 未被定义, 请检查: $path ", 'path': _api.keys.toList()}));
    }
    return _api[path]!.call(params ?? {}, []);
  }
}

//Api列表
final _api = <String, Api>{
  "/search": _search,
};

//请求
Future<Answer> _post(String path, {Map<String, dynamic>? params, List<Cookie> cookie = const []}) async {
  final options = Options();
  options.sendTimeout = 3000;
  options.receiveTimeout = 3000;

  return Http.postForm(path, params: params, options: options).then((value) {
    try {
      if (value?.statusCode == 200) {
        var cookies = value?.headers[HttpHeaders.setCookieHeader];
        var ans = const Answer();
        if (cookies != null) {
          ans = ans.copy(cookie: cookies.map((str) => Cookie.fromSetCookieValue(str)).toList());
        }
        var data = value?.data.toString().replaceFirst("({", "{").replaceAll("});", "}").replaceAll('["apple",', "[");
        ans = ans.copy(status: value?.statusCode, body: json.decode(data ?? ""));
        return Future.value(ans);
      } else {
        return Future.value(Answer(status: 500, body: {'code': value?.statusCode, 'msg': value?.data}));
      }
    } catch (e) {
      return Future.value(const Answer(status: 500, body: {'code': 500, 'msg': "对象转换异常"}));
    }
  });
}
