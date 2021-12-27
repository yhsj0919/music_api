import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:music_api/api/utils/answer.dart';
import 'package:music_api/api/utils/types.dart';
import 'package:music_api/api/utils/utils.dart';

part 'module/album.dart';

part 'module/home.dart';

part 'module/mv.dart';

part 'module/playlist.dart';

part 'module/radio.dart';

part 'module/search.dart';

part 'module/singer.dart';

part 'module/song.dart';

part 'module/rank.dart';

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

  ///mv列表
  static Future mvList({int? version, int? area, int? order, int? page, int? size}) {
    return _mvList.call({"version": version, "area": area, "order": order, "page": page, "size": size}, []);
  }

  ///mv信息
  static Future mvInfo({String? vid}) {
    return _mvInfo.call({"vid": vid}, []);
  }

  ///mv播放地址
  static Future mvUrl({String? vid}) {
    return _mvUrl.call({"vid": vid}, []);
  }

  ///歌单列表，
  static Future playlist({int? order, int? page, int? size}) {
    return _playlist.call({"order": order, "page": page, "size": size}, []);
  }

  ///根据tag获取歌单
  static Future playlistByTag({int? tag, int? page, int? size}) {
    return _playlistByTag.call({"tag": tag, "page": page, "size": size}, []);
  }

  ///歌单详情
  static Future playlistDetail({int? id}) {
    return _playlistDetail.call({"id": id}, []);
  }

  ///全部歌单分类
  static Future playlistTag() {
    return _playlistTag.call({}, []);
  }

  ///电台列表
  static Future radioList() {
    return _radioList.call({}, []);
  }

  ///电台详情
  static Future radioDetail({int? id, int? size, int? first}) {
    return _radioDetail.call({"id": id, "size": size, "first": first}, []);
  }

  ///热门搜索
  static Future searchHot() {
    return _searchHot.call({}, []);
  }

  ///搜索建议
  static Future searchSuggest({String? keyWord}) {
    return _searchSuggest.call({"keyWord": keyWord}, []);
  }

  ///搜索
  static Future search({String? keyWord}) {
    return _search.call({"keyWord": keyWord}, []);
  }

  ///歌手列表
  static Future singerList({int? area, int? sex, int? genre, int? index, int? page, int? size}) {
    return _singerList.call({"area": area, "sex": sex, "genre": genre, "index": index, "page": page, "size": size}, []);
  }

  ///歌手详情
  static Future singerInfo({String? singerMid}) {
    return _singerInfo.call({"singerMid": singerMid}, []);
  }

  ///歌手详情
  static Future singerSong({String? singerMid, int? page, int? size}) {
    return _singerSong.call({"singerMid": singerMid, "page": page, "size": size}, []);
  }

  ///歌手专辑
  static Future singerAlbum({String? singerMid, int? page, int? size}) {
    return _singerAlbum.call({"singerMid": singerMid, "page": page, "size": size}, []);
  }

  ///歌手MV
  static Future singerMV({String? singerMid, int? page, int? size}) {
    return _singerMV.call({"singerMid": singerMid, "page": page, "size": size}, []);
  }

  ///相似歌手
  static Future singerSimilar({String? singerMid}) {
    return _singerSimilar.call({"singerMid": singerMid}, []);
  }

  ///歌曲信息
  static Future songInfo({String? songMid, int? songId}) {
    return _songInfo.call({"songMid": songMid, "songId": songId}, []);
  }

  ///歌词
  static Future songLyric({String? songMid, int? songId}) {
    return _songLyric.call({"songMid": songMid, "songId": songId}, []);
  }

  ///歌词
  static Future songLyric2({String? songMid, int? songId}) {
    return _songLyricNew.call({"songMid": songMid, "songId": songId}, []);
  }

  ///相关MV
  static Future songMv({String? songMid}) {
    return _songMv.call({"songMid": songMid}, []);
  }

  ///相关歌单
  static Future songPlayList({int? songId}) {
    return _songPlayList.call({"songId": songId}, []);
  }

  ///试听地址
  static Future songListen({String? songMid, String? mediaMid}) {
    return _songListen.call({"songMid": songMid, "mediaMid": mediaMid}, []);
  }

  ///歌曲下载
  static Future songDownload({String? songMid, String? mediaMid}) {
    return _songDownload.call({"songMid": songMid, "mediaMid": mediaMid}, []);
  }

  ///榜单列表
  static Future rankList() {
    return _rankList.call({}, []);
  }

  ///榜单详情
  static Future rankInfo({int? topId, String? period}) {
    return _rankInfo.call({"topId": topId, "period": period}, []);
  }

  ///mv榜单
  static Future mvRank({int? area, String? period}) {
    return _mvRank.call({"area": area, "period": period}, []);
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
    headers['Referer'] = 'https://y.qq.com/';
  }
  return headers;
}

Future<Answer> _get(
  String path, {
  Map<String, dynamic> params = const {},
  List<Cookie> cookie = const [],
  Map<String, String> header = const {},
}) async {
  final options = _buildHeader(path, cookie);

  if (header.isNotEmpty) {
    options.addAll(header);
  }

  return _httpGet(path, params: params, headers: options).then((value) async {
    try {
      if (value.statusCode == 200) {
        var cookies = value.cookies;
        var ans = const Answer();
        ans = ans.copy(cookie: cookies);
        String content = await value.transform(utf8.decoder).join();
        ans = ans.copy(status: value.statusCode, body: json.decode(content));
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
