import 'dart:convert';
import 'package:universal_io/io.dart';

import 'package:music_api/api/utils/answer.dart';
import 'package:music_api/api/utils/types.dart';
import 'package:music_api/http/http.dart';

part 'module/album.dart';

part 'module/artist.dart';

part 'module/rank.dart';

part 'module/banner.dart';

part 'module/music.dart';

part 'module/mv.dart';

part 'module/play_list.dart';

part 'module/search.dart';

part 'module/url.dart';

class KuWo {
  KuWo._();

  ///Banner
  static Future<Answer> banner() {
    return _banner.call({}, []);
  }

  ///专辑列表
  static Future<Answer> albumList({int? page, int? size}) {
    return _albumList.call({"page": page, "size": size}, []);
  }

  ///专辑详情
  static Future albumInfo({String? albumId, int? page, int? size}) {
    return _albumInfo.call({"albumId": albumId, "page": page, "size": size}, []);
  }

  ///歌单标签
  static Future playListTag() {
    return _playListTag.call({}, []);
  }

  ///歌单列表
  ///tagId,order不共存，优先id
  static Future playList({String? tagId, String? order, int? page, int? size}) {
    return _playList.call({"id": tagId, "order": order, "page": page, "size": size}, []);
  }

  ///歌单详情
  static Future playListInfo({String? id, int? page, int? size}) {
    return _playListInfo.call({"pid": id, "page": page, "size": size}, []);
  }

  ///榜单列表
  static Future rankList() {
    return _rankList.call({}, []);
  }

  ///榜单详情
  static Future rankInfo({String? id, int? page, int? size}) {
    return _rankInfo.call({"id": id, "page": page, "size": size}, []);
  }

  ///歌手详情
  static Future artistList({String? category, int? page, int? size}) {
    return _artistList.call({"category": category, "page": page, "size": size}, []);
  }

  ///歌手详情
  static Future artistInfo({String? artistId}) {
    return _artistInfo.call({"artistId": artistId}, []);
  }

  ///歌手单曲
  static Future artistMusic({String? artistId, int? page, int? size}) {
    return _artistMusic.call({"artistId": artistId, "page": page, "size": size}, []);
  }

  ///歌手专辑
  static Future artistAlbum({String? artistId, int? page, int? size}) {
    return _artistAlbum.call({"artistId": artistId, "page": page, "size": size}, []);
  }

  ///歌手专辑
  static Future artistMv({String? artistId, int? page, int? size}) {
    return _artistMv.call({"artistId": artistId, "page": page, "size": size}, []);
  }

  ///MV列表
  static Future mvList({int? page, int? size}) {
    return _mvList.call({"page": page, "size": size}, []);
  }

  ///播放地址
  static Future playUrl({String? rid, String? format}) {
    return _playUrl.call({"rid": rid, "format": format}, []);
  }

  ///歌曲信息
  static Future musicInfo({String? mid}) {
    return _musicInfo.call({"mid": mid}, []);
  }

  ///歌词
  static Future musicLrc({String? musicId}) {
    return _musicLrc.call({"musicId": musicId}, []);
  }

  ///搜索热词
  static Future searchHot() {
    return _hotSearch.call({}, []);
  }

  ///搜索单曲
  static Future searchMusic({String? key, int? page, int? size}) {
    return _searchMusic.call({"key": key, "page": page, "size": size}, []);
  }

  ///搜索专辑
  static Future searchAlbum({String? key, int? page, int? size}) {
    return _searchAlbum.call({"key": key, "page": page, "size": size}, []);
  }

  ///搜索MV
  static Future searchMv({String? key, int? page, int? size}) {
    return _searchMv.call({"key": key, "page": page, "size": size}, []);
  }

  ///搜索歌单
  static Future searchPlayList({String? key, int? page, int? size}) {
    return _searchPlayList.call({"key": key, "page": page, "size": size}, []);
  }

  ///搜索歌手
  static Future searchArtist({String? key, int? page, int? size}) {
    return _searchArtist.call({"key": key, "page": page, "size": size}, []);
  }

  static Future<Answer> api(String path, {Map? params,List<Cookie> cookie = const []}) {
    if (!_api.containsKey(path)) {
      return Future.value(const Answer().copy(body: {'code': 500, 'msg': "url:“$path”未被定义, 请检查", 'path': _api.keys.toList()}));
    }
    return _api[path]!.call(params ?? {}, cookie);
  }
}

//Api列表
final _api = <String, Api>{
  "/banner": _banner,
  "/album/list": _albumList,
  "/album/info": _albumInfo,
  "/playlist/tag": _playListTag,
  "/playlist": _playList,
  "/playlist/info": _playListInfo,
  "/rank/list": _rankList,
  "/rank/info": _rankInfo,
  "/artist/list": _artistList,
  "/artist/info": _artistInfo,
  "/artist/album": _artistAlbum,
  "/artist/mv": _artistMv,
  "/mv/list": _mvList,
  "/music/url": _playUrl,
  "/music/info": _musicInfo,
  "/music/lrc": _musicLrc,
  "/search/hot": _hotSearch,
  "/search/music": _searchMusic,
  "/search/album": _searchAlbum,
  "/search/mv": _searchMv,
  "/search/playlist": _searchPlayList,
  "/search/artist": _searchArtist,
};

//请求
Future<Answer> _get(String path, {Map<String, dynamic>? params, List<Cookie> cookie = const []}) async {
  Map<String, String> header = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36 Edg/96.0.1054.43",
    "csrf": "SQ6EJ3Q5G6B",
    "Cookie": "kw_token=SQ6EJ3Q5G6B",
    "Referer": "http://www.kuwo.cn/",
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
