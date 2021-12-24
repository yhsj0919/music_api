import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:music_api/api/utils/answer.dart';
import 'package:music_api/api/utils/types.dart';
import 'package:music_api/api/utils/utils.dart';
import 'package:music_api/http/http.dart';
import 'package:xml2json/xml2json.dart';

part 'module/album.dart';

part 'module/home.dart';

part 'module/mv.dart';

part 'module/playlist.dart';

part 'module/radio.dart';

part 'module/search.dart';

part 'module/singer.dart';

part 'module/song.dart';

part 'module/toplist.dart';

class QQ {
  QQ._();

  ///首页
  static Future home() {
    return _home.call({}, []);
  }

  ///新专辑、新碟
  static Future newAlbum({int? area, int? page, int? size}) {
    return _newAlbum.call({"area": area, "page": page, "size": size}, []);
  }

  ///专辑歌曲列表
  static Future albumSongList({String? albumMid, int? page, int? size}) {
    return _albumSongList.call({"albumMid": albumMid, "page": page, "size": size}, []);
  }

  ///专辑信息
  static Future albumInfo({String? albumMid, int? page, int? size}) {
    return _albumInfo.call({"albumMid": albumMid, "page": page, "size": size}, []);
  }

  ///mv推荐
  static Future mvRec({int? page, int? size}) {
    return _mvRec.call({"page": page, "size": size}, []);
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
  // "/search": _search,
};

Map<String, String> _buildHeader(String path, List<Cookie> cookies) {
  final headers = {
    "user-agent": "Mozilla/5.0 (Linux; U; Android 8.0.0; zh-cn; MI 5 Build/OPR1.170623.032) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30",
    "Cookie": cookies.join("; "),
  };

  if (path.contains('y.qq.com')) {
    headers['Referer'] = 'https://y.qq.com';
  }
  return headers;
}

Future<Answer> _get(
  String path, {
  Map<String, dynamic> params = const {},
  List<Cookie> cookie = const [],
  Map<String, String> header = const {},
  String contentType = "json",
}) async {
  final options = _buildHeader(path, cookie);

  if (header.isNotEmpty) {
    options.addAll(header);
  }

  return _httpGet(path, params: params, headers: options).then((value) async {
    try {
      if (value.statusCode == 200) {
        var cookies = value.headers[HttpHeaders.setCookieHeader] ?? [];
        var ans = const Answer();
        ans = ans.copy(cookie: cookies.map((str) => Cookie.fromSetCookieValue(str)).toList());
        String content = await value.transform(utf8.decoder).join();
        if (contentType == 'json') {
          ans = ans.copy(status: value.statusCode, body: json.decode(content));
        }
        if (contentType == 'xml') {
          final xml2Json = Xml2Json();
          xml2Json.parse(content);
          var body = json.decode(xml2Json.toParker())['result'];

          body['code'] = int.tryParse(body['code']) ?? -1;

          ans = ans.copy(status: value.statusCode, body: body);
        }

        return Future.value(ans);
      } else {
        return Future.value(Answer(status: 500, body: {'code': value.statusCode, 'msg': value}));
      }
    } catch (e) {
      return Future.value(const Answer(status: 500, body: {'code': 500, 'msg': "对象转换异常"}));
    }
  });
}

Future<HttpClientResponse> _httpGet(String url, {Map<String, dynamic>? params, Map<String, String>? headers}) {
  url += "?${toParamsString(LinkedHashMap.from(params ?? {}))}";

  return HttpClient().getUrl(Uri.parse(url)).then((request) {
    headers?.forEach(request.headers.add);
    return request.close();
  });
}
