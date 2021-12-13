part of '../kugou.dart';

///新歌推荐
Future<Answer> _musicList(Map params, List<Cookie> cookie) {
  return _get(
    "https://m.kugou.com",
    params: {
      "json": "true",
    },
    cookie: cookie,
  ).then((value) {
    var body = value.body;
    body.remove("banner");
    return Future.value(value.copy(body: body));
  });
}

///歌曲信息
Future<Answer> _musicInfo(Map params, List<Cookie> cookie) {
  return _get(
    "https://wwwapi.kugou.com/yy/index.php?r=play/getdata",
    params: {
      "hash": params["hash"],
      "album_audio_id": params["album_audio_id"],
    },
    cookie: cookie,
  );
}
//
// ///歌词
// Future<Answer> _musicLrc(Map params, List<Cookie> cookie) {
//   return _get(
//     "http://m.kuwo.cn/newh5/singles/songinfoandlrc",
//     params: {
//       "musicId": params["musicId"],
//     },
//     cookie: cookie,
//   );
// }
