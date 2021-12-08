part of '../baidu.dart';

/*
 * 歌手列表
 * @param page 从1开始
 * @param size 默认20
 * @param artistGender 性别(男、女、组合、乐队),值是写死的; 这个不传不分页; 这个参数必须在地区之前，不然获取不到值
 * @param artistRegion 地区(内地、港台、欧美、韩国、日本、其他),值是写死的,这个不传不分页
*/
Future<Answer> _artistList(Map params, List<Cookie> cookie) {
  LinkedHashMap<String, dynamic> data = LinkedHashMap();
  if (params["artistGender"] != null) {
    data["artistGender"] = params['artistGender'];
  }
  if (params["artistRegion"] != null) {
    data["artistRegion"] = params['artistRegion'];
  }

  if (data.isNotEmpty) {
    data["pageNo"] = params['page'] ?? 1;
    data["pageSize"] = params['size'] ?? 20;
  }
  return _get(
    "https://api-qianqian.taihe.com/v1/artist/list",
    params: data,
    cookie: cookie,
  );
}

/*
 * 歌手详情
 * @param artistCode 歌手Id
*/
Future<Answer> _artistInfo(Map params, List<Cookie> cookie) {
  return _get("https://api-qianqian.taihe.com/v1/artist/info",
      params: LinkedHashMap.of({
        "artistCode": params['artistCode'],
      }),
      cookie: cookie);
}

/*
 * 歌手热门歌曲
 * @param artistCode 歌手Id
*/
Future<Answer> _artistSong(Map params, List<Cookie> cookie) {
  return _get("https://api-qianqian.taihe.com/v1/artist/song",
      params: LinkedHashMap.of({
        'appid': '16073360',
        "artistCode": params['artistCode'],
        "pageNo": params['page'] ?? 1,
        "pageSize": params['size'] ?? 20,
      }),
      cookie: cookie);
}

/*
 * 歌手热门专辑
 * @param artistCode 歌手Id
*/
Future<Answer> _artistAlbum(Map params, List<Cookie> cookie) {
  return _get("https://api-qianqian.taihe.com/v1/artist/album",
      params: LinkedHashMap.of({
        'appid': '16073360',
        "artistCode": params['artistCode'],
        "pageNo": params['page'] ?? 1,
        "pageSize": params['size'] ?? 20,
      }),
      cookie: cookie);
}

/*
 * 歌手热门视频
 * @param artistCode 歌手Id
*/
Future<Answer> _artistVideo(Map params, List<Cookie> cookie) {
  return _get("https://api-qianqian.taihe.com/v1/artist/video",
      params: LinkedHashMap.of({
        'appid': '16073360',
        "artistCode": params['artistCode'],
        "pageNo": params['page'] ?? 1,
        "pageSize": params['size'] ?? 20,
      }),
      cookie: cookie);
}
