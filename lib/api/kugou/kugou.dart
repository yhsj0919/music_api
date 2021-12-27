import 'dart:convert';
import 'dart:io';

import 'package:music_api/api/utils/answer.dart';
import 'package:music_api/api/utils/types.dart';
import 'package:music_api/http/http.dart';

part 'module/album.dart';
part 'module/bang.dart';
part 'module/banner.dart';
part 'module/music.dart';
part 'module/mv.dart';
part 'module/play_list.dart';
part 'module/search.dart';
part 'module/singer.dart';

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
  static Future playListInfo({String? id, int? page}) {
    return _playListInfo.call({"id": id, "page": page}, []);
  }

  ///排行榜列表
  static Future bangList() {
    return _bangList.call({}, []);
  }

  ///排行榜详情
  static Future bangInfo({String? rankId}) {
    return _bangInfo.call({"rankId": rankId}, []);
  }

  ///排行榜歌曲
  static Future bangSong({String? rankId, int? page, int? size}) {
    return _bangSong.call({"rankId": rankId, "page": page, "size": size}, []);
  }

  ///专辑列表
  static Future albumList({int? page}) {
    return _albumList.call({"page": page}, []);
  }

  ///歌手列表
  static Future singerList({String? classId, int? page}) {
    return _singerList.call({"classId": classId, "page": page}, []);
  }

  ///歌手信息
  static Future singerInfo({
    String? id,
  }) {
    return _singerInfo.call({"id": id}, []);
  }

  ///歌手信息
  static Future singerSong({String? id, int? page, int? size}) {
    return _singerSong.call({"id": id, "page": page, "size": size}, []);
  }

  ///歌手专辑
  static Future singerAlbum({String? id, int? page, int? size}) {
    return _singerAlbum.call({"id": id, "page": page, "size": size}, []);
  }

  ///歌手MV
  static Future singerMv({String? id, int? page, int? size}) {
    return _singerMv.call({"id": id, "page": page, "size": size}, []);
  }

  ///专辑信息
  static Future albumInfo({String? albumId}) {
    return _albumInfo.call({"albumId": albumId}, []);
  }

  ///专辑歌曲
  static Future albumSong({String? albumId}) {
    return _albumSong.call({"albumId": albumId}, []);
  }

  ///MV列表
  static Future mvList({int? page}) {
    return _mvList.call({"page": page}, []);
  }

  ///MV详情
  static Future mvInfo({String? hash}) {
    return _mvInfo.call({"hash": hash}, []);
  }

  ///搜索提示
  static Future searchTip({String? keyword}) {
    return _searchTip.call({"keyword": keyword}, []);
  }

  ///搜索单曲
  static Future searchSong({String? keyword, int? page, int? size}) {
    return _searchSong.call({"keyword": keyword, "page": page, "size": size}, []);
  }

  ///搜索专辑
  static Future searchAlbum({String? keyword, int? page, int? size}) {
    return _searchAlbum.call({"keyword": keyword, "page": page, "size": size}, []);
  }

  ///搜索mv
  static Future searchMv({String? keyword, int? page, int? size}) {
    return _searchMv.call({"keyword": keyword, "page": page, "size": size}, []);
  }

  ///搜索歌单
  static Future searchPlayList({String? keyword, int? page, int? size}) {
    return _searchPlayList.call({"keyword": keyword, "page": page, "size": size}, []);
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
  Map<String, String> header = {
    "User-Agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1 Edg/96.0.4664.93",
    "Cookie": "kg_mid=75a1afdf9b6c2b7f1fb911da060b78ac",
  };

  return Http.get(path, params: params, headers: header).then((value) async {
    try {
      if (value.statusCode == 200) {
        var cookies = value.headers[HttpHeaders.setCookieHeader];
        var ans = const Answer();
        if (cookies != null) {
          ans = ans.copy(cookie: cookies.map((str) => Cookie.fromSetCookieValue(str)).toList());
        }
        String data = await value.transform(utf8.decoder).join();
        ans = ans.copy(status: value.statusCode, body: json.decode(data));

        return Future.value(ans);
      } else {
        return Future.value(Answer(status: 500, body: {'code': value.statusCode, 'msg': value}));
      }
    } catch (e) {
      return Future.value(const Answer(status: 500, body: {'code': 500, 'msg': "对象转换异常"}));
    }
  });
}
