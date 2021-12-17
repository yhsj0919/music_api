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
  //http://trackercdn.kugou.com/i/v2/?cmd=26&pid=4&hash=6E168B3349A4CB833CDD10A9BA1E7327&key=86c8f9eb1ed74ea9684165cca6d31acb&behavior=play&appid=3238&mid=1fbf760909b864a20361065451df36db&version=151&vipType=0&album_id=51227378
  return _get(
    "https://wwwapi.kugou.com/yy/index.php?r=play/getdata",
    params: {
      "hash": params["hash"],
      "album_audio_id": params["albumAudioId"],
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
