import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:music_api/api/utils/answer.dart';
import 'package:music_api/api/utils/types.dart';
import 'package:music_api/http/http.dart';

part 'module/album.dart';

part 'module/banner.dart';

part 'module/music.dart';

part 'module/play_list.dart';

part 'module/bang.dart';

class KuGou {
  KuGou._();

  ///Banner
  static Future banner() {
    return _banner.call({}, []);
  }

  ///新歌推荐
  static Future musicList() {
    return _musicList.call({}, []);
  }

  ///歌曲详情
  static Future musicInfo({
    String? hash,
    String? albumAudioId,
  }) {
    return _musicInfo.call({"hash": hash, "albumAudioId": albumAudioId}, []);
  }

  ///推荐歌单
  static Future playList({int? page}) {
    return _playList.call({"page": page}, []);
  }

  ///歌单详情
  static Future playListInfo({String? id}) {
    return _playListInfo.call({"id": id}, []);
  }

  ///专辑详情
  static Future albumInfo({String? albumId, int? page, int? size}) {
    return _albumInfo.call({"albumId": albumId, "page": page, "size": size}, []);
  }

  ///排行榜列表
  static Future bangList() {
    return _bangList.call({}, []);
  }

  ///排行榜详情
  static Future bangInfo({String? rankId, int? page}) {
    return _bangInfo.call({"rankId": rankId, "page": page}, []);
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
  // "/hotSearch": _hotSearch,
};

//请求
Future<Answer> _get(String path, {Map<String, dynamic>? params, List<Cookie> cookie = const []}) async {
  final options = Options();
  options.sendTimeout = 3000;
  options.receiveTimeout = 3000;
  Map<String, dynamic> header = {
    "User-Agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1 Edg/96.0.4664.93",
    "Cookie": "kg_mid=75a1afdf9b6c2b7f1fb911da060b78ac"
  };

  options.headers = header;

  return Http.get(path, params: params, options: options).then((value) {
    try {
      if (value?.statusCode == 200) {
        var cookies = value?.headers[HttpHeaders.setCookieHeader];
        var ans = const Answer();
        if (cookies != null) {
          ans = ans.copy(cookie: cookies.map((str) => Cookie.fromSetCookieValue(str)).toList());
        }
        var data = value?.data;
        if (data is String) {
          ans = ans.copy(status: value?.statusCode, body: json.decode(data));
        } else {
          ans = ans.copy(status: value?.statusCode, body: data);
        }
        return Future.value(ans);
      } else {
        return Future.value(Answer(status: 500, body: {'code': value?.statusCode, 'msg': value?.data}));
      }
    } catch (e) {
      return Future.value(const Answer(status: 500, body: {'code': 500, 'msg': "对象转换异常"}));
    }
  });
}
