import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:music_api/entity/music_entity.dart';
import 'package:music_api/http/http_dio.dart';
import 'package:music_api/utils/answer.dart';
import 'package:music_api/utils/types.dart';
import 'package:music_api/utils/utils.dart';
import 'package:universal_io/io.dart';

part 'module/album.dart';

part 'module/banner.dart';

part 'module/music.dart';

part 'module/mv.dart';

part 'module/play_list.dart';

part 'module/rank.dart';

part 'module/search.dart';

part 'module/singer.dart';

class KuGou {
  KuGou._();

  ///Banner
  static Future<Answer> banner() {
    return _banner.call({}, []);
  }

  ///新歌推荐
  static Future<Answer> musicNew() {
    return _musicNew.call({}, []);
  }

  ///新歌推荐
  static Future<Answer> musicList() {
    return _musicList.call({}, []);
  }

  ///歌曲详情
  static Future<Answer> musicInfo({String? hash, String? albumAudioId}) {
    return _musicInfo.call({"hash": hash, "albumAudioId": albumAudioId}, []);
  }

  ///歌曲详情
  static Future<Answer> lrc({String? hash}) {
    return _lrc.call({"hash": hash}, []);
  }

  ///歌曲详情带歌词，不一定带地址
  static Future<Answer> musicInfoWithLyric({String? hash, String? albumAudioId}) {
    return _musicInfoWithLyric.call({"hash": hash, "albumAudioId": albumAudioId}, []);
  }

  ///歌曲详情带歌词，不一定带地址
  static Future<Answer> musicInfo2({String? hash, String? albumAudioId}) {
    return _musicInfo2.call({"hash": hash, "albumAudioId": albumAudioId}, []);
  }

  ///推荐歌单
  static Future<Answer> playList({int? page}) {
    return _playList.call({"page": page}, []);
  }

  ///歌单详情
  static Future<Answer> playListInfo({String? id, int? page}) {
    return _playListInfo.call({"id": id, "page": page}, []);
  }

  ///歌单详情,包含所有歌曲
  static Future<Answer> playListInfoAll({String? id, int? page}) {
    return _playListInfoAll.call({"id": id, "page": page}, []);
  }

  ///排行榜列表
  static Future<Answer> rankList() {
    return _rankList.call({}, []);
  }

  ///排行榜详情
  static Future<Answer> rankInfo({String? rankId}) {
    return _rankInfo.call({"rankId": rankId}, []);
  }

  ///排行榜歌曲
  static Future<Answer> rankSong({String? rankId, int? page, int? size}) {
    return _rankSong.call({"rankId": rankId, "page": page, "size": size}, []);
  }

  static Future<Answer> rankSongAll({String? rankId}) {
    return _rankSongAll.call({"rankId": rankId}, []);
  }

  ///专辑列表
  static Future<Answer> albumList({int? page}) {
    return _albumList.call({"page": page}, []);
  }

  ///专辑信息
  static Future<Answer> albumInfo({String? albumId}) {
    return _albumInfo.call({"albumId": albumId}, []);
  }

  ///专辑歌曲
  static Future<Answer> albumSong({String? albumId}) {
    return _albumSong.call({"albumId": albumId}, []);
  }

  ///歌手列表
  static Future<Answer> singerList({String? classId, int? page}) {
    return _singerList.call({"classId": classId, "page": page}, []);
  }

  ///歌手信息
  static Future<Answer> singerInfo({
    String? id,
  }) {
    return _singerInfo.call({"id": id}, []);
  }

  ///歌手信息
  static Future<Answer> singerSong({String? id, int? page, int? size}) {
    return _singerSong.call({"id": id, "page": page, "size": size}, []);
  }

  ///歌手专辑
  static Future<Answer> singerAlbum({String? id, int? page, int? size}) {
    return _singerAlbum.call({"id": id, "page": page, "size": size}, []);
  }

  ///歌手MV
  static Future<Answer> singerMv({String? id, int? page, int? size}) {
    return _singerMv.call({"id": id, "page": page, "size": size}, []);
  }

  ///MV列表
  static Future<Answer> mvList({int? page}) {
    return _mvList.call({"page": page}, []);
  }

  ///MV详情
  static Future<Answer> mvInfo({String? hash}) {
    return _mvInfo.call({"hash": hash}, []);
  }

  ///搜索提示
  static Future<Answer> searchTip({String? keyword}) {
    return _searchTip.call({"keyword": keyword}, []);
  }

  ///搜索单曲
  static Future<Answer> searchSong({String? keyword, int? page, int? size}) {
    return _searchSong.call({"keyword": keyword, "page": page, "size": size}, []);
  }

  ///搜索专辑
  static Future<Answer> searchAlbum({String? keyword, int? page, int? size}) {
    return _searchAlbum.call({"keyword": keyword, "page": page, "size": size}, []);
  }

  ///搜索mv
  static Future<Answer> searchMv({String? keyword, int? page, int? size}) {
    return _searchMv.call({"keyword": keyword, "page": page, "size": size}, []);
  }

  ///搜索歌单
  static Future<Answer> searchPlayList({String? keyword, int? page, int? size}) {
    return _searchPlayList.call({"keyword": keyword, "page": page, "size": size}, []);
  }

  static Future<Answer> api(String path, {Map? params, List<Cookie> cookie = const []}) {
    if (!_api.containsKey(path)) {
      return Future.value(const Answer(site: MusicSite.KuGou).copy(data: {'code': 500, 'msg': "url:“$path”未被定义, 请检查", 'path': _api.keys.toList()}));
    }
    return _api[path]!.call(params ?? {}, cookie);
  }
}

//Api列表
final _api = <String, Api>{
  "/banner": _banner,
  "/music/list": _musicList,
  "/music/info": _musicInfo,
  "/playlist": _playList,
  "/playlist/info": _playListInfo,
  "/rank/list": _rankList,
  "/rank/info": _rankInfo,
  "/rank/song": _rankSong,
  "/album/list": _albumList,
  "/album/info": _albumInfo,
  "/album/song": _albumSong,
  "/singer/list": _singerList,
  "/singer/info": _singerInfo,
  "/singer/song": _singerSong,
  "/singer/album": _singerAlbum,
  "/singer/mv": _singerMv,
  "/mv/list": _mvList,
  "/mv/info": _mvInfo,
  "/search/tip": _searchTip,
  "/search/song": _searchSong,
  "/search/album": _searchAlbum,
  "/search/mv": _searchMv,
  "/search/playlist": _searchPlayList,
};

//请求
Future<Answer> _get(String path, {Map<String, dynamic>? params, List<Cookie> cookie = const []}) async {
  Map<String, String> header = {
    "user-agent": "Mozilla/5.0 (Linux; Android 10; SM-G981B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.162 Mobile Safari/537.36 Edg/110.0.0.0",
    "cookie": "kg_mid=13b99c4ecc49b8e85dde00e21160b008; kg_dfid=1JdAUM1MExVq2HbWdD1cveSL; kg_dfid_collect=d41d8cd98f00b204e9800998ecf8427e; musicwo17=kugou",
  };

  return HttpDio().get(path, params: params, headers: header).then((value) async {
    try {
      if (value?.statusCode == 200) {
        var cookies = value?.headers[HttpHeaders.setCookieHeader];
        var ans = const Answer(site: MusicSite.KuGou);
        if (cookies != null) {
          ans = ans.copy(cookie: cookies.map((str) => Cookie.fromSetCookieValue(str)).toList());
        }
        ans = ans.copy(code: value?.statusCode, data: json.decode(value?.data.toString() ?? "{}"));
        return Future.value(ans);
      } else {
        return Future.value(Answer(site: MusicSite.KuGou, code: 500, data: {'code': value?.statusCode, 'msg': value}));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return Future.value(const Answer(site: MusicSite.KuGou, code: 500, data: {'code': 500, 'msg': "酷狗对象转换异常"}));
    }
  });
}

String signatureParams(Map<String, dynamic> params) {
  var data = params.entries.sortedBy((element) => element.key).map((e) => "${e.key}=${e.value}").join();

  const secret = "NVPh5oo715z5DIWAeQlhMDsWXXQV4hwt";
  return md5.convert(utf8.encode("$secret$data$secret")).toString().toUpperCase();
}
