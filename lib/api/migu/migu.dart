import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

import 'package:music_api/api/utils/answer.dart';
import 'package:music_api/api/utils/types.dart';
import 'package:music_api/http/http.dart';
import 'package:uuid/uuid.dart';

part 'module/album.dart';

part 'module/banner.dart';

part 'module/mv.dart';

part 'module/playList.dart';

part 'module/rank.dart';

part 'module/search.dart';

part 'module/singer.dart';

part 'module/song.dart';

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
  static Future rankInfo({required String? rankId}) {
    return _rankInfo.call({"rankId": rankId}, []);
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

  ///搜索建议
  static Future searchSuggest({required String? keyword}) {
    return _searchSuggest.call({"keyword": keyword}, []);
  }

  static Future<Answer> api(String path, {Map? params, List<Cookie> cookie = const []}) {
    if (!_api.containsKey(path)) {
      return Future.value(const Answer().copy(body: {'code': 500, 'msg': "url:“$path”未被定义, 请检查", 'path': _api.keys.toList()}));
    }
    return _api[path]!.call(params ?? {}, cookie);
  }
}

//Api列表
final _api = <String, Api>{
  "/banner": _banner,
  "/album/new/web": _albumNewWeb,
  "/album/new/type": _albumNewType,
  "/album/new": _albumNew,
  "/album/song": _albumSong,
  "/album/song2": _albumSong2,
  "/album/info": _albumInfo,
  "/album/info2": _albumInfo2,
  "/mv/info": _mvInfo,
  "/mv/url": _mvPlayUrl,
  "/mv/rec": _mvRec,
  "/playlist/new/web": _playListNewWeb,
  "/playlist/tag/hot": _playListHotTag,
  "/playlist/rec": _playListRec,
  "/playlist": _playList,
  "/playlist/tag/list": _playListTagList,
  "/playlist/info": _playListInfo,
  "/playlist/song": _playListSong,
  "/playlist/play/num": _playListPlayNum,
  "/song/new/web": _songNewWeb,
  "/song/new/type": _songNewType,
  "/song/new": _songNew,
  "/song/url": _playUrl,
  "/rank/list": _rankList,
  "/rank/info": _rankInfo,
  "/singer/tabs": _singerTabs,
  "/singer/list": _singer,
  "/singer/info": _singerInfo,
  "/singer/songs": _singerSongs,
  "/singer/album": _singerAlbum,
  "/singer/mv": _singerMv,
  "/search/hot": _searchHotWord,
  "/search": _search,
  "/search/suggest": _searchSuggest,
};

Map<String, String> _buildHeader(String path, List<Cookie> cookies) {
  final headers = {
    "user-agent": "Mozilla/5.0 (Linux; U; Android 11.0.0; zh-cn; MI 11 Build/OPR1.170623.032) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30",
    "channel": "0146921",
    "Cookie": cookies.join("; "),
  };

  if (path.contains('m.music.migu.cn')) {
    headers['Referer'] = 'https://m.music.migu.cn/';
  }
  if (path.contains('app.c.nf.migu.cn')) {
    headers['Referer'] = 'https://app.c.nf.migu.cn/';
  }

  return headers;
}

Future<Answer> _get(String path, {Map<String, dynamic> params = const {}, List<Cookie> cookie = const [], Map<String, String> header = const {}}) async {
  final headers = _buildHeader(path, cookie);

  if (header.isNotEmpty) {
    headers.addAll(header);
  }

  return Http.get(path, params: params, headers: headers).then((value) async {
    try {
      if (value.statusCode == 200) {
        var cookies = value.headers[HttpHeaders.setCookieHeader] ?? [];
        var ans = const Answer();
        ans = ans.copy(cookie: cookies.map((str) => Cookie.fromSetCookieValue(str)).toList());
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
