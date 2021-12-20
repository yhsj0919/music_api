import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:music_api/api/utils/answer.dart';
import 'package:music_api/api/utils/types.dart';
import 'package:music_api/http/http.dart';
import 'package:uuid/uuid.dart';

part 'module/album.dart';

part 'module/banner.dart';

part 'module/mv.dart';

part 'module/playList.dart';

part 'module/search.dart';

part 'module/song.dart';

part 'module/singer.dart';

part 'module/topList.dart';

class MiGu {
  MiGu._();

  ///banner
  static Future banner() {
    return _banner.call({}, []);
  }

  ///新碟上架
  static Future albumNewWeb({int? page, int? size}) {
    return _albumNewWeb.call({"page": page, "size": size}, []);
  }

  ///新碟类型
  static Future albumNewType() {
    return _albumNewType.call({}, []);
  }

  ///新碟上架
  static Future albumNew({String? columnId, int? page, int? size}) {
    return _albumNew.call({"columnId": columnId, "page": page, "size": size}, []);
  }

  ///专辑歌曲
  static Future albumSong({String? albumId, String? type, int? page, int? size}) {
    return _albumSong.call({"albumId": albumId, "type": type, "page": page, "size": size}, []);
  }

  ///专辑歌曲
  static Future albumSong2({String? albumId, int? page, int? size}) {
    return _albumSong2.call({"albumId": albumId, "page": page, "size": size}, []);
  }

  ///专辑详情
  static Future albumInfo({String? albumId, String? type}) {
    return _albumInfo.call({"albumId": albumId, "type": type}, []);
  }

  ///专辑详情
  static Future albumInfo2({String? albumId}) {
    return _albumInfo2.call({"albumId": albumId}, []);
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

Options _buildOptions(String path, List<Cookie> cookies) {
  final options = Options();
  options.sendTimeout = 3000;
  options.receiveTimeout = 3000;
  final headers = {
    "user-agent": "Mozilla/5.0 (Linux; U; Android 8.0.0; zh-cn; MI 5 Build/OPR1.170623.032) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30",
    "channel": "0146921",
    "Cookie": cookies.join("; "),
  };

  if (path.contains('m.music.migu.cn')) {
    headers['Referer'] = 'https://m.music.migu.cn/';
  }
  if (path.contains('app.c.nf.migu.cn')) {
    headers['Referer'] = 'https://app.c.nf.migu.cn/';
  }

  options.headers = headers;
  return options;
}

Future<Answer> _get(String path, {Map<String, dynamic> params = const {}, List<Cookie> cookie = const [], Map<String, dynamic> header = const {}}) async {
  final options = _buildOptions(path, cookie);

  if (header.isNotEmpty) {
    options.headers?.addAll(header);
  }

  return Http.get(path, params: params, options: options).then((value) {
    try {
      if (value?.statusCode == 200) {
        var cookies = value?.headers[HttpHeaders.setCookieHeader] ?? [];
        var ans = const Answer();
        ans = ans.copy(cookie: cookies.map((str) => Cookie.fromSetCookieValue(str)).toList());
        var data = value?.data;
        ans = ans.copy(status: value?.statusCode, body: data);
        return Future.value(ans);
      } else {
        return Future.value(Answer(status: 500, body: {'code': value?.statusCode, 'msg': value?.data}));
      }
    } catch (e) {
      return Future.value(const Answer(status: 500, body: {'code': 500, 'msg': "对象转换异常"}));
    }
  });
}

//请求
Future<Answer> _post(String path, {Map<String, dynamic> params = const {}, List<Cookie> cookie = const []}) async {
  final options = _buildOptions(path, cookie);

  return Http.postForm(path, params: params, options: options).then((value) {
    try {
      if (value?.statusCode == 200) {
        var cookies = value?.headers[HttpHeaders.setCookieHeader] ?? [];
        var ans = const Answer();
        ans = ans.copy(cookie: cookies.map((str) => Cookie.fromSetCookieValue(str)).toList());
        var data = value?.data;
        ans = ans.copy(status: value?.statusCode, body: data);
        return Future.value(ans);
      } else {
        return Future.value(Answer(status: 500, body: {'code': value?.statusCode, 'msg': value?.data}));
      }
    } catch (e) {
      return Future.value(const Answer(status: 500, body: {'code': 500, 'msg': "对象转换异常"}));
    }
  });
}
