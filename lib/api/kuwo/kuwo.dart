import 'dart:convert';
import 'dart:async';

import 'package:crypto/crypto.dart';
import 'package:music_api/entity/music_entity.dart';
import 'package:music_api/http/http_dio.dart';
import 'package:music_api/utils/answer.dart';
import 'package:music_api/utils/types.dart';
import 'package:music_api/utils/utils.dart';
import 'package:synchronized/synchronized.dart';
import 'package:universal_io/io.dart';
import 'package:uuid/uuid.dart';

import 'kuwoDES.dart';

part 'module/album.dart';

part 'module/artist.dart';

part 'module/banner.dart';

part 'module/music.dart';

part 'module/mv.dart';

part 'module/play_list.dart';

part 'module/rank.dart';

part 'module/search.dart';

part 'module/song.dart';

class KuWo {
  KuWo._();

  ///Banner
  static Future<Answer> banner() {
    return _banner.call({}, []);
  }

  ///最新专辑
  static Future<Answer> albumNew() {
    return _albumNew.call({}, []);
  }

  ///专辑列表
  static Future<Answer> albumList({int? page, int? size}) {
    return _albumList.call({"page": page, "size": size}, []);
  }

  ///专辑详情
  static Future<Answer> albumInfo({String? albumId, int? page, int? size}) {
    return _albumInfo
        .call({"albumId": albumId, "page": page, "size": size}, []);
  }

  ///歌单推荐
  static Future<Answer> playListRec() {
    return _playListRec.call({}, []);
  }

  ///歌单标签
  static Future<Answer> playListTag() {
    return _playListTag.call({}, []);
  }

  ///歌单列表
  ///tagId,order不共存，优先id
  static Future<Answer> playList(
      {String? tagId, String? order, int? page, int? size}) {
    return _playList
        .call({"id": tagId, "order": order, "page": page, "size": size}, []);
  }

  ///歌单详情
  static Future<Answer> playListInfo({String? id, int? page, int? size}) {
    return _playListInfo.call({"id": id, "page": page, "size": size}, []);
  }

  ///歌单详情
  static Future<Answer> playListInfoAll({String? id, int? maxTotal}) {
    return _playListInfoAll.call({"id": id, "maxTotal": maxTotal}, []);
  }

  ///榜单列表
  static Future<Answer> rankList() {
    return _rankList.call({}, []);
  }

  ///榜单详情
  static Future<Answer> rankInfo({String? id, int? page, int? size}) {
    return _rankInfo.call({"id": id, "page": page, "size": size}, []);
  }

  ///榜单详情
  static Future<Answer> rankInfoAll({
    String? id,
  }) {
    return _rankInfoAll.call({"id": id}, []);
  }

  ///歌手详情
  static Future<Answer> artistList({String? category, int? page, int? size}) {
    return _artistList
        .call({"category": category, "page": page, "size": size}, []);
  }

  ///歌手详情
  static Future<Answer> artistInfo({String? artistId}) {
    return _artistInfo.call({"artistId": artistId}, []);
  }

  ///歌手单曲
  static Future<Answer> artistMusic({String? artistId, int? page, int? size}) {
    return _artistMusic
        .call({"artistId": artistId, "page": page, "size": size}, []);
  }

  ///歌手专辑
  static Future<Answer> artistAlbum({String? artistId, int? page, int? size}) {
    return _artistAlbum
        .call({"artistId": artistId, "page": page, "size": size}, []);
  }

  ///歌手专辑
  static Future<Answer> artistMv({String? artistId, int? page, int? size}) {
    return _artistMv
        .call({"artistId": artistId, "page": page, "size": size}, []);
  }

  ///MV列表
  static Future<Answer> mvList({int? page, int? size}) {
    return _mvList.call({"page": page, "size": size}, []);
  }

  ///播放地址
  static Future<Answer> playUrl({String? rid, String? format}) {
    return _playUrl.call({"rid": rid, "format": format}, []);
  }

  static Future<Answer> playUrl2({
    String? rid,
  }) {
    return _playUrl2.call({"rid": rid}, []);
  }

  static Future<Answer> playUrl3({String? rid}) {
    return _playUrl3.call({"rid": rid}, []);
  }

  static Future<Answer> playUrl4({String? rid}) {
    return _playUrl4.call({"rid": rid}, []);
  }

  static Future<Answer> playUrl5({String? rid}) {
    return _playUrl5.call({"rid": rid}, []);
  }

  static Future<Answer> playUrl6({String? rid}) {
    return _playUrl6.call({"rid": rid}, []);
  }

  ///歌词
  static Future<Answer> songLrc({String? rid}) {
    return _songLrc.call({"rid": rid}, []);
  }

  ///新歌
  static Future<Answer> songNew() {
    return _songNew.call({}, []);
  }

  ///歌曲信息
  static Future<Answer> musicInfo({String? mid}) {
    return _musicInfo.call({"mid": mid}, []);
  }

  ///歌词
  static Future<Answer> musicLrc({String? musicId}) {
    return _musicLrc.call({"musicId": musicId}, []);
  }

  ///搜索热词
  static Future<Answer> searchHot() {
    return _hotSearch.call({}, []);
  }

  ///搜索单曲
  static Future<Answer> searchMusic({String? keyWord, int? page, int? size}) {
    return _searchMusic
        .call({"keyWord": keyWord, "page": page, "size": size}, []);
  }

  ///搜索单曲
  static Future<Answer> searchMusic2({String? keyWord, int? page, int? size}) {
    return _searchMusic2
        .call({"keyWord": keyWord, "page": page, "size": size}, []);
  }

  ///搜索专辑
  static Future<Answer> searchAlbum({String? keyWord, int? page, int? size}) {
    return _searchAlbum
        .call({"keyWord": keyWord, "page": page, "size": size}, []);
  }

  ///搜索MV
  static Future<Answer> searchMv({String? keyWord, int? page, int? size}) {
    return _searchMv.call({"keyWord": keyWord, "page": page, "size": size}, []);
  }

  ///搜索歌单
  static Future<Answer> searchPlayList(
      {String? keyWord, int? page, int? size}) {
    return _searchPlayList
        .call({"keyWord": keyWord, "page": page, "size": size}, []);
  }

  ///搜索歌手
  static Future<Answer> searchArtist({String? keyWord, int? page, int? size}) {
    return _searchArtist
        .call({"keyWord": keyWord, "page": page, "size": size}, []);
  }

  static Future<Answer> api(String path,
      {Map? params, List<Cookie> cookie = const []}) {
    if (!_api.containsKey(path)) {
      return Future.value(const Answer(site: MusicSite.KuWo).copy(data: {
        'code': 500,
        'msg': "url:“$path”未被定义, 请检查",
        'path': _api.keys.toList()
      }));
    }
    return _api[path]!.call(params ?? {}, cookie);
  }
}

//Api列表
final _api = <String, Api>{
  "/banner": _banner,
  "/album/list": _albumList,
  "/album/info": _albumInfo,
  "/playlist/rec": _playListRec,
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
  "/song/new": _songNew,
  "/song/url": _playUrl,
  "/song/info": _musicInfo,
  "/music/lrc": _musicLrc,
  "/search/hot": _hotSearch,
  "/search/music": _searchMusic,
  "/search/album": _searchAlbum,
  "/search/mv": _searchMv,
  "/search/playlist": _searchPlayList,
  "/search/artist": _searchArtist,
};

String? tmpKey;
var lock = Lock();

///获取cookie
Future<String> getCookieHmTuvt() async {
  return await lock.synchronized(() async {
    if (tmpKey != null) {
      print('>>>>>>>>>返回默认值>>>>>>>>>>>');
      return Future(() => tmpKey!);
    } else {
      print('>>>>>>>>>触发网络请求>>>>>>>>>>>');
      try {
        var request =
            await HttpClient().getUrl(Uri.parse("http://www.kuwo.cn/"));
        var response = await request.close();
        var cookies = response.headers[HttpHeaders.setCookieHeader];
        tmpKey = Cookie.fromSetCookieValue(cookies?.first ?? "").name;
        return tmpKey!;
      } catch (e) {
        print(e);
        tmpKey = "Hm_Iuvt_cdb524f42f0cer9b268e4v7y735ewrq2324";
        return tmpKey!;
      }
    }
  });
}

//请求
Future<Answer> _get(String path,
    {Map<String, dynamic>? params, List<Cookie> cookie = const []}) async {
  // ...
  var key = await getCookieHmTuvt();

  var hm_token = getRandom(32);
  var hm_Iuvt = getRandom(32);
  var baidu_random = getRandom(32);

  var token_sha1 = sha1.convert(utf8.encode(hm_token)).toString();
  Map<String, String> header = {
    // "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36 Edg/96.0.1054.43",
    "csrf": "SQ6EJ3Q5G6B",
    "Token": md5
        .convert(utf8.encode(KuwoDES.token(baidu_random)))
        .toString()
        .toUpperCase(),
    "cookie":
        "Hm_token=$hm_token;kw_token=${getRandom(11)};$key=$hm_Iuvt;BAIDU_RANDOM=$baidu_random",
    "Cross": md5.convert(utf8.encode(token_sha1)).toString(),
    "Secret": KuwoDES.secret(key, hm_Iuvt),
    "Referer": "http://www.kuwo.cn/",
  };

  if (path.contains("http://nmobi.kuwo.cn/mobi.s")) {
    header.clear();
    header["User-Agent"] = "okhttp/3.10.0";
  }

  if (path.contains("http://mobi.kuwo.cn/mobi.s")) {
    header.clear();
    header["User-Agent"] = "okhttp/3.10.0";
  }

  if (params != null && params.containsKey("reqId") != true) {
    params["reqId"] = const Uuid().v1();
  }
  return HttpDio()
      .get(path, params: params, headers: header)
      .then((value) async {
    try {
      if (value?.statusCode == 200) {
        var cookies = value?.headers[HttpHeaders.setCookieHeader];
        var ans = const Answer(site: MusicSite.KuWo);
        if (cookies != null) {
          ans = ans.copy(
              cookie: cookies
                  .map((str) => Cookie.fromSetCookieValue(str))
                  .toList());
        }

        dynamic data = value?.data;
        try {
          if (value?.data is String) {
            data = json.decode(value?.data.toString().trim() ?? "{}");
          } else {
            data = value?.data;
          }

          ans = ans.copy(code: value?.statusCode, data: data);
          return Future.value(ans);
        } catch (e) {
          ans = ans.copy(code: value?.statusCode, data: {"data": data});
          return Future.value(ans);
        }
      } else {
        return Future.error(Answer(
            site: MusicSite.KuWo,
            code: 500,
            data: {'code': value?.statusCode, 'msg': value}));
      }
    } catch (e) {
      print(e);
      return Future.error(const Answer(
          site: MusicSite.KuWo,
          code: 500,
          data: {'code': 500, 'msg': "酷我对象转换异常"}));
    }
  });
}
