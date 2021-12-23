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

part 'module/rank.dart';

class MiGu {
  ///u.musicapp.migu.cn,新版换了域名7.7.0
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

  ///专辑详情2
  static Future albumInfo2({String? albumId}) {
    return _albumInfo2.call({"albumId": albumId}, []);
  }

  ///mv信息
  static Future mvInfo({String? mvId}) {
    return _mvInfo.call({"mvId": mvId}, []);
  }

  ///专辑详情
  static Future mvPlayUrl({required String? contentId, required String? mvCopyrightId, required String? format, required String? size, String? type, required String? url}) {
    return _mvPlayUrl.call({"contentId": contentId, "mvCopyrightId": mvCopyrightId, "format": format, "size": size, "type": type, "url": url}, []);
  }

  ///mv推荐
  static Future mvRec({String? mvId, String? page}) {
    return _mvRec.call({"mvId": mvId, "page": page}, []);
  }

  ///歌单推荐，web
  static Future playListNewWeb() {
    return _playListNewWeb.call({}, []);
  }

  ///歌单热门标签
  static Future playListHotTag() {
    return _playListHotTag.call({}, []);
  }

  ///歌单热门推荐(歌单最顶上的几个)
  static Future playListRec() {
    return _playListRec.call({}, []);
  }

  ///歌单列表
  static Future playList({String? tagId, int? page}) {
    return _playList.call({"tagId": tagId, "page": page}, []);
  }

  ///歌单标签列表
  static Future playListTagList() {
    return _playListTagList.call({}, []);
  }

  ///歌单信息
  static Future playListInfo({required String? id, String? resourceType}) {
    return _playListInfo.call({"id": id, "resourceType": resourceType}, []);
  }

  ///歌单歌曲
  static Future playListSong({required String? id, int? page, int? size}) {
    return _playListSong.call({"id": id, "page": page, "size": size}, []);
  }

  ///歌单播放量
  static Future playListPlayNum({List<String> contentIds = const [], List<String> contentTypes = const []}) {
    return _playListPlayNum.call({"contentIds": contentIds, "contentTypes": contentTypes}, []);
  }

  ///新歌(web)
  static Future songNewWeb({int? page, int? size}) {
    return _songNewWeb.call({"page": page, "size": size}, []);
  }

  ///新歌类型
  static Future songNewType() {
    return _songNewType.call({}, []);
  }

  ///新歌
  static Future songNew({required String? columnId, int? page, int? size}) {
    return _songNew.call({"columnId": columnId, "page": page, "size": size}, []);
  }

  ///播放地址
  static Future playUrl({required String? songId, String? toneFlag}) {
    return _playUrl.call({"songId": songId, "toneFlag": toneFlag}, []);
  }

  ///榜单
  static Future rankList() {
    return _rankList.call({}, []);
  }

  ///榜单
  static Future rankDetail({required String? rankId}) {
    return _rankDetail.call({"rankId": rankId}, []);
  }

  ///歌手标签
  static Future singerTabs() {
    return _singerTabs.call({}, []);
  }

  ///歌手列表
  static Future singer({String? tab}) {
    return _singer.call({"tab": tab}, []);
  }

  ///歌手信息
  static Future singerInfo({required String? id}) {
    return _singerInfo.call({"id": id}, []);
  }

  ///歌手单曲
  static Future singerSongs({required String? id, int? page, int? size}) {
    return _singerSongs.call({"id": id, "page": page, "size": size}, []);
  }

  ///歌手专辑
  static Future singerAlbum({required String? id, int? page, int? size}) {
    return _singerAlbum.call({"id": id, "page": page, "size": size}, []);
  }

  ///歌手MV
  static Future singerMv({required String? id, int? page, int? size}) {
    return _singerMv.call({"id": id, "page": page, "size": size}, []);
  }

  ///搜索热词
  static Future searchHotWord() {
    return _searchHotWord.call({}, []);
  }

  ///搜索
  static Future search({required String? keyword, int? type}) {
    return _search.call({"keyword": keyword, "type": type}, []);
  }

  ///搜索
  static Future searchSuggest({required String? keyword}) {
    return _searchSuggest.call({"keyword": keyword}, []);
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

Future<Answer> _get(String path, {Map<String, dynamic> params = const {}, List<Cookie> cookie = const [], Map<String, String> header = const {}}) async {
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
