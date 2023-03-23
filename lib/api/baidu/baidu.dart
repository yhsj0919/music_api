import 'dart:collection';
import 'dart:convert';
import 'package:music_api/entity/music_entity.dart';
import 'package:music_api/http/http_dio.dart';
import 'package:universal_io/io.dart';

import 'package:crypto/crypto.dart';
import 'package:music_api/utils/answer.dart';
import 'package:music_api/utils/types.dart';
import 'package:music_api/utils/utils.dart';

part 'module/account.dart';

part 'module/banner.dart';

part 'module/ad.dart';

part 'module/album.dart';

part 'module/artist.dart';

part 'module/rank.dart';

part 'module/favorite.dart';

part 'module/index.dart';

part 'module/oauth.dart';

part 'module/search.dart';

part 'module/song.dart';

part 'module/playlist.dart';

part 'module/user.dart';

part 'module/video.dart';

class Baidu {
  Baidu._();

  ///开屏
  static Future<Answer> openScreen() {
    return _openScreen.call({}, []);
  }

  ///首页
  static Future<Answer> index() {
    return _index.call({}, []);
  }

  ///banner
  static Future<Answer> banner() {
    return _banner.call({}, []);
  }

  ///专辑推荐
  static Future<Answer> albumNew() {
    return _albumNew.call({}, []);
  }

  ///专辑推荐
  static Future<Answer> albumList({int? page, int? size}) {
    return _albumList.call({
      "page": page,
      "size": size,
    }, []);
  }

  ///专辑详情
  static Future<Answer> albumInfo({String? albumAssetCode}) {
    return _albumInfo.call({"albumAssetCode": albumAssetCode}, []);
  }

  ///歌曲列表，新歌推荐
  static Future<Answer> songList({int? page, int? size}) {
    return _songList.call({"page": page, "size": size}, []);
  }

  ///歌曲信息(播放地址。Vip歌曲只能获取30秒)
  static Future<Answer> songInfo({String? tsId, int? rate}) {
    return _songInfo.call({"tsId": tsId, "rate": rate}, []);
  }

  ///歌曲列表，新歌推荐
  static Future<Answer> songDownload({String? tsId, int? rate}) {
    return _songDownload.call({"tsId": tsId, "rate": rate}, []);
  }

  ///歌手列表
  /*
  //  * 歌手列表
  //  * @param page 从1开始
  //  * @param size 默认20
  //  * @param artistGender 性别(男、女、组合、乐队),值是写死的; 这个不传不分页; 这个参数必须在地区之前，不然获取不到值
  //  * @param artistRegion 地区(内地、港台、欧美、韩国、日本、其他),值是写死的,这个不传不分页
  // */
  static Future<Answer> artistList({int? page, int? size, String? artistGender, String? artistRegion}) {
    return _artistList.call({"page": page, "size": size, "artistGender": artistGender, "artistRegion": artistRegion}, []);
  }

  ///歌手详情
  static Future<Answer> artistInfo({String? artistCode}) {
    return _artistInfo.call({"artistCode": artistCode}, []);
  }

  ///歌手热门歌曲
  static Future<Answer> artistSong({String? artistCode, int? page, int? size}) {
    return _artistSong.call({"artistCode": artistCode, "page": page, "size": size}, []);
  }

  ///歌手热门专辑
  static Future<Answer> artistAlbum({String? artistCode, int? page, int? size}) {
    return _artistAlbum.call({"artistCode": artistCode, "page": page, "size": size}, []);
  }

  ///歌手热门视频
  static Future<Answer> artistVideo({String? artistCode, int? page, int? size}) {
    return _artistVideo.call({"artistCode": artistCode, "page": page, "size": size}, []);
  }

  ///搜索
  static Future<Answer> search({String? keyWord, int? page, int? size, int? type}) {
    return _search.call({"keyWord": keyWord, "page": page, "size": size, "type": type}, []);
  }

  ///搜索热词
  static Future<Answer> searchSug({String? word}) {
    return _searchSug.call({"word": word}, []);
  }

  ///榜单分类
  static Future<Answer> rankType() {
    return _rankType.call({}, []);
  }

  ///榜单列表
  static Future<Answer> rankList({String? bdid, int? page, int? size}) {
    return _rankList.call({"bdid": bdid, "page": page, "size": size}, []);
  }

  /// 歌单分类
  static Future<Answer> playlistRec() {
    return _playlistRec.call({}, []);
  }

  /// 歌单分类
  static Future<Answer> playListType() {
    return _playListType.call({}, []);
  }

  ///歌单列表
  static Future<Answer> playList({String? subCateId, int? page, int? size}) {
    return _playList.call({"subCateId": subCateId, "page": page, "size": size}, []);
  }

  ///歌单详情
  static Future<Answer> playListInfo({String? id, int? page, int? size}) {
    return _playListInfo.call({"id": id, "page": page, "size": size}, []);
  }

  ///精选视频
  static Future<Answer> videoList({int? page, int? size}) {
    return _videoList.call({"page": page, "size": size}, []);
  }

  ///视频详情
  static Future<Answer> videoInfo({String? assetCode, String? rate}) {
    return _videoInfo.call({"assetCode": assetCode, "rate": rate}, []);
  }

  ///热门视频、视频推荐
  static Future<Answer> videoRecommend() {
    return _videoRecommend.call({}, []);
  }

  ///视频下载
  static Future<Answer> videoDownload({String? assetCode, String? rate}) {
    return _videoDownload.call({"assetCode": assetCode, "rate": rate}, []);
  }

  ///登出
  static Future<Answer> logout() {
    return _logout.call({}, []);
  }

  ///账户信息
  static Future<Answer> accountInfo({List<Cookie> cookie = const []}) {
    return _accountInfo.call({}, cookie);
  }

  ///修改账户信息
  static Future<Answer> changeAccountInfo({String? age, String? avatar, String? birth, String? nickname, String? sex, String? intro}) {
    return _changeAccountInfo.call({"age": age, "avatar": avatar, "birth": birth, "nickname": nickname, "sex": sex, "intro": intro}, []);
  }

  ///账户歌曲列表(喜欢的歌曲？)
  static Future<Answer> accountSongList({int? page, int? size}) {
    return _accountSongList.call({"page": page, "size": size}, []);
  }

  ///账户收藏等信息
  static Future<Answer> accountAmount() {
    return _accountAmount.call({}, []);
  }

  ///已购专辑
  static Future<Answer> accountPurchaseAlbum({int? page, int? size}) {
    return _accountPurchaseAlbum.call({"page": page, "size": size}, []);
  }

  ///已购单曲
  static Future<Answer> accountPurchase({int? page, int? size}) {
    return _accountPurchase.call({"page": page, "size": size}, []);
  }

  ///收藏
  static Future<Answer> favorite({String? code, String? resType}) {
    return _favorite.call({"code": code, "restype": resType}, []);
  }

  ///取消收藏
  static Future<Answer> favoriteDelete({String? code, String? resType}) {
    return _favoriteDelete.call({"code": code, "restype": resType}, []);
  }

  ///收藏的列表
  static Future<Answer> favoriteList({int? page, int? size}) {
    return _favoriteList.call({"page": page, "size": size}, []);
  }

  ///发送短信验证码
  static Future<Answer> sendSms({String? phone}) {
    return _sendSms.call({"phone": phone}, []);
  }

  ///登录
  static Future<Answer> login({String? phone, String? code}) {
    return _login.call({"phone": phone, "code": code}, []);
  }

  ///签到
  static Future<Answer> signIn({List<Cookie> cookie = const []}) {
    return _signIn.call({}, cookie);
  }

  ///服务使用
  static Future<Answer> api(String path, {Map? params, List<Cookie> cookie = const []}) {
    if (!_api.containsKey(path)) {
      return Future.value(const Answer(site: MusicSite.Baidu).copy(data: {'code': 500, 'msg': "url:“$path”未被定义, 请检查", 'path': _api.keys.toList()}));
    }
    return _api[path]!.call(params ?? {}, cookie);
  }
}

//Api列表
final _api = <String, Api>{
  "/openScreen": _openScreen,
  "/index": _index,
  "/banner": _banner,
  "/album/new": _albumNew,
  "/album/list": _albumList,
  "/album/info": _albumInfo,
  "/song/list": _songList,
  "/song/info": _songInfo,
  "/song/download": _songDownload,
  "/artist/list": _artistList,
  "/artist/info": _artistInfo,
  "/artist/song": _artistSong,
  "/artist/album": _artistAlbum,
  "/artist/video": _artistVideo,
  "/search": _search,
  "/search/sug": _searchSug,
  "/rank/type": _rankType,
  "/rank/list": _rankList,
  "/playlist/type": _playListType,
  "/playlist": _playList,
  "/playlist/info": _playListInfo,
  "/video/list": _videoList,
  "/video/info": _videoInfo,
  "/video/recommend": _videoRecommend,
  "/video/download": _videoDownload,
  "/logout": _logout,
  "/account/info": _accountInfo,
  "/account/info/change": _changeAccountInfo,
  "/account/song/list": _accountSongList,
  "/account/amount": _accountAmount,
  "/account/purchase/album": _accountPurchaseAlbum,
  "/account/purchase": _accountPurchase,
  "/favorite": _favorite,
  "/favorite/delete": _favoriteDelete,
  "/favorite/list": _favoriteList,
  "/sendSms": _sendSms,
  "/login": _login,
  "/signin": _signIn,
};

Map<String, String> _buildHeader(List<Cookie> cookies) {
  final headers = {
    "app-version": "v8.3.0.4",
    "from": "android",
    "user-agent": "Mozilla/5.0 (Linux; U; Android 11.0.0; zh-cn; MI Build/OPR1.170623.032) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30",
  };

  var authorization = cookies.firstWhere((element) => element.name == "auth", orElse: () => Cookie("auth", "")).value;
  if (authorization.isNotEmpty) {
    headers["authorization"] = "/access_token $authorization";
  }

  return headers;
}

///请求,baidu的参数有严格的顺序，错了就请求不到，所以，如果接口里存在appid，不要动，不是随便写的
Future<Answer> _get(String path, {Map<String, dynamic> params = const {}, List<Cookie> cookie = const []}) async {
  final header = _buildHeader(cookie);

  LinkedHashMap signStr = LinkedHashMap();
  if (!params.containsKey("appid")) {
    signStr['appid'] = '16073360';
  } else {
    params['appid'] = '16073360';
  }

  params.forEach((key, value) {
    signStr[key] = value;
  });

  var timestamp = DateTime.now().millisecondsSinceEpoch;
  signStr["timestamp"] = "$timestamp";

  var sign = paramsSign(toParamsString(signStr));

  signStr["sign"] = sign;

  return HttpDio().get(path, params: Map.from(signStr), headers: header).then((value) async {
    try {
      if (value?.statusCode == 200) {
        var cookies = value?.headers[HttpHeaders.setCookieHeader] ?? [];
        var ans = const Answer(site: MusicSite.Baidu);
        ans = ans.copy(cookie: cookies.map((str) => Cookie.fromSetCookieValue(str)).toList());

        ans = ans.copy(code: value?.statusCode, data: value?.data);
        return Future.value(ans);
      } else {
        return Future.error(Answer(site: MusicSite.Baidu, code: 500, data: {'code': value?.statusCode, 'msg': value}));
      }
    } catch (e) {
      return Future.error(const Answer(site: MusicSite.Baidu, code: 500, data: {'code': 500, 'msg': "对象转换异常"}));
    }
  });
}

//请求
Future<Answer> _post(String path, {Map<String, dynamic> params = const {}, List<Cookie> cookie = const []}) async {
  final header = _buildHeader(cookie);

  LinkedHashMap signStr = LinkedHashMap();
  if (!params.containsKey("appid")) {
    signStr['appid'] = '16073360';
  } else {
    params['appid'] = '16073360';
  }
  params.forEach((key, value) {
    signStr[key] = value;
  });

  var timestamp = DateTime.now().millisecondsSinceEpoch;
  signStr["timestamp"] = "$timestamp";

  var sign = paramsSign(toParamsString(signStr));

  signStr["sign"] = sign;

  return HttpDio().postForm(path, params: Map.from(signStr), headers: header).then((value) async {
    try {
      if (value?.statusCode == 200) {
        var cookies = value?.headers[HttpHeaders.setCookieHeader] ?? [];
        var ans = const Answer(site: MusicSite.Baidu);
        ans = ans.copy(cookie: cookies.map((str) => Cookie.fromSetCookieValue(str)).toList());

        ans = ans.copy(code: value?.statusCode, data:json.decode(value?.data.toString()??"{}"));
        return Future.value(ans);
      } else {
        return Future.value(Answer(site: MusicSite.Baidu, code: 500, data: {'code': value?.statusCode, 'msg': value}));
      }
    } catch (e) {
      return Future.value(const Answer(site: MusicSite.Baidu, code: 500, data: {'code': 500, 'msg': "百度对象转换异常"}));
    }
  });
}

String paramsSign(String params) {
  const secret = "0b50b02fd0d73a9c4c8c3a781c30845f";
  return md5.convert(utf8.encode("$params$secret")).toString();
}
