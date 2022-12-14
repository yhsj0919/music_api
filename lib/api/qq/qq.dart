import 'dart:convert';
import 'dart:math';
import 'package:music_api/entity/music_entity.dart';
import 'package:music_api/http/http.dart';
import 'package:music_api/utils/answer.dart';
import 'package:music_api/utils/types.dart';
import 'package:universal_io/io.dart';

part 'module/album.dart';

part 'module/home.dart';

part 'module/mv.dart';

part 'module/playlist.dart';

part 'module/radio.dart';

part 'module/rank.dart';

part 'module/search.dart';

part 'module/singer.dart';

part 'module/song.dart';

part 'module/qr.dart';

class QQ {
  QQ._();

  ///首页
  static Future<Answer> home() {
    return _home.call({}, []);
  }

  ///Banner
  static Future<Answer> banner() {
    return _banner.call({}, []);
  }

  ///新专辑、新碟
  static Future<Answer> albumNew({int? area, int? page, int? size}) {
    return _newAlbum.call({"area": area, "page": page, "size": size}, []);
  }

  ///专辑歌曲列表
  static Future<Answer> albumSong({String? albumMid, int? page, int? size}) {
    return _albumSong.call({"albumMid": albumMid, "page": page, "size": size}, []);
  }

  ///专辑信息
  static Future<Answer> albumInfo({String? albumMid, int? page, int? size}) {
    return _albumInfo.call({"albumMid": albumMid, "page": page, "size": size}, []);
  }

  ///mv推荐
  static Future<Answer> mvRec({int? page, int? size}) {
    return _mvRec.call({"page": page, "size": size}, []);
  }

  ///mv列表
  static Future<Answer> mvList({int? version, int? area, int? order, int? page, int? size}) {
    return _mvList.call({"version": version, "area": area, "order": order, "page": page, "size": size}, []);
  }

  ///mv信息
  static Future<Answer> mvInfo({String? vid}) {
    return _mvInfo.call({"vid": vid}, []);
  }

  ///mv播放地址
  static Future<Answer> mvUrl({String? vid}) {
    return _mvUrl.call({"vid": vid}, []);
  }

  ///热门歌单单，
  static Future<Answer> playlistHot() {
    return _playlistHot.call({}, []);
  }

  ///歌单列表，
  static Future<Answer> playlist({int? order, int? page, int? size}) {
    return _playlist.call({"order": order, "page": page, "size": size}, []);
  }

  ///根据tag获取歌单
  static Future<Answer> playlistByTag({int? tag, int? page, int? size}) {
    return _playlistByTag.call({"tag": tag, "page": page, "size": size}, []);
  }

  ///歌单详情
  static Future<Answer> playlistInfo({int? id}) {
    return _playlistInfo.call({"id": id}, []);
  }

  ///全部歌单分类
  static Future<Answer> playlistTag() {
    return _playlistTag.call({}, []);
  }

  ///电台列表
  static Future<Answer> radioList() {
    return _radioList.call({}, []);
  }

  ///电台详情
  static Future<Answer> radioInfo({int? id, int? size, int? first}) {
    return _radioInfo.call({"id": id, "size": size, "first": first}, []);
  }

  ///热门搜索
  static Future<Answer> searchHot() {
    return _searchHot.call({}, []);
  }

  ///搜索建议
  static Future<Answer> searchSuggest({String? keyWord}) {
    return _searchSuggest.call({"keyWord": keyWord}, []);
  }

  ///搜索
  static Future<Answer> search({String? keyWord, int? type, int? page, int? size}) {
    return _search.call({"keyWord": keyWord, "type": type, "page": page, "size": size}, []);
  }

  ///歌手列表
  static Future<Answer> singerList({int? area, int? sex, int? genre, int? index, int? page, int? size}) {
    return _singerList.call({"area": area, "sex": sex, "genre": genre, "index": index, "page": page, "size": size}, []);
  }

  ///歌手详情
  static Future<Answer> singerInfo({String? singerMid}) {
    return _singerInfo.call({"singerMid": singerMid}, []);
  }

  ///歌手详情
  static Future<Answer> singerSong({String? singerMid, int? page, int? size}) {
    return _singerSong.call({"singerMid": singerMid, "page": page, "size": size}, []);
  }

  ///歌手专辑
  static Future<Answer> singerAlbum({String? singerMid, int? page, int? size}) {
    return _singerAlbum.call({"singerMid": singerMid, "page": page, "size": size}, []);
  }

  ///歌手MV
  static Future<Answer> singerMV({String? singerMid, int? page, int? size}) {
    return _singerMV.call({"singerMid": singerMid, "page": page, "size": size}, []);
  }

  ///相似歌手
  static Future<Answer> singerSimilar({String? singerMid}) {
    return _singerSimilar.call({"singerMid": singerMid}, []);
  }

  ///新歌首发
  static Future<Answer> songNew() {
    return _songNew.call({}, []);
  }

  ///歌曲信息
  static Future<Answer> songInfo({String? songMid, int? songId}) {
    return _songInfo.call({"songMid": songMid, "songId": songId}, []);
  }

  ///歌词
  static Future<Answer> songLyric({String? songMid, int? songId}) {
    return _songLyricNew.call({"songMid": songMid, "songId": songId}, []);
  }

  ///歌词
  static Future<Answer> songLyric2({String? songMid, int? songId}) {
    return _songLyric.call({"songMid": songMid, "songId": songId}, []);
  }

  ///相关MV
  static Future<Answer> songMv({String? songMid}) {
    return _songMv.call({"songMid": songMid}, []);
  }

  ///相关歌单
  static Future<Answer> songPlayList({int? songId}) {
    return _songPlayList.call({"songId": songId}, []);
  }

  ///试听地址
  static Future<Answer> songListen({String? songMid, String? mediaMid}) {
    return _songListen.call({"songMid": songMid, "mediaMid": mediaMid}, []);
  }

  ///歌曲下载
  static Future<Answer> songDownload({String? songMid, String? mediaMid}) {
    return _songDownload.call({"songMid": songMid, "mediaMid": mediaMid}, []);
  }

  ///榜单列表
  static Future<Answer> rankList() {
    return _rankList.call({}, []);
  }

  ///榜单详情
  static Future<Answer> rankInfo({int? topId, String? period}) {
    return _rankInfo.call({"topId": topId, "period": period}, []);
  }

  ///mv榜单
  static Future<Answer> mvRank({int? area, String? period}) {
    return _mvRank.call({"area": area, "period": period}, []);
  }

  ///登录二维码
  static Future<Answer> loginQr() {
    return _loginQr.call({}, []);
  }

  ///登录二维码检测
  static Future<Answer> loginQrCheck({required String? qrsig, List<Cookie> cookie = const []}) {
    return _loginQrCheck.call({"qrsig": qrsig}, cookie);
  }

  static Future<Answer> api(String path, {Map? params, List<Cookie> cookie = const []}) {
    if (!_api.containsKey(path)) {
      return Future.value(const Answer(site: MusicSite.QQ).copy(code: 500, msg: "url:“$path”未被定义, 请检查", data: _api.keys.toList()));
    }
    return _api[path]!.call(params ?? {}, cookie);
  }
}

//Api列表
final _api = <String, Api>{
  "/home": _home,
  "/banner": _banner,
  "/album/new": _newAlbum,
  "/album/song": _albumSong,
  "/album/info": _albumInfo,
  "/mv/rec": _mvRec,
  "/mv/list": _mvList,
  "/mv/info": _mvInfo,
  "/mv/url": _mvUrl,
  "/playlist": _playlist,
  "/playlist/hot": _playlistHot,
  "/playlist/bytag": _playlistByTag,
  "/playlist/info": _playlistInfo,
  "/playlist/tag": _playlistTag,
  "/radio/list": _radioList,
  "/radio/info": _radioInfo,
  "/search/hot": _searchHot,
  "/search/suggest": _searchSuggest,
  "/search": _search,
  "/singer/list": _singerList,
  "/singer/info": _singerInfo,
  "/singer/song": _singerSong,
  "/singer/album": _singerAlbum,
  "/singer/mv": _singerMV,
  "/singer/similar": _singerSimilar,
  "/song/new": _songNew,
  "/song/info": _songInfo,
  "/song/lrc2": _songLyric,
  "/song/lrc": _songLyricNew,
  "/song/mv": _songMv,
  "/song/playlist": _songPlayList,
  "/song/url": _songListen,
  "/song/download": _songDownload,
  "/rank/list": _rankList,
  "/rank/info": _rankInfo,
  "/rank/mv": _mvRank,
};

Map<String, String> _buildHeader(String path, List<Cookie> cookies) {
  final headers = {
    "user-agent": "Mozilla/5.0 (Linux; U; Android 11.0.0; zh-cn; MI 11 Build/OPR1.170623.032) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30",
    "cookie": cookies.join("; "),
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

  return Http.get(path, params: params, headers: options).then((value) async {
    try {
      if (value.statusCode == 200) {
        var cookies = value.cookies;
        var ans = const Answer(site: MusicSite.QQ);
        ans = ans.copy(cookie: cookies);
        String content = await value.transform(utf8.decoder).join();
        ans = ans.copy(code: value.statusCode, data: json.decode(content));
        return Future.value(ans);
      } else {
        return Future.error(const Answer(site: MusicSite.QQ, code: 500, msg: "服务异常"));
      }
    } catch (e) {
      return Future.error(const Answer(site: MusicSite.QQ, code: 500, msg: "QQ对象转换异常"));
    }
  });
}

Future<Answer> _getImage(
  String path, {
  Map<String, dynamic> params = const {},
  List<Cookie> cookie = const [],
  Map<String, String> header = const {},
}) async {
  final options = _buildHeader(path, cookie);

  if (header.isNotEmpty) {
    options.addAll(header);
  }

  return Http.get(path, params: params, headers: options).then((value) async {
    try {
      if (value.statusCode == 200) {
        var cookies = value.headers[HttpHeaders.setCookieHeader] ?? [];
        var ans = const Answer(site: MusicSite.QQ);
        ans = ans.copy(cookie: cookies.map((str) => Cookie.fromSetCookieValue(str)).toList());

        var content = base64.encode(await value.first);
        print("data:image/png;base64,$content");

        print(cookies);

        var data = {"domain": "data:image/png;base64,", "qr": content, "qrsig": ans.cookie.where((element) => element.name == "qrsig").first.value};

        ans = ans.copy(code: value.statusCode, data: data);
        return Future.value(ans);
      } else {
        return Future.error(const Answer(site: MusicSite.QQ, code: 500, msg: "服务异常"));
      }
    } catch (e) {
      print(e);
      return Future.error(const Answer(site: MusicSite.QQ, code: 500, msg: "QQ对象转换异常"));
    }
  });
}

Future<Answer> _getString(
  String path, {
  Map<String, dynamic> params = const {},
  List<Cookie> cookie = const [],
  Map<String, String> header = const {},
}) async {
  final options = _buildHeader(path, cookie);

  if (header.isNotEmpty) {
    options.addAll(header);
  }

  return Http.get(path, params: params, headers: options).then((value) async {
    try {
      if (value.statusCode == 200) {
        var cookies = value.headers[HttpHeaders.setCookieHeader] ?? [];
        var ans = const Answer(site: MusicSite.QQ);
        ans = ans.copy(cookie: cookies.map((str) => Cookie.fromSetCookieValue(str)).toList());

        String content = await value.transform(utf8.decoder).join();

        print(content);

        var data = {"data": content};

        ans = ans.copy(code: value.statusCode, data: data);
        return Future.value(ans);
      } else {
        return Future.error(const Answer(site: MusicSite.QQ, code: 500, msg: "服务异常"));
      }
    } catch (e) {
      print(e);
      return Future.error(const Answer(site: MusicSite.QQ, code: 500, msg: "QQ对象转换异常"));
    }
  });
}
