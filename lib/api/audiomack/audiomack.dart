import 'dart:collection';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:music_api/entity/music_entity.dart';
import 'package:music_api/http/http_dio.dart';
import 'package:universal_io/io.dart';

import 'package:music_api/utils/answer.dart';
import 'package:music_api/utils/types.dart';

part 'module/search.dart';

class AudioMack {
  AudioMack._();

  static Future<Answer> search({String? keyWord, int? page, int? sort}) {
    return _search.call({"keyWord": keyWord, "page": page, "sort": sort}, []);
  }

  static Future<Answer> api(String? path, {Map? params, List<Cookie> cookie = const []}) {
    if (!_api.containsKey(path)) {
      return Future.value(const Answer(site: MusicSite.AudioMack).copy(data: {'code': 500, 'msg': "url:“$path”未被定义, 请检查", 'path': _api.keys.toList()}));
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
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36 Edg/96.0.1054.43"
  };
  return HttpDio().postForm(path, params: params, headers: header).then((value) async {
    try {
      if (value?.statusCode == 200) {
        var cookies = value?.headers[HttpHeaders.setCookieHeader];
        var ans = const Answer(site: MusicSite.AudioMack);
        if (cookies != null) {
          ans = ans.copy(cookie: cookies.map((str) => Cookie.fromSetCookieValue(str)).toList());
        }
        String? content = value?.data.toString().trim().replaceFirst("({", "{").replaceAll("});", "}");
        ans = ans.copy(code: value?.statusCode, data: json.decode(content ?? "{}"));
        return Future.value(ans);
      } else {
        return Future.error(Answer(site: MusicSite.AudioMack, code: 500, data: {'code': value?.statusCode, 'msg': value}));
      }
    } catch (e) {
      return Future.error(const Answer(site: MusicSite.AudioMack, code: 500, data: {'code': 500, 'msg': "AudioMack对象转换异常"}));
    }
  });
}

Future<Answer> _get(String path, {Map<String, dynamic>? params, List<Cookie> cookie = const []}) async {
  var signature = getSignature(method: "GET", urlPath: path, params: params);
  params?["oauth_signature"] = signature;
  Map<String, String> header = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36 Edg/96.0.1054.43"
  };
  return HttpDio().get(path, params: params, headers: header).then((value) async {
    try {
      if (value?.statusCode == 200) {
        var cookies = value?.headers[HttpHeaders.setCookieHeader];
        var ans = const Answer(site: MusicSite.AudioMack);
        if (cookies != null) {
          ans = ans.copy(cookie: cookies.map((str) => Cookie.fromSetCookieValue(str)).toList());
        }
        String? content = json.encode(value?.data);
        ans = ans.copy(code: value?.statusCode, data: json.decode(content));
        return Future.value(ans);
      } else {
        return Future.error(Answer(site: MusicSite.AudioMack, code: 500, data: {'code': value?.statusCode, 'msg': value}));
      }
    } catch (e) {
      return Future.error(const Answer(site: MusicSite.AudioMack, code: 500, data: {'code': 500, 'msg': "AudioMack对象转换异常"}));
    }
  });
}

String nonce(int length) {
  const ch = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  Random r = Random();
  return String.fromCharCodes(Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
}

String getSignature({required String method, required String urlPath, required Map<String, dynamic>? params, String secret = "f3ac5b086f3eab260520d8e3049561e6&"}) {
  var key = utf8.encode(secret);
  var str = "${method.toUpperCase()}&${Uri.encodeComponent(urlPath)}&${Uri.encodeQueryComponent(toParamsString(LinkedHashMap.from(params ?? {})))}";
  var bytes = utf8.encode(str);
  var hmacSha256 = Hmac(sha1, key);
  var digest = hmacSha256.convert(bytes);
  var data = const Base64Codec().encode(digest.bytes);
  return data;
}

String toParamsString(LinkedHashMap? params) {
  return params?.entries.map((e) => "${e.key}=${Uri.encodeQueryComponent("${e.value}")}").join("&") ?? "";
}
